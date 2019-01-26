import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_counter/models/todo.dart';
import 'package:redux_counter/redux/actions.dart';
import 'package:redux_counter/redux/reducers.dart';
import 'package:redux_counter/redux/view_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final store = Store<ListState>(
    reducer,
    initialState: ListState.initialState(),
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider<ListState>(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Redux Todo',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Redux Todo'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListInput(),
            ),
            ViewList(),
          ],
        ),
      ),
    );
  }
}

class ListInput extends StatefulWidget {
  _ListInputState createState() => _ListInputState();
}

class _ListInputState extends State<ListInput> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StoreConnector<ListState, ViewModel>(
      converter: (store) => ViewModel(
            addItemToList: (inputText) => store.dispatch(
                  AddAction(
                    todo: Todo(todo: inputText),
                  ),
                ),
          ),
      builder: (context, viewModel) {
        return TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Enter Todo ...',
          ),
          onSubmitted: (text) {
            viewModel.addItemToList(text);
            controller.clear();
          },
        );
      },
    );
  }
}

class ViewList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<ListState, ViewModel>(
      converter: (store) => ViewModel(
            todos: store.state.todos,
            toggleDoneItem: (todo) => store.dispatch(
                  ToggleDoneAction(todo: todo),
                ),
            deleteItem: (todo) => store.dispatch(
                  DeleteAction(todo: todo),
                ),
          ),
      builder: (context, viewModel) {
        return Column(
          children: viewModel.todos
              .map(
                (item) => Dismissible(
                      key: Key(item.todo),
                      onDismissed: (direction) {
                        viewModel.deleteItem(item);
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${item.todo} dismissed'),
                          ),
                        );
                      },
                      background: Container(
                        color: Colors.red,
                      ),
                      child: ListTile(
                        leading: new Checkbox(
                          value: item.isDone,
                          onChanged: (val) => viewModel.toggleDoneItem(item),
                        ),
                        title: Text(
                          item.todo,
                          style: TextStyle(
                            decoration: (item.isDone)
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
              )
              .toList(),
        );
      },
    );
  }
}

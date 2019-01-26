import 'package:redux_counter/models/todo.dart';

typedef AddItem(String item);
typedef ToggleDoneItem(Todo index);
typedef DeleteItem(Todo item);

class ViewModel {
  final List<Todo> todos;

  final AddItem addItemToList;
  final ToggleDoneItem toggleDoneItem;
  final DeleteItem deleteItem;
  ViewModel(
      {this.todos, this.addItemToList, this.toggleDoneItem, this.deleteItem});
}

import 'package:redux_counter/models/todo.dart';
import 'package:redux_counter/redux/actions.dart';

// State
class ListState {
  final List<Todo> todos;
  ListState({this.todos});

  ListState.initialState() : todos = List.unmodifiable([]);
}

// Reducers
ListState reducer(ListState state, action) {
  if (action is AddAction) {
    return ListState(
        todos: []
          ..addAll(state.todos)
          ..add(action.todo));
  }
  if (action is ToggleDoneAction) {
    var todos = state.todos;
    int index = todos.indexOf(action.todo);
    todos[index].isDone = !todos[index].isDone;
    return ListState(todos: todos);
  }
  if (action is DeleteAction) {
    var todos = state.todos;
    todos.removeWhere((todo) => todo == action.todo);
    return ListState(todos: todos);
  }
  return ListState(todos: state.todos);
}

import 'package:redux_counter/models/todo.dart';

class AddAction {
  final Todo todo;
  AddAction({this.todo});
}

class ToggleDoneAction {
  final Todo todo;
  ToggleDoneAction({this.todo});
}

class DeleteAction {
  final Todo todo;
  DeleteAction({this.todo});
}

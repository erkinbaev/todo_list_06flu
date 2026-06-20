
import 'package:todo_list_06flu/database/app_repository.dart';
import 'package:todo_list_06flu/database/todo.dart';

class AddViewModel {
  final AppRepositoryImpl repo;

  AddViewModel({required this.repo});

  void addTodo(String title) {
    final todo = Todo(id: 5, title: title, createdAt: DateTime.now().toString(), isDone: false);
    repo.addTodo(todo);
  }
}
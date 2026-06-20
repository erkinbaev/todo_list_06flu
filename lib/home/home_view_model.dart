
import 'package:todo_list_06flu/database/app_repository.dart';
import 'package:todo_list_06flu/database/todo.dart';

class HomeViewModel {
  final AppRepositoryImpl repo;
  List<Todo> todoList = [];

  HomeViewModel({required this.repo});

  void getTodoList() {
    todoList = repo.getTodoList();
  }
}
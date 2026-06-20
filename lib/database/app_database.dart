import 'package:todo_list_06flu/database/todo.dart';

class AppDatabase {
  //mock - временные данные для тестирования
  List<Todo> _todoList = [
    Todo(id: 1, title: "Записаться на курсы flutter", createdAt: "01.04.2026", isDone: true),
    Todo(id: 2, title: "Прочесть книгу Война и Мир", createdAt: "31.12.2025", isDone: false),
    Todo(id: 3, title: "Купить новый телефон", createdAt: "12.12.2025", isDone: true),
    Todo(id: 4, title: "Посмотреть сериал Пацаны", createdAt: "10.09.2025", isDone: false)
  ]; 

//CRUD operations

//READ - считать записи
  List<Todo> getTodoList() {
    return _todoList;
  }

//CREATE - сделать запись
  void addTodo(Todo todo) {
    _todoList.insert(0, todo);
  }

//UPDATE - обновить записи


//DELETE - удалить записи
}
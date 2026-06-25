import 'package:todo_list_06flu/database/todo.dart';
import 'package:hive/hive.dart';

class AppDatabase {
  //создаем таблицу для наших задач
  final Box box = Hive.box('todoBox');

  List<Todo> _todoList = []; 

  AppDatabase() {
    //при инициализации класса AppDatabase, подгружаем данные
    loadTodos();
  }

  void loadTodos() {
    //берем данные из таблицы и достаем список задач
    final data = box.get('todos', defaultValue: []);

    //превращаем в объекты дарт читаемые для нашей платформы
    _todoList = List<Map>.from(data).map( (e) {
      return Todo(id: e['id'], title: e['title'], createdAt: e['createdAt'], isDone: e['isDone']);
    }).toList();
  }

  void saveTodos() {
    //прежде чем положить, превращаем наши объекты в тип, который используется в hive
    final data = _todoList.map( (todo) {
      return {
        "id": todo.id,
        "title": todo.title,
        "isDone": todo.isDone,
        "createdAt": todo.createdAt
      };
    }).toList();

    box.put('todos', data);
  }

//CRUD operations

//READ - считать записи
  List<Todo> getTodoList() {
    return _todoList;
  }

//CREATE - сделать запись
  void addTodo(Todo todo) {
    _todoList.insert(0, todo);
    saveTodos();
  }

//UPDATE - обновить записи
  void updateTodo(int index, String title) {
    _todoList[index].title = title;
    saveTodos();
  }

//DELETE - удалить записи
  void deleteTodo(int index) {
    _todoList.removeAt(index);
    saveTodos();
  }
}
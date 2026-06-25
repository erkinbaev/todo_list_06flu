
import 'package:flutter/material.dart';
import 'package:todo_list_06flu/add/add_page.dart';
import 'package:todo_list_06flu/database/app_database.dart';
import 'package:todo_list_06flu/database/app_repository.dart';
import 'dart:math';

import 'package:todo_list_06flu/database/todo.dart';
import 'package:todo_list_06flu/details/todo_detail_page.dart';
import 'package:todo_list_06flu/home/home_view_model.dart';
import 'package:todo_list_06flu/settings/settings_page.dart';

class MyHomePage extends StatefulWidget {
  final bool isDarkTheme;
  final Function(bool) onThemeChanged;
  const MyHomePage({super.key, required this.title, required this.isDarkTheme, required this.onThemeChanged});

  final String title;

//выделить память для экрана
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final HomeViewModel vm;
  late final AppDatabase db;

  //инициализация в памяти(создается в памяти)
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Home page - initState");
    //Подгружать данные
    //Начинать таймеры, анимации и т.д
    //Давать значения тем переменным еще нет значения

    //объект1
    db = AppDatabase();
    final repo = AppRepositoryImpl(db: db);
    vm = HomeViewModel(repo: repo);
    vm.getTodoList();
  }



  //прорисовка интерфейса
  @override
  Widget build(BuildContext context) {
    print("Home page - build");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [IconButton(onPressed: _navigateToSettingsPage, icon: Icon(Icons.settings))],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: vm.todoList.length,
          itemBuilder: (context, index) {
            final title = vm.todoList[index].title;
            return ListTile(title: Text(title), onTap: () => _navigateToDetailsPage(index));
          }
          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddPage,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _navigateToAddPage() async {
    final result = await Navigator.of(context).push(MaterialPageRoute(builder: (_) => AddPage(database: db)));
    if (result != null) {
      setState(() {
         vm.getTodoList();
      });
    }
  }

  void _navigateToSettingsPage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => SettingsPage(isDarkTheme: widget.isDarkTheme, onThemeChanged: widget.onThemeChanged)));
  }
  
  void _navigateToDetailsPage(int index) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => TodoDetailPage(index: index)));  
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }

  //уничтожает виджет с памяти
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("Home page - dispose");
    //останавливать таймеры, либо анимации
    //stream - подписки
  }
}


extension on Random {
  void nextInt(int lenth) {

  }
}
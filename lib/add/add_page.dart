import 'package:flutter/material.dart';
import 'dart:async';

import 'package:todo_list_06flu/add/add_view_model.dart';
import 'package:todo_list_06flu/database/app_database.dart';
import 'package:todo_list_06flu/database/app_repository.dart';

class AddPage extends StatefulWidget{
  final AppDatabase database;

  const AddPage({super.key, required this.database});

  @override
  State<StatefulWidget> createState() => _AddPageState();
}


class _AddPageState extends State<AddPage> {
  late final AddViewModel vm;
  late final AppDatabase db;

  TextEditingController _controller = TextEditingController();
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    db = widget.database;
    final repo = AppRepositoryImpl(db: db);
    vm = AddViewModel(repo: repo);
  }

  @override
  Widget build(BuildContext context) {
    print("Add page - build");
    return Scaffold(
      appBar: AppBar(
        title: Text("Новая задача")
        ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Введите название задачи")
              ),
            ),
            TextButton(onPressed: _saveTodo, child: Text("Сохранить"))
          ],
        ),
      ),
    );
  }

  void _saveTodo() {
    vm.addTodo(_controller.text);
    Navigator.pop(context, _controller.text);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
}

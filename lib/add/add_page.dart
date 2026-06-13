import 'package:flutter/material.dart';
import 'dart:async';

class AddPage extends StatefulWidget{

  const AddPage({super.key});

  @override
  State<StatefulWidget> createState() => _AddPageState();
}


class _AddPageState extends State<AddPage> {
  TextEditingController _controller = TextEditingController();
  late Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Add page - initState");
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final date = DateTime.now();
      print("${date.minute}: ${date.second}");
    });
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
    Navigator.pop(context, _controller.text);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
    _controller.dispose();
    print("Add page - dispose");
  }
}
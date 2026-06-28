import 'package:flutter/material.dart';
import 'dart:async';

import 'package:todo_list_06flu/add/add_view_model.dart';
import 'package:todo_list_06flu/database/app_database.dart';
import 'package:todo_list_06flu/database/app_repository.dart';

class AddPage extends StatefulWidget {
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
      appBar: AppBar(title: Text("Новая задача")),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Введите название задачи"),
              ),
            ),
            TextButton(onPressed: _saveTodo, child: Text("Сохранить")),
          ],
        ),
      ),
    );
  }

  //option + "shift" + "f"
  Future _saveTodo() async {
    String title = _controller.text;
    try {
      if (title.isEmpty) {
        throw EmptyTitleException("Введите название задачи");
      } else if (title.length > 30) {
        throw LongTitleException("Максимальное количество символов: 30");
      } else {
        vm.addTodo(_controller.text);
        showAppSnackBar(context, text: "Задача сохранена!", backgroundColor: Colors.green, icon: Icons.check);
        await Future.delayed(Duration(seconds: 2));
        Navigator.pop(context, _controller.text);
      }
    } catch (e) {
      showAppSnackBar(context, text: e.toString(), backgroundColor: Colors.red, icon: Icons.warning);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  Future <void> showAppSnackBar(
  BuildContext context, {
  required String text,
  Color? backgroundColor,
  IconData? icon,
  VoidCallback? onRetry,
  String retryText = "Повторить",
}) async {
  final messenger = ScaffoldMessenger.of(context);

  messenger.hideCurrentSnackBar();
  messenger.showSnackBar(
    SnackBar(
      content: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: Colors.white),
            const SizedBox(width: 12),
          ],
          Expanded(child: Text(text, style: TextStyle(color: Colors.white))),
        ],
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      duration: const Duration(seconds: 2),
      action: onRetry == null
          ? null
          : SnackBarAction(
              label: retryText,
              onPressed: onRetry,
              textColor: Colors.white,
            ),
    ),
  );
  }
}

//implements значит подписаться на какой-то интерфейс и реализовывать методы
class EmptyTitleException implements Exception {
  final String message;

  EmptyTitleException(this.message);

  @override
  String toString() {
    // TODO: implement toString
    return '$message';
  }
}

class LongTitleException implements Exception {
  final String message;

  LongTitleException(this.message);

  @override
  String toString() {
    // TODO: implement toString
    return '$message';
  }
}

// class Car implements Media {
//   @override
//   void play() {
//     // TODO: implement play
//     print("play music");
//   }
// }

// class Phone implements Media {
//   @override
//   void play() {
//     // TODO: implement play
//     print("play video");
//   }
// }

// class Media {
//   void play() {
//   }

// }

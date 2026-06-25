import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list_06flu/home/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await SharedPreferences.getInstance();
  final isDarkTheme = preferences.getBool('isDarkTheme') ?? false;
  print("темная тема: $isDarkTheme");

//не запускать приложение без не подгруженных данных
  await Hive.initFlutter();
  await Hive.openBox('todoBox');

  //await HiveFlutter.init();

  runApp(MyApp(isDarkTheme: isDarkTheme));
}

class MyApp extends StatefulWidget {
  final bool isDarkTheme;
  const MyApp({super.key, required this.isDarkTheme});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool _isDarkTheme;
  // This widget is the root of your application.
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isDarkTheme = widget.isDarkTheme;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      home: MyHomePage(title: 'Flutter Demo Home Page', isDarkTheme: _isDarkTheme, onThemeChanged: changeTheme),
    );
  }

  void changeTheme(bool value) {
    setState(() {
      _isDarkTheme = value;
    });
  }
}


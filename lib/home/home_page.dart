
import 'package:flutter/material.dart';
import 'package:todo_list_06flu/add/add_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

//выделить память для экрана
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  //инициализация в памяти(создается в памяти)
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Home page - initState");
    //Подгружать данные
    //Начинать таймеры, анимации и т.д
    //Давать значения тем переменным еще нет значения
  }

  //прорисовка интерфейса
  @override
  Widget build(BuildContext context) {
    print("Home page - build");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddPage,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _navigateToAddPage() async {
    final result = await Navigator.of(context).push(MaterialPageRoute(builder: (_) => AddPage()));
    if (result != null) {
      print("Текст задачи: $result");
    }
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

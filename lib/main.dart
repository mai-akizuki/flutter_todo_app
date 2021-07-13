import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/add/add_page.dart';
import 'package:flutter_todo_app/main_model.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todoアプリ',
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainModel>(
      create: (_) => MainModel()..getTodoListRealtime(),
      child: Scaffold(
        appBar: AppBar(title: Text('Todoアプリ'), actions: [
          Consumer<MainModel>(builder: (context, model, child) {
            final isActive = model.checkShouldActiveComplteButton();
            return ElevatedButton(
              onPressed: isActive
                  ? () async {
                      await model.deleteCheckedItems();
                    }
                  : null,
              child: Text(
                '完了',
                style: TextStyle(
                  color:
                      isActive ? Colors.white : Colors.white.withOpacity(0.5),
                ),
              ),
            );
          })
        ]),
        body: Consumer<MainModel>(
          builder: (context, model, child) {
            final todoList = model.todoList;
            return ListView(
              children: todoList
                  .map(
                    (todo) => CheckboxListTile(
                      title: Text(todo.title),
                      value: todo.isDone,
                      onChanged: (bool? value) {
                        todo.isDone = !todo.isDone;
                        model.reload();
                      },
                    ),
                  )
                  .toList(),
            );
          },
        ),
        floatingActionButton:
            Consumer<MainModel>(builder: (context, model, child) {
          return FloatingActionButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddPage(model),
                  fullscreenDialog: true,
                ),
              );
            },
            child: Icon(Icons.add),
          );
        }),
      ),
    );
  }
}

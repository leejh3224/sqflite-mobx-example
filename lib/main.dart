import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_mobx_example/sqlite_client.dart';
import 'package:sqlite_mobx_example/todo.dart';
import 'package:sqlite_mobx_example/todo_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /**
     * `MultiProvider` comes handy when you have to initialize complex dependency tree.
     * For example, in our case, `TodoRepository` requires `sqlietClient` and `TodoList` requires `TodoRepository`.
     * It can go unwieldy in big application, however, with `provider` it becomes straight forward.
     */
    return MultiProvider(
      providers: [
        // for futures
        FutureProvider<Database>(
          create: (_) async => sqliteClient(),
        ),
        // for dependent services
        ProxyProvider<Database, TodoRepository>(
          update: (_, db, __) => TodoRepository(db),
        ),
        ProxyProvider<TodoRepository, TodoList>(
          update: (_, repo, __) => TodoList(repo),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Sqflite + Mobx Demo'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void dispose() {
    final todoList = Provider.of<TodoList>(context);
    todoList.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todoList = Provider.of<TodoList>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Observer(
        builder: (context) {
          // you can use stream with Observer
          final data = todoList.todoListStream.value;

          if (data == null) return Container();

          return Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Add todos until it reaches 5!',
                    style: TextStyle(fontSize: 28.0),
                  )),
              Expanded(
                child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          '${index + 1}. ${data[index].name}',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      );
                    },
                    itemCount: data.length),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final length = todoList.todoListStream.data.length;

          if (length >= 5) await todoList.deleteAll();

          await todoList.addTodo();
        },
        child: Icon(Icons.plus_one),
      ),
    );
  }
}

import 'package:random_words/random_words.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_mobx_example/todo.dart';

class TodoRepository {
  final Database sqliteClient;

  TodoRepository(this.sqliteClient);

  Future<List<Todo>> getTodos() async {
    // `sqliteClient` can be null
    final result = await sqliteClient?.rawQuery('select * from todos') ?? [];
    return result.map((d) => Todo.fromJson(d)).toList();
  }

  Future addTodo() async {
    final name = generateNoun().take(1).toList()[0];
    return sqliteClient
        ?.rawInsert("insert into todos ('name') values ('$name')");
  }

  Future flush() async {
    return sqliteClient?.rawDelete('delete from todos order by name limit 10');
  }
}

import 'dart:async';
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';
import 'package:sqlite_mobx_example/todo_repository.dart';

part 'todo.g.dart';

@JsonSerializable()
class Todo {
  int id;
  String name;

  Todo({this.id, this.name});

  // pretty print json
  @override
  String toString() {
    return JsonEncoder.withIndent('  ').convert(this.toJson().toString());
  }

  // handy json serializer library
  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
  Map<String, dynamic> toJson() => _$TodoToJson(this);
}

class TodoList = _TodoList with _$TodoList;

abstract class _TodoList with Store {
  final TodoRepository todoRepository;

  StreamController<List<Todo>> _streamController =
      StreamController<List<Todo>>();

  _TodoList(this.todoRepository) {
    todoListStream = ObservableStream(_streamController.stream);
    this.getTodos();
  }

  @observable
  ObservableStream<List<Todo>> todoListStream;

  @action
  Future getTodos() async {
    final todos = await todoRepository.getTodos();
    _streamController.add(todos);
  }

  @action
  Future addTodo() async {
    await todoRepository.addTodo();
    await this.getTodos();
  }

  @action
  Future deleteAll() async {
    await todoRepository.flush();
  }

  // should always dispose stream!
  void dispose() async {
    await _streamController.close();
  }
}

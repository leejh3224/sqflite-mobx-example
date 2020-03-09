// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) {
  return Todo(
    id: json['id'] as int,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TodoList on _TodoList, Store {
  final _$todoListStreamAtom = Atom(name: '_TodoList.todoListStream');

  @override
  ObservableStream<List<Todo>> get todoListStream {
    _$todoListStreamAtom.context.enforceReadPolicy(_$todoListStreamAtom);
    _$todoListStreamAtom.reportObserved();
    return super.todoListStream;
  }

  @override
  set todoListStream(ObservableStream<List<Todo>> value) {
    _$todoListStreamAtom.context.conditionallyRunInAction(() {
      super.todoListStream = value;
      _$todoListStreamAtom.reportChanged();
    }, _$todoListStreamAtom, name: '${_$todoListStreamAtom.name}_set');
  }

  final _$getTodosAsyncAction = AsyncAction('getTodos');

  @override
  Future<dynamic> getTodos() {
    return _$getTodosAsyncAction.run(() => super.getTodos());
  }

  final _$addTodoAsyncAction = AsyncAction('addTodo');

  @override
  Future<dynamic> addTodo() {
    return _$addTodoAsyncAction.run(() => super.addTodo());
  }

  final _$deleteAllAsyncAction = AsyncAction('deleteAll');

  @override
  Future<dynamic> deleteAll() {
    return _$deleteAllAsyncAction.run(() => super.deleteAll());
  }

  @override
  String toString() {
    final string = 'todoListStream: ${todoListStream.toString()}';
    return '{$string}';
  }
}

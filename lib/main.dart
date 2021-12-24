import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_riverpod/data/entity/todo.dart';
import 'package:todo_riverpod/data/provider/todo_provider.dart';
import 'package:todo_riverpod/ui/screen/todo/todo_screen.dart';

void main() {
  runApp(ProviderScope(
    overrides: [
      todoListProvider.overrideWithValue(TodoList()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TodoScreen(),
    );
  }
}

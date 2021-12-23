import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_riverpod/data/provider/todo_provider.dart';
import 'package:todo_riverpod/ui/screen/todo/children/toolbar.dart';
import 'package:todo_riverpod/ui/screen/todo/children/title.dart' as title;

import 'children/todo_item.dart';

final addTodoKey = UniqueKey();
final activeFilterKey = UniqueKey();
final completedFilterKey = UniqueKey();
final allFilterKey = UniqueKey();

class TodoScreen extends HookConsumerWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(filteredTodos);
    final todoController = useTextEditingController();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          children: [
            const title.Title(),
            TextField(
              key: addTodoKey,
              controller: todoController,
              decoration: const InputDecoration(
                labelText: 'what needs to be done?',
              ),
              onSubmitted: (value) {
                ref.read(todoListProvider.notifier).add(value);
                todoController.clear();
              },
            ),
            const SizedBox(height: 42),
            const Toolbar(),
            if (todos.isNotEmpty) const Divider(height: 0),
            for (var i = 0; i < todos.length; i++) ...[
              if (i > 0) const Divider(height: 0),
              Dismissible(
                key: ValueKey(todos[i].id),
                onDismissed: (_) => ref.read(todoListProvider.notifier).remove(todos[i]),
                child: ProviderScope(
                  overrides: [
                    currentTodo.overrideWithValue(todos[i]),
                  ],
                  child: const TodoItem(),
                ),
              )
            ],
          ],
        ),
      ),
    );
  }
}

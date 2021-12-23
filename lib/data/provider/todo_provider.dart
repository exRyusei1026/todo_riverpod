import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_riverpod/data/entity/todo.dart';
import 'package:todo_riverpod/data/entity/todo_list_filter.dart';

final todoListProvider = StateNotifierProvider<TodoList, List<Todo>>((ref) {
  return TodoList([
    Todo(id: 'todo-0', description: 'hi'),
    Todo(id: 'todo-1', description: 'hello'),
    Todo(id: 'todo-2', description: 'bonjour'),
  ]);
});

final todoListFilter = StateProvider((_) => TodoListFilter.all);

final uncompletedTodosCount = Provider<int>((ref) {
  return ref.watch(todoListProvider).where((todo) => !todo.completed).length;
});

final filteredTodos = Provider<List<Todo>>((ref) {
  final filter = ref.watch(todoListFilter);
  final todos = ref.watch(todoListProvider);

  switch (filter) {
    case TodoListFilter.completed:
      return todos.where((todo) => todo.completed).toList();
    case TodoListFilter.active:
      return todos.where((todo) => !todo.completed).toList();
    case TodoListFilter.all:
      return todos;
  }
});

final currentTodo = Provider<Todo>((ref) => throw UnimplementedError());
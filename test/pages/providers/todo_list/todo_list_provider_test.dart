import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:todo_riverpod_sync/models/todo_models.dart';
import 'package:todo_riverpod_sync/pages/providers/todo_list/todo_list_provider.dart';

void main() {
  group('TodoList', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state contains default tasks', () {
      final todoList = container.read(todoListProvider);

      expect(todoList, [
        const Todo(id: '1', desc: 'Clean the room'),
        const Todo(id: '2', desc: 'Buy groceries'),
        const Todo(id: '3', desc: 'Do the laundry'),
      ]);
    });

    test('addTodo adds a new todo to the list', () {
      final todoListNotifier = container.read(todoListProvider.notifier);

      todoListNotifier.addTodo('New todo');

      final updatedTodoList = container.read(todoListProvider);

      expect(updatedTodoList.length, 4);
      expect(updatedTodoList.last.desc, 'New todo');
    });

    test('add multiple todos to the list', () {
      final todoListNotifier = container.read(todoListProvider.notifier);

      todoListNotifier.addTodo('First new task');
      todoListNotifier.addTodo('Second new task');
      todoListNotifier.addTodo('Third new task');

      final updatedTodoList = container.read(todoListProvider);

      expect(updatedTodoList.length, 6);
      expect(updatedTodoList[3].desc, 'First new task');
      expect(updatedTodoList[4].desc, 'Second new task');
      expect(updatedTodoList[5].desc, 'Third new task');
    });

    test('editTodo updates the description of a todo', () {
      final todoListNotifier = container.read(todoListProvider.notifier);

      todoListNotifier.editTodo('1', 'Updated description');

      final updatedTodoList = container.read(todoListProvider);

      expect(updatedTodoList.firstWhere((todo) => todo.id == '1').desc,
          'Updated description');
    });

    test('edit multiple todos updates their descriptions', () {
      final todoListNotifier = container.read(todoListProvider.notifier);

      todoListNotifier.editTodo('1', 'Updated description 1');
      todoListNotifier.editTodo('2', 'Updated description 2');
      todoListNotifier.editTodo('3', 'Updated description 3');

      final updatedTodoList = container.read(todoListProvider);

      expect(updatedTodoList.firstWhere((todo) => todo.id == '1').desc,
          'Updated description 1');
      expect(updatedTodoList.firstWhere((todo) => todo.id == '2').desc,
          'Updated description 2');
      expect(updatedTodoList.firstWhere((todo) => todo.id == '3').desc,
          'Updated description 3');
    });

    test('editTodo does not update if id is not found', () {
      final todoListNotifier = container.read(todoListProvider.notifier);

      todoListNotifier.editTodo('nonexistent_id', 'New description');

      final updatedTodoList = container.read(todoListProvider);

      expect(updatedTodoList.length, 3);
      expect(updatedTodoList.firstWhere((todo) => todo.id == '1').desc,
          'Clean the room');
      expect(updatedTodoList.firstWhere((todo) => todo.id == '2').desc,
          'Buy groceries');
      expect(updatedTodoList.firstWhere((todo) => todo.id == '3').desc,
          'Do the laundry');
    });

    test('editTodo updates the description of a todo multiple times', () {
      final todoListNotifier = container.read(todoListProvider.notifier);

      todoListNotifier.editTodo('1', 'First update');
      expect(
          container
              .read(todoListProvider)
              .firstWhere((todo) => todo.id == '1')
              .desc,
          'First update');

      todoListNotifier.editTodo('1', 'Second update');
      expect(
          container
              .read(todoListProvider)
              .firstWhere((todo) => todo.id == '1')
              .desc,
          'Second update');

      todoListNotifier.editTodo('1', 'Third update');
      expect(
          container
              .read(todoListProvider)
              .firstWhere((todo) => todo.id == '1')
              .desc,
          'Third update');
    });

    test('toggleTodo toggles the completed status of a todo', () {
      final todoListNotifier = container.read(todoListProvider.notifier);

      todoListNotifier.toggleTodo('1');

      final updatedTodoList = container.read(todoListProvider);

      expect(
          updatedTodoList.firstWhere((todo) => todo.id == '1').completed, true);
    });

    test('toggleTodo toggles the completed status of a todo back to false', () {
      final todoListNotifier = container.read(todoListProvider.notifier);

      todoListNotifier.toggleTodo('1');
      var updatedTodoList = container.read(todoListProvider);
      expect(
          updatedTodoList.firstWhere((todo) => todo.id == '1').completed, true);

      todoListNotifier.toggleTodo('1');
      updatedTodoList = container.read(todoListProvider);
      expect(updatedTodoList.firstWhere((todo) => todo.id == '1').completed,
          false);
    });

    test('removeTodo removes a todo from the list', () {
      final todoListNotifier = container.read(todoListProvider.notifier);

      todoListNotifier.removeTodo('1');

      final updatedTodoList = container.read(todoListProvider);

      expect(updatedTodoList.length, 2);
      expect(updatedTodoList.where((todo) => todo.id == '1').isEmpty, true);
    });

    test('removeTodo removes multiple todos from the list', () {
      final todoListNotifier = container.read(todoListProvider.notifier);

      todoListNotifier.removeTodo('1');
      todoListNotifier.removeTodo('2');

      final updatedTodoList = container.read(todoListProvider);

      expect(updatedTodoList.length, 1);
      expect(updatedTodoList.where((todo) => todo.id == '1').isEmpty, true);
      expect(updatedTodoList.where((todo) => todo.id == '2').isEmpty, true);
      expect(updatedTodoList.firstWhere((todo) => todo.id == '3').desc,
          'Do the laundry');
    });

    test('removeTodo does nothing if the todo does not exist', () {
      final todoListNotifier = container.read(todoListProvider.notifier);

      todoListNotifier.removeTodo('non-existent-id');

      final updatedTodoList = container.read(todoListProvider);

      expect(updatedTodoList.length, 3);
      expect(
          updatedTodoList.where((todo) => todo.id == 'non-existent-id').isEmpty,
          true);
    });

    test('removeTodo removes duplicate todos from the list', () {
      final todoListNotifier = container.read(todoListProvider.notifier);

      todoListNotifier.addTodo('Duplicate Task');
      todoListNotifier.addTodo('Duplicate Task');

      var updatedTodoList = container.read(todoListProvider);
      final duplicateTodos = updatedTodoList
          .where((todo) => todo.desc == 'Duplicate Task')
          .toList();

      expect(duplicateTodos.length, 2);

      todoListNotifier.removeTodo(duplicateTodos.first.id);

      updatedTodoList = container.read(todoListProvider);
      final remainingDuplicateTodos = updatedTodoList
          .where((todo) => todo.desc == 'Duplicate Task')
          .toList();

      expect(remainingDuplicateTodos.length, 1);

      todoListNotifier.removeTodo(remainingDuplicateTodos.first.id);

      updatedTodoList = container.read(todoListProvider);
      final noDuplicateTodos = updatedTodoList
          .where((todo) => todo.desc == 'Duplicate Task')
          .toList();

      expect(noDuplicateTodos.isEmpty, true);
    });
  });
}

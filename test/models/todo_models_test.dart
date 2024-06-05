import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_riverpod_sync/models/todo_models.dart';
import 'package:uuid/uuid.dart';
import 'package:mockito/annotations.dart';

import 'todo_models_test.mocks.dart';

@GenerateMocks([Uuid])
void main() {
  group('Todo Model Tests', () {
    test('Todo.add should create a Todo with a unique id and given description',
        () {
      const desc = 'Test Todo';
      final todo = Todo.add(desc: desc);

      expect(todo.id, isNotEmpty);
      expect(todo.desc, desc);
      expect(todo.completed, isFalse);
    });

    test(
        'Todo factory should create a Todo with given id, description, and completed status',
        () {
      final id = const Uuid().v4();
      const desc = 'Test Todo';
      const completed = true;
      final todo = Todo(
        id: id,
        desc: desc,
        completed: completed,
      );

      expect(todo.id, id);
      expect(todo.desc, desc);
      expect(todo.completed, completed);
    });

    test('Todo should have completed default to false when not provided', () {
      final id = const Uuid().v4();
      const desc = 'Test Todo Default Completed';
      final todo = Todo(
        id: id,
        desc: desc,
      );

      expect(todo.id, id);
      expect(todo.desc, desc);
      expect(todo.completed, isFalse);
    });

    test('Todo() should have completed set to false explicitly', () {
      final id = const Uuid().v4();
      const desc = 'Test Todo Default Completed';
      final todo = Todo(
        id: id,
        desc: desc,
        completed: false,
      );

      expect(todo.id, id);
      expect(todo.desc, desc);
      expect(todo.completed, isFalse);
    });

    test('Todo.add should create a Todo with a mocked unique id', () {
      final mockUuid = MockUuid();
      when(mockUuid.v4()).thenReturn('110ec58a-a0f2-4ac4-8393-c866d813b8d1');

      final originalUuid = uuid;
      uuid = mockUuid;

      const desc = 'Test Todo with Mock';
      final todo = Todo.add(desc: desc);

      expect(todo.id, '110ec58a-a0f2-4ac4-8393-c866d813b8d1');
      expect(todo.desc, desc);
      expect(todo.completed, isFalse);

      uuid = originalUuid;
    });

    test('Todo.add should create a Todo with completed defaulting to false',
        () {
      const desc = 'Test Todo Default Completed';
      final todo = Todo.add(desc: desc);

      expect(todo.id, isNotEmpty);
      expect(todo.desc, desc);
      expect(todo.completed, isFalse);
    });
  });

  group('Filter Enum Tests', () {
    test('Filter enum should have correct values', () {
      expect(Filter.values.length, 3);
      expect(Filter.all, Filter.values[0]);
      expect(Filter.active, Filter.values[1]);
      expect(Filter.completed, Filter.values[2]);
    });
  });
}

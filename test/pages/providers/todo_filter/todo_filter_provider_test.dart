import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:todo_riverpod_sync/models/todo_models.dart';
import 'package:todo_riverpod_sync/pages/providers/todo_filter/todo_filter_provider.dart';

void main() {
  group('TodoFilterProvider', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state is Filter.all', () {
      final todoFilter = container.read(todoFilterProvider);

      expect(todoFilter, Filter.all);
    });

    test('changeFilter updates the state to Filter.completed', () {
      final todoFilterNotifier = container.read(todoFilterProvider.notifier);

      todoFilterNotifier.changeFilter(Filter.completed);

      final updatedFilter = container.read(todoFilterProvider);

      expect(updatedFilter, Filter.completed);
    });

    test('changeFilter updates the state to Filter.active', () {
      final todoFilterNotifier = container.read(todoFilterProvider.notifier);

      todoFilterNotifier.changeFilter(Filter.active);

      final updatedFilter = container.read(todoFilterProvider);

      expect(updatedFilter, Filter.active);
    });

    test('changeFilter updates the state to Filter.all', () {
      final todoFilterNotifier = container.read(todoFilterProvider.notifier);

      todoFilterNotifier.changeFilter(Filter.all);

      final updatedFilter = container.read(todoFilterProvider);

      expect(updatedFilter, Filter.all);
    });

    test('changeFilter updates state from active to completed', () {
      final todoFilter = container.read(todoFilterProvider.notifier);

      todoFilter.changeFilter(Filter.active);
      expect(todoFilter.state, Filter.active);

      todoFilter.changeFilter(Filter.completed);
      expect(todoFilter.state, Filter.completed);
    });

    test('changeFilter updates the state from active to completed', () {
      final todoFilterNotifier = container.read(todoFilterProvider.notifier);

      todoFilterNotifier.changeFilter(Filter.active);
      todoFilterNotifier.changeFilter(Filter.completed);

      final updatedFilter = container.read(todoFilterProvider);

      expect(updatedFilter, Filter.completed);
    });

    test('changeFilter updates the state from active to all', () {
      final todoFilterNotifier = container.read(todoFilterProvider.notifier);

      todoFilterNotifier.changeFilter(Filter.active);
      todoFilterNotifier.changeFilter(Filter.all);

      final updatedFilter = container.read(todoFilterProvider);

      expect(updatedFilter, Filter.all);
    });

    test('changeFilter updates the state from completed to active', () {
      final todoFilterNotifier = container.read(todoFilterProvider.notifier);

      todoFilterNotifier.changeFilter(Filter.completed);
      todoFilterNotifier.changeFilter(Filter.active);

      final updatedFilter = container.read(todoFilterProvider);

      expect(updatedFilter, Filter.active);
    });

    test('changeFilter updates the state from completed to all', () {
      final todoFilterNotifier = container.read(todoFilterProvider.notifier);

      todoFilterNotifier.changeFilter(Filter.completed);
      todoFilterNotifier.changeFilter(Filter.all);

      final updatedFilter = container.read(todoFilterProvider);

      expect(updatedFilter, Filter.all);
    });

    test('changeFilter updates the state from all to active', () {
      final todoFilterNotifier = container.read(todoFilterProvider.notifier);

      todoFilterNotifier.changeFilter(Filter.all);
      todoFilterNotifier.changeFilter(Filter.active);

      final updatedFilter = container.read(todoFilterProvider);

      expect(updatedFilter, Filter.active);
    });

    test('changeFilter updates the state from all to completed', () {
      final todoFilterNotifier = container.read(todoFilterProvider.notifier);

      todoFilterNotifier.changeFilter(Filter.all);
      todoFilterNotifier.changeFilter(Filter.completed);

      final updatedFilter = container.read(todoFilterProvider);

      expect(updatedFilter, Filter.completed);
    });
  });
}

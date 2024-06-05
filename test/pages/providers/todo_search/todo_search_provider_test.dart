import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:todo_riverpod_sync/pages/providers/todo_search/todo_search_provider.dart';

void main() {
  group('TodoSearchProvider', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state is an empty string', () {
      final todoSearch = container.read(todoSearchProvider);

      expect(todoSearch, '');
    });

    test('setSearchTerm updates the state', () {
      final todoSearchNotifier = container.read(todoSearchProvider.notifier);

      todoSearchNotifier.setSearchTerm('test');

      final updatedSearchTerm = container.read(todoSearchProvider);

      expect(updatedSearchTerm, 'test');
    });

    test('setSearchTerm updates the state multiple times', () {
      final todoSearchNotifier = container.read(todoSearchProvider.notifier);

      todoSearchNotifier.setSearchTerm('test1');
      expect(container.read(todoSearchProvider), 'test1');

      todoSearchNotifier.setSearchTerm('test2');
      expect(container.read(todoSearchProvider), 'test2');

      todoSearchNotifier.setSearchTerm('test3');
      expect(container.read(todoSearchProvider), 'test3');
    });

    test('setSearchTerm updates the state to an empty string', () {
      final todoSearchNotifier = container.read(todoSearchProvider.notifier);

      todoSearchNotifier.setSearchTerm('test');
      todoSearchNotifier.setSearchTerm('');

      final updatedSearchTerm = container.read(todoSearchProvider);

      expect(updatedSearchTerm, '');
    });
  });
}

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:make_a_proper_flappy_bird_game_with_very_good_rand/features/game/models/item.dart';
import 'package:make_a_proper_flappy_bird_game_with_very_good_rand/features/shared/data/models/item.dart';

part 'items_provider.g.dart';

@riverpod
class Items extends _$Items {
  @override
  Future<List<Item>> build() async {
    // Simulate loading delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Return initial empty list - in a real app this would fetch from a repository
    return [];
  }

  Future<void> addItem(String title, String? description) async {
    state = const AsyncValue.loading();
    
    state = await AsyncValue.guard(() async {
      final currentItems = await future;
      final newItem = Item(
        id: DateTime.now().millisecondsSinceEpoch,
        title: title,
        description: description,
        createdAt: DateTime.now(),
      );
      
      return [...currentItems, newItem];
    });
  }

  Future<void> removeItem(int id) async {
    state = const AsyncValue.loading();
    
    state = await AsyncValue.guard(() async {
      final currentItems = await future;
      return currentItems.where((item) => item.id != id).toList();
    });
  }

  Future<void> updateItem(int id, String title, String? description) async {
    state = const AsyncValue.loading();
    
    state = await AsyncValue.guard(() async {
      final currentItems = await future;
      return [
        for (final item in currentItems)
          if (item.id == id)
            Item(
              id: item.id,
              title: title,
              description: description,
              createdAt: item.createdAt,
            )
          else
            item,
      ];
    });
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    
    // Simulate refresh delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    state = const AsyncValue.data([]);
  }
}
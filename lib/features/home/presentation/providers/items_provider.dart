import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:make_a_proper_flappy_bird_game_with_very_good_rand/features/home/domain/models/item.dart';

part 'items_provider.g.dart';

@riverpod
class HomeItems extends _$HomeItems {
  @override
  Future<List<HomeItem>> build() async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    return [
      HomeItem(
        id: '1',
        title: 'Start Game',
        description: 'Begin your flappy bird adventure',
        createdAt: DateTime.now(),
      ),
      HomeItem(
        id: '2',
        title: 'High Scores',
        description: 'View your best performances',
        createdAt: DateTime.now(),
      ),
      HomeItem(
        id: '3',
        title: 'Settings',
        description: 'Customize your game experience',
        createdAt: DateTime.now(),
      ),
    ];
  }

  Future<void> addItem(HomeItem item) async {
    final current = await future;
    state = AsyncValue.data([...current, item]);
  }

  Future<void> removeItem(String id) async {
    final current = await future;
    state = AsyncValue.data(
      current.where((item) => item.id != id).toList(),
    );
  }

  Future<void> toggleCompleted(String id) async {
    final current = await future;
    state = AsyncValue.data(
      current.map((item) {
        if (item.id == id) {
          return item.copyWith(
            isCompleted: !item.isCompleted,
            updatedAt: DateTime.now(),
          );
        }
        return item;
      }).toList(),
    );
  }
}
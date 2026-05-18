import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:make_a_proper_flappy_bird_game_with_very_good_rand/features/home/domain/models/item.dart';

part 'items_provider.g.dart';

@riverpod
class Items extends _$Items {
  @override
  Future<List<HomeItem>> build() async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return [
      HomeItem(
        id: '1',
        title: 'Game Ready',
        description: 'Your flappy bird game is ready to play!',
        createdAt: DateTime.now(),
      ),
      HomeItem(
        id: '2',
        title: 'Tap to Fly',
        description: 'Tap anywhere on the screen to make the bird fly',
        createdAt: DateTime.now(),
      ),
      HomeItem(
        id: '3',
        title: 'Avoid Pipes',
        description: 'Navigate through the pipes without crashing',
        createdAt: DateTime.now(),
      ),
      HomeItem(
        id: '4',
        title: 'Score Points',
        description: 'Pass through pipes to increase your score',
        createdAt: DateTime.now(),
      ),
    ];
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }

  Future<void> markCompleted(String id) async {
    final current = await future;
    state = AsyncValue.data(
      current.map((item) {
        if (item.id == id) {
          return item.copyWith(
            isCompleted: true,
            updatedAt: DateTime.now(),
          );
        }
        return item;
      }).toList(),
    );
  }
}
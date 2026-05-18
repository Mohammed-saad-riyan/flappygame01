import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_provider.freezed.dart';
part 'settings_provider.g.dart';

@freezed
class GameSettings with _$GameSettings {
  const factory GameSettings({
    @Default(true) bool soundEnabled,
    @Default(true) bool vibrationEnabled,
    @Default('Medium') String difficulty,
    @Default(0) int highScore,
    @Default('Player') String playerName,
  }) = _GameSettings;

  factory GameSettings.fromJson(Map<String, dynamic> json) => _$GameSettingsFromJson(json);
}

@riverpod
class Settings extends _$Settings {
  @override
  Future<GameSettings> build() async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return const GameSettings();
  }

  Future<void> toggleSound() async {
    final current = await future;
    state = AsyncValue.data(
      current.copyWith(soundEnabled: !current.soundEnabled),
    );
  }

  Future<void> toggleVibration() async {
    final current = await future;
    state = AsyncValue.data(
      current.copyWith(vibrationEnabled: !current.vibrationEnabled),
    );
  }

  Future<void> setDifficulty(String difficulty) async {
    final current = await future;
    state = AsyncValue.data(
      current.copyWith(difficulty: difficulty),
    );
  }

  Future<void> updateHighScore(int score) async {
    final current = await future;
    if (score > current.highScore) {
      state = AsyncValue.data(
        current.copyWith(highScore: score),
      );
    }
  }

  Future<void> setPlayerName(String name) async {
    final current = await future;
    state = AsyncValue.data(
      current.copyWith(playerName: name),
    );
  }

  Future<void> resetSettings() async {
    state = const AsyncValue.data(GameSettings());
  }
}
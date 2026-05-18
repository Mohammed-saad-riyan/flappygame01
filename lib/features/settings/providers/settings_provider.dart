import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:make_a_proper_flappy_bird_game_with_very_good_rand/features/settings/presentation/screens/settings_screen.dart';

part 'settings_provider.g.dart';

@riverpod
class Settings extends _$Settings {
  @override
  AsyncValue<SettingsData> build() {
    return const AsyncValue.data(
      SettingsData(
        isDarkTheme: false,
        themeColor: Colors.blue,
        notificationsEnabled: true,
        soundEnabled: true,
        vibrationEnabled: true,
        difficulty: GameDifficulty.medium,
      ),
    );
  }

  Future<void> updateTheme(bool isDarkTheme) async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(milliseconds: 300));
    
    final currentData = state.valueOrNull;
    if (currentData != null) {
      state = AsyncValue.data(
        currentData.copyWith(isDarkTheme: isDarkTheme),
      );
    }
  }

  Future<void> updateThemeColor(Color color) async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(milliseconds: 300));
    
    final currentData = state.valueOrNull;
    if (currentData != null) {
      state = AsyncValue.data(
        currentData.copyWith(themeColor: color),
      );
    }
  }

  Future<void> updateNotifications(bool enabled) async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(milliseconds: 300));
    
    final currentData = state.valueOrNull;
    if (currentData != null) {
      state = AsyncValue.data(
        currentData.copyWith(
          notificationsEnabled: enabled,
          soundEnabled: enabled ? currentData.soundEnabled : false,
        ),
      );
    }
  }

  Future<void> updateSound(bool enabled) async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(milliseconds: 300));
    
    final currentData = state.valueOrNull;
    if (currentData != null) {
      state = AsyncValue.data(
        currentData.copyWith(soundEnabled: enabled),
      );
    }
  }

  Future<void> updateVibration(bool enabled) async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(milliseconds: 300));
    
    final currentData = state.valueOrNull;
    if (currentData != null) {
      state = AsyncValue.data(
        currentData.copyWith(vibrationEnabled: enabled),
      );
    }
  }

  Future<void> updateDifficulty(GameDifficulty difficulty) async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(milliseconds: 300));
    
    final currentData = state.valueOrNull;
    if (currentData != null) {
      state = AsyncValue.data(
        currentData.copyWith(difficulty: difficulty),
      );
    }
  }

  Future<void> resetToDefaults() async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(milliseconds: 300));
    
    state = const AsyncValue.data(
      SettingsData(
        isDarkTheme: false,
        themeColor: Colors.blue,
        notificationsEnabled: true,
        soundEnabled: true,
        vibrationEnabled: true,
        difficulty: GameDifficulty.medium,
      ),
    );
  }
}
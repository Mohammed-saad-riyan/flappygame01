import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

import 'package:make_a_proper_flappy_bird_game_with_very_good_rand/app/app.dart';
import 'package:make_a_proper_flappy_bird_game_with_very_good_rand/features/settings/providers/settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: theme.colorScheme.surface,
        foregroundColor: theme.colorScheme.onSurface,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
          tooltip: 'Go back',
        ),
      ),
      body: settings.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: theme.colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                'Error loading settings',
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => ref.invalidate(settingsProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (settingsData) => _buildSettingsContent(context, ref, settingsData),
      ),
    );
  }

  Widget _buildSettingsContent(BuildContext context, WidgetRef ref, SettingsData settingsData) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(context, 'Appearance'),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                Semantics(
                  label: 'Dark theme toggle',
                  child: SwitchListTile(
                    title: const Text('Dark Theme'),
                    subtitle: const Text('Enable dark mode for better night gaming'),
                    value: settingsData.isDarkTheme,
                    onChanged: (value) {
                      ref.read(settingsProvider.notifier).updateTheme(value);
                    },
                    secondary: Icon(
                      settingsData.isDarkTheme ? Icons.dark_mode : Icons.light_mode,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Icon(
                    Icons.palette,
                    color: theme.colorScheme.primary,
                  ),
                  title: const Text('Theme Color'),
                  subtitle: Text(_getThemeColorName(settingsData.themeColor)),
                  trailing: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: settingsData.themeColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: theme.colorScheme.outline,
                        width: 1,
                      ),
                    ),
                  ),
                  onTap: () => _showThemeColorPicker(context, ref, settingsData.themeColor),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionHeader(context, 'Notifications'),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                Semantics(
                  label: 'Notifications toggle',
                  child: SwitchListTile(
                    title: const Text('Notifications'),
                    subtitle: const Text('Receive game updates and achievements'),
                    value: settingsData.notificationsEnabled,
                    onChanged: (value) {
                      ref.read(settingsProvider.notifier).updateNotifications(value);
                    },
                    secondary: Icon(
                      settingsData.notificationsEnabled 
                          ? Icons.notifications_active 
                          : Icons.notifications_off,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
                if (settingsData.notificationsEnabled) ...[
                  const Divider(height: 1),
                  Semantics(
                    label: 'Sound notifications toggle',
                    child: SwitchListTile(
                      title: const Text('Sound'),
                      subtitle: const Text('Play sounds with notifications'),
                      value: settingsData.soundEnabled,
                      onChanged: (value) {
                        ref.read(settingsProvider.notifier).updateSound(value);
                      },
                      secondary: Icon(
                        settingsData.soundEnabled ? Icons.volume_up : Icons.volume_off,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionHeader(context, 'Game'),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.speed,
                    color: theme.colorScheme.primary,
                  ),
                  title: const Text('Difficulty'),
                  subtitle: Text(_getDifficultyName(settingsData.difficulty)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showDifficultyDialog(context, ref, settingsData.difficulty),
                ),
                const Divider(height: 1),
                Semantics(
                  label: 'Vibration toggle',
                  child: SwitchListTile(
                    title: const Text('Vibration'),
                    subtitle: const Text('Haptic feedback during gameplay'),
                    value: settingsData.vibrationEnabled,
                    onChanged: (value) {
                      ref.read(settingsProvider.notifier).updateVibration(value);
                    },
                    secondary: Icon(
                      Icons.vibration,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionHeader(context, 'About'),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.info,
                    color: theme.colorScheme.primary,
                  ),
                  title: const Text('Version'),
                  subtitle: const Text('1.0.0'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showAboutDialog(context),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Icon(
                    Icons.star,
                    color: theme.colorScheme.primary,
                  ),
                  title: const Text('Rate App'),
                  subtitle: const Text('Help us improve the game'),
                  trailing: const Icon(Icons.open_in_new),
                  onTap: () => _handleRateApp(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _getThemeColorName(Color color) {
    if (color == Colors.blue) return 'Blue';
    if (color == Colors.green) return 'Green';
    if (color == Colors.purple) return 'Purple';
    if (color == Colors.orange) return 'Orange';
    if (color == Colors.red) return 'Red';
    return 'Custom';
  }

  String _getDifficultyName(GameDifficulty difficulty) {
    switch (difficulty) {
      case GameDifficulty.easy:
        return 'Easy';
      case GameDifficulty.medium:
        return 'Medium';
      case GameDifficulty.hard:
        return 'Hard';
      case GameDifficulty.expert:
        return 'Expert';
    }
  }

  void _showThemeColorPicker(BuildContext context, WidgetRef ref, Color currentColor) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.purple,
      Colors.orange,
      Colors.red,
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Theme Color'),
        content: Wrap(
          spacing: 16,
          children: colors.map((color) {
            final isSelected = color == currentColor;
            return GestureDetector(
              onTap: () {
                ref.read(settingsProvider.notifier).updateThemeColor(color);
                Navigator.of(context).pop();
              },
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: isSelected
                      ? Border.all(color: Colors.white, width: 3)
                      : null,
                ),
                child: isSelected
                    ? const Icon(Icons.check, color: Colors.white)
                    : null,
              ),
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showDifficultyDialog(BuildContext context, WidgetRef ref, GameDifficulty currentDifficulty) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Difficulty'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: GameDifficulty.values.map((difficulty) {
            return RadioListTile<GameDifficulty>(
              title: Text(_getDifficultyName(difficulty)),
              subtitle: Text(_getDifficultyDescription(difficulty)),
              value: difficulty,
              groupValue: currentDifficulty,
              onChanged: (value) {
                if (value != null) {
                  ref.read(settingsProvider.notifier).updateDifficulty(value);
                  Navigator.of(context).pop();
                }
              },
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  String _getDifficultyDescription(GameDifficulty difficulty) {
    switch (difficulty) {
      case GameDifficulty.easy:
        return 'Relaxed gameplay for beginners';
      case GameDifficulty.medium:
        return 'Balanced challenge';
      case GameDifficulty.hard:
        return 'Fast-paced action';
      case GameDifficulty.expert:
        return 'Maximum challenge';
    }
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Flappy Bird',
      applicationVersion: '1.0.0',
      applicationIcon: const Icon(Icons.games, size: 64),
      children: [
        const Text('A modern take on the classic Flappy Bird game.'),
        const SizedBox(height: 16),
        const Text('Built with Flutter and lots of ❤️'),
      ],
    );
  }

  void _handleRateApp(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Thank you for your support!'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

enum GameDifficulty { easy, medium, hard, expert }

class SettingsData {
  final bool isDarkTheme;
  final Color themeColor;
  final bool notificationsEnabled;
  final bool soundEnabled;
  final bool vibrationEnabled;
  final GameDifficulty difficulty;

  const SettingsData({
    required this.isDarkTheme,
    required this.themeColor,
    required this.notificationsEnabled,
    required this.soundEnabled,
    required this.vibrationEnabled,
    required this.difficulty,
  });

  SettingsData copyWith({
    bool? isDarkTheme,
    Color? themeColor,
    bool? notificationsEnabled,
    bool? soundEnabled,
    bool? vibrationEnabled,
    GameDifficulty? difficulty,
  }) {
    return SettingsData(
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
      themeColor: themeColor ?? this.themeColor,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      vibrationEnabled: vibrationEnabled ?? this.vibrationEnabled,
      difficulty: difficulty ?? this.difficulty,
    );
  }
}
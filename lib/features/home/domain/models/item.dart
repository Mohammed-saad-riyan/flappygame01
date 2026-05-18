import 'package:freezed_annotation/freezed_annotation.dart';

part 'item.freezed.dart';
part 'item.g.dart';

@freezed
class HomeItem with _$HomeItem {
  const factory HomeItem({
    required String id,
    required String title,
    required String description,
    @Default(false) bool isCompleted,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _HomeItem;

  factory HomeItem.fromJson(Map<String, dynamic> json) => _$HomeItemFromJson(json);
}

@freezed
class MenuItem with _$MenuItem {
  const factory MenuItem({
    required String id,
    required String label,
    required String route,
    IconData? icon,
    @Default(true) bool isEnabled,
  }) = _MenuItem;

  factory MenuItem.fromJson(Map<String, dynamic> json) => _$MenuItemFromJson(json);
}
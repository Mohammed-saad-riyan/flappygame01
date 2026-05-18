import 'package:freezed_annotation/freezed_annotation.dart';

part 'item.freezed.dart';
part 'item.g.dart';

@freezed
class GameItem with _$GameItem {
  const factory GameItem({
    required String id,
    required String name,
    required double x,
    required double y,
    required double width,
    required double height,
    @Default(0.0) double velocityX,
    @Default(0.0) double velocityY,
    @Default('pipe') String type,
    @Default(true) bool isActive,
  }) = _GameItem;

  factory GameItem.fromJson(Map<String, dynamic> json) => _$GameItemFromJson(json);
}

@freezed
class Bird with _$Bird {
  const factory Bird({
    required double x,
    required double y,
    @Default(0.0) double velocityY,
    @Default(20.0) double width,
    @Default(20.0) double height,
    @Default(true) bool isAlive,
  }) = _Bird;

  factory Bird.fromJson(Map<String, dynamic> json) => _$BirdFromJson(json);
}

@freezed
class Pipe with _$Pipe {
  const factory Pipe({
    required String id,
    required double x,
    required double topHeight,
    required double bottomHeight,
    @Default(50.0) double width,
    @Default(150.0) double gap,
    @Default(true) bool isActive,
    @Default(false) bool hasScored,
  }) = _Pipe;

  factory Pipe.fromJson(Map<String, dynamic> json) => _$PipeFromJson(json);
}
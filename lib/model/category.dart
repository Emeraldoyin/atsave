import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@collection
@JsonSerializable()
class Category {
  Id? id;
  final String name;
  final String imagePath;

  Category({required this.name, required this.imagePath});

  factory Category.fromJson(Map<Object?, Object?> json) =>
      _$CategoryFromJson(json);

  /// Connect the generated [_$CategoryToJson] function to the `toJson` method.
  Map<Object?, Object?> toJson() => _$CategoryToJson(this);
}

import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';


part 'atsave_user.g.dart';

@collection
@JsonSerializable()
class ATSaveUser {
  final String firstName;
  final String lastName;
  final String email;
  Id? id;
  final String uid;

  ATSaveUser(
      {this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.uid});


  factory ATSaveUser.fromJson(Map<Object?, Object?> json) =>
      _$ATSaveUserFromJson(json);

  /// Connecting the generated [_$TechKidUserToJson] function to the `toJson` method.
  Map<Object?, Object?> toJson() => _$ATSaveUserToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'user_request_dto.g.dart';

@JsonSerializable()
class UserRequestDto {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? photo;
  final String? gender;
  final String? phone;

  const UserRequestDto({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.photo,
    required this.gender,
    required this.phone,
  });

  factory UserRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UserRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserRequestDtoToJson(this);
}

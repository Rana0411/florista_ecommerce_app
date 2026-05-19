import 'package:florista_ecommerce_app/config/shared_models/user_data/user_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_data_response.g.dart';

@JsonSerializable()
class UserDataReponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "user")
  final UserDto? user;

  UserDataReponse({this.message, this.user});

  factory UserDataReponse.fromJson(Map<String, dynamic> json) =>
      _$UserDataReponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataReponseToJson(this);
}

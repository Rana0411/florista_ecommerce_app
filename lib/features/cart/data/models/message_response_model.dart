import 'package:json_annotation/json_annotation.dart';

part 'message_response_model.g.dart';

@JsonSerializable()
class MessageResponseModel {
  @JsonKey(name: "message")
  final String? message;

  MessageResponseModel({this.message});

  MessageResponseModel copyWith({String? message}) =>
      MessageResponseModel(message: message ?? this.message);

  factory MessageResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MessageResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageResponseModelToJson(this);
}

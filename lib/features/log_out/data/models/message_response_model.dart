// To parse this JSON data, do
//
//     final messageResponseModel = messageResponseModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'message_response_model.g.dart';

MessageResponseModel messageResponseModelFromJson(String str) =>
    MessageResponseModel.fromJson(json.decode(str));

String messageResponseModelToJson(MessageResponseModel data) =>
    json.encode(data.toJson());

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

  String toDomain(MessageResponseModel model) {
    return model.message ?? '';
  }
}

import 'package:json_annotation/json_annotation.dart';

part 'stripe_response.g.dart';

@JsonSerializable()
class StripeResponse {
  final String message;
  @JsonKey(readValue: _readUrl)
  final String checkoutUrl;

  StripeResponse({required this.message, required this.checkoutUrl});

  // Helper method to look into the nested session map without mapping the whole object
  static Object? _readUrl(Map map, String key) {
    return map['session']?['url'];
  }

  factory StripeResponse.fromJson(Map<String, dynamic> json) =>
      _$StripeResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StripeResponseToJson(this);
}

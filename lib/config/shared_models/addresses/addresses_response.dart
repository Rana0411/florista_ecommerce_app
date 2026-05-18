import 'package:florista_ecommerce_app/config/shared_models/addresses/address_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'addresses_response.g.dart';

@JsonSerializable()
class AddressesResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "addresses")
  final List<AddressDto>? addresses;

  AddressesResponse({this.message, this.addresses});

  factory AddressesResponse.fromJson(Map<String, dynamic> json) =>
      _$AddressesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddressesResponseToJson(this);
}
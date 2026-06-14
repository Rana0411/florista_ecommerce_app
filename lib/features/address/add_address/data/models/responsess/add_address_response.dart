import 'package:florista_ecommerce_app/config/shared_models/addresses/address_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_address_response.g.dart';

@JsonSerializable()
class AddAddressResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "address")
  final List<AddressDto>? addresses;

  AddAddressResponse({this.message, this.addresses});

  factory AddAddressResponse.fromJson(Map<String, dynamic> json) =>
      _$AddAddressResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddAddressResponseToJson(this);
}

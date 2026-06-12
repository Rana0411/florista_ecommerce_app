import 'package:florista_ecommerce_app/features/address/add_address/domain/entities/add_address_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_address_dto.g.dart';

@JsonSerializable()
class AddAddressDto {
  @JsonKey(name: "street")
  final String? street;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "city")
  final String? city;
  @JsonKey(name: "lat")
  final String? lat;
  @JsonKey(name: "long")
  final String? long;
  @JsonKey(name: "username")
  final String? username;
  @JsonKey(name: "_id")
  final String? id;

  AddAddressDto({
    this.street,
    this.phone,
    this.city,
    this.lat,
    this.long,
    this.username,
    this.id,
  });

  factory AddAddressDto.fromJson(Map<String, dynamic> json) =>
      _$AddAddressDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AddAddressDtoToJson(this);

  AddAddressEntity toDomain() => AddAddressEntity(
        id: id,
        street: street,
        phone: phone,
        city: city,
        lat: lat,
        long: long,
        username: username,
      );
}

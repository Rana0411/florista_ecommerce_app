import 'package:florista_ecommerce_app/config/shared_models/addresses/address_dto.dart';
import 'package:florista_ecommerce_app/features/profile/domain/entities/user_data_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "firstName")
  final String? firstName;
  @JsonKey(name: "lastName")
  final String? lastName;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "gender")
  final String? gender;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "photo")
  final String? photo;
  @JsonKey(name: "role")
  final String? role;
  @JsonKey(name: "wishlist")
  final List<dynamic>? wishlist;
  @JsonKey(name: "addresses")
  final List<AddressDto>? addresses;
  @JsonKey(name: "createdAt")
  final DateTime? createdAt;
  @JsonKey(name: "passwordChangedAt")
  final DateTime? passwordChangedAt;

  UserDto({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.phone,
    this.photo,
    this.role,
    this.wishlist,
    this.addresses,
    this.createdAt,
    this.passwordChangedAt,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  UserDataEntity toDomain() => UserDataEntity(
    id: id,
    firstName: firstName,
    email: email,
    photo: photo,
    lastName: lastName,
    gender: gender,
    phone: phone,
  );
}

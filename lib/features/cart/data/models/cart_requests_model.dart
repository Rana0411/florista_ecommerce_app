import 'package:json_annotation/json_annotation.dart';

part 'cart_requests_model.g.dart';

@JsonSerializable()
class AddProductRequest {
  final String productId;
  final int quantity;

  AddProductRequest({required this.productId, required this.quantity});

  Map<String, dynamic> toJson() => _$AddProductRequestToJson(this);
}

@JsonSerializable()
class UpdateQuantityRequest {
  final int quantity;

  UpdateQuantityRequest({required this.quantity});

  Map<String, dynamic> toJson() => _$UpdateQuantityRequestToJson(this);
}

import '../../domain/entities/order_entity.dart';

class OrderItemDto {
  final String? productId;
  final String? productName;
  final String? imageUrl;
  final int? quantity;
  final double? price;

  const OrderItemDto({
    this.productId,
    this.productName,
    this.imageUrl,
    this.quantity,
    this.price,
  });

  factory OrderItemDto.fromJson(Map<String, dynamic> json) => OrderItemDto(
    productId: (json['product'] is Map)
        ? json['product']['_id'] as String?
        : json['product'] as String?,
    productName: (json['product'] is Map)
        ? json['product']['title'] as String? ?? ''
        : '',
    imageUrl: (json['product'] is Map)
        ? ((json['product']['imageCover'] as String?) ??
        (json['product']['images'] as List?)?.firstOrNull as String? ??
        '')
        : '',
    quantity: json['count'] as int? ?? json['quantity'] as int? ?? 1,
    price: (json['price'] as num?)?.toDouble() ?? 0,
  );

  Map<String, dynamic> toJson() => {
    'product': productId,
    'count': quantity,
    'price': price,
  };

  OrderItemEntity toDomain() => OrderItemEntity(
    productId: productId ?? '',
    productName: productName ?? '',
    imageUrl: imageUrl ?? '',
    quantity: quantity ?? 1,
    price: price ?? 0,
  );
}

class OrderDto {
  final String? id;
  final String? orderNumber;
  final List<OrderItemDto>? cartItems;
  final double? totalOrderPrice;
  final String? status;
  final DateTime? deliveredAt;
  final DateTime? createdAt;

  const OrderDto({
    this.id,
    this.orderNumber,
    this.cartItems,
    this.totalOrderPrice,
    this.status,
    this.deliveredAt,
    this.createdAt,
  });

  factory OrderDto.fromJson(Map<String, dynamic> json) => OrderDto(
    id: json['_id'] as String?,
    orderNumber: json['id']?.toString() ?? json['_id']?.toString(),
    cartItems: (json['cartItems'] as List<dynamic>?)
        ?.map((e) => OrderItemDto.fromJson(e as Map<String, dynamic>))
        .toList(),
    totalOrderPrice:
    (json['totalOrderPrice'] as num?)?.toDouble() ?? 0,
    status: json['status'] as String?,
    deliveredAt: json['deliveredAt'] != null
        ? DateTime.tryParse(json['deliveredAt'] as String)
        : null,
    createdAt: json['createdAt'] != null
        ? DateTime.tryParse(json['createdAt'] as String)
        : DateTime.now(),
  );

  OrderStatus _parseStatus(String? s) {
    switch (s?.toLowerCase()) {
      case 'delivered':
        return OrderStatus.completed;
      case 'cancelled':
        return OrderStatus.cancelled;
      case 'processing':
      case 'active':
        return OrderStatus.active;
      default:
        return OrderStatus.pending;
    }
  }

  OrderEntity toDomain() => OrderEntity(
    id: id ?? '',
    orderNumber: orderNumber ?? id ?? '',
    items:
    cartItems?.map((e) => e.toDomain()).toList() ?? [],
    totalPrice: totalOrderPrice ?? 0,
    status: _parseStatus(status),
    deliveredAt: deliveredAt,
    createdAt: createdAt ?? DateTime.now(),
  );
}

class OrdersListDto {
  final int? results;
  final List<OrderDto>? orders;

  const OrdersListDto({this.results, this.orders});

  factory OrdersListDto.fromJson(Map<String, dynamic> json) =>
      OrdersListDto(
        results: json['results'] as int?,
        orders: (json['orders'] as List<dynamic>?)
            ?.map((e) => OrderDto.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}

class CheckoutSessionDto {
  final String? session;

  const CheckoutSessionDto({this.session});

  factory CheckoutSessionDto.fromJson(Map<String, dynamic> json) =>
      CheckoutSessionDto(session: json['session'] as String?);
}

class CashOrderResponseDto {
  final OrderDto? order;
  final Map<String, dynamic> raw;

  const CashOrderResponseDto({this.order, required this.raw});

  factory CashOrderResponseDto.fromJson(Map<String, dynamic> json) =>
      CashOrderResponseDto(
        order: json['data'] != null
            ? OrderDto.fromJson(json['data'] as Map<String, dynamic>)
            : (json['order'] != null
            ? OrderDto.fromJson(json['order'] as Map<String, dynamic>)
            : null),
        raw: json,
      );
}

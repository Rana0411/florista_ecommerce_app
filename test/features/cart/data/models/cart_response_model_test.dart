import 'package:flutter_test/flutter_test.dart';
import 'package:florista_ecommerce_app/features/cart/data/models/cart_dto.dart';
import 'package:florista_ecommerce_app/features/cart/data/models/cart_response_model.dart';

void main() {
  const productJson = {
    '_id': 'prod1',
    'title': 'Rose Bouquet',
    'slug': 'rose-bouquet',
    'description': 'Fresh roses',
    'imgCover': 'cover.jpg',
    'images': <String>[],
    'price': 100,
    'priceAfterDiscount': 90,
    'discount': 10,
    'rateAvg': 4,
    'rateCount': 10,
    'sold': 5,
    'quantity': 20,
    'category': 'cat1',
    'occasion': 'occ1',
    'isSuperAdmin': false,
    'createdAt': '2024-01-01T00:00:00.000Z',
    'updatedAt': '2024-01-02T00:00:00.000Z',
    '__v': 0,
    'id': 'prod1',
  };

  final fullCartJson = {
    'numOfCartItems': 2,
    'cart': {
      '_id': 'cart1',
      'user': 'user1',
      'cartItems': [
        {
          'product': productJson,
          'price': 90,
          'quantity': 1,
          '_id': 'item1',
        },
      ],
      'appliedCoupons': <dynamic>[],
      'discount': 10,
      'totalPrice': 100,
      'totalPriceAfterDiscount': 90,
    },
  };

  group('CartResponseModel', () {
    test('fromJson parses API payload', () {
      final model = CartResponseModel.fromJson(fullCartJson);

      expect(model.numOfCartItems, 2);
      expect(model.cart?.id, 'cart1');
      expect(model.cart?.user, 'user1');
      expect(model.cart?.cartItems, hasLength(1));
      expect(model.cart?.cartItems?.first.quantity, 1);
      expect(model.cart?.totalPrice, 100);
    });

    test('fromJson handles null cart', () {
      final model = CartResponseModel.fromJson({'numOfCartItems': 0});

      expect(model.numOfCartItems, 0);
      expect(model.cart, isNull);
    });

    test('toJson round-trips core fields', () {
      final model = CartResponseModel.fromJson(fullCartJson);
      final json = model.toJson();

      expect(json['numOfCartItems'], 2);
      expect(json['cart'], isA<CartDto>());
    });

    test('copyWith overrides selected fields', () {
      final model = CartResponseModel.fromJson(fullCartJson);
      final updated = model.copyWith(numOfCartItems: 5);

      expect(updated.numOfCartItems, 5);
      expect(updated.cart?.id, model.cart?.id);
    });

    test('toEntity maps full cart response', () {
      final entity = CartResponseModel.fromJson(fullCartJson).toEntity();

      expect(entity.numOfCartItems, 2);
      expect(entity.cart.id, 'cart1');
      expect(entity.cart.user, 'user1');
      expect(entity.cart.cartItems, hasLength(1));
      expect(entity.cart.cartItems.first.quantity, 1);
      expect(entity.cart.cartItems.first.product.title, 'Rose Bouquet');
      expect(entity.cart.discount, 10);
      expect(entity.cart.totalPrice, 100);
      expect(entity.cart.totalPriceAfterDiscount, 90);
    });

    test('toEntity defaults when cart is null', () {
      final entity = CartResponseModel(numOfCartItems: 3).toEntity();

      expect(entity.numOfCartItems, 3);
      expect(entity.cart.id, '');
      expect(entity.cart.user, '');
      expect(entity.cart.cartItems, isEmpty);
      expect(entity.cart.discount, 0);
      expect(entity.cart.totalPrice, 0);
      expect(entity.cart.totalPriceAfterDiscount, 0);
    });

    test('toEntity defaults numOfCartItems to 0 when null', () {
      final entity = CartResponseModel().toEntity();

      expect(entity.numOfCartItems, 0);
    });
  });
}

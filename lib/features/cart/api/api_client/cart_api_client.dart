import 'package:dio/dio.dart';
import 'package:florista_ecommerce_app/core/api_constants/api_endpoints.dart';
import 'package:florista_ecommerce_app/features/cart/data/models/cart_requests_model.dart';
import 'package:florista_ecommerce_app/features/cart/data/models/cart_response_model.dart';
import 'package:florista_ecommerce_app/features/cart/data/models/message_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'cart_api_client.g.dart';

@lazySingleton
@RestApi()
abstract class CartApiClient {
  @FactoryMethod()
  factory CartApiClient(Dio dio) = _CartApiClient;

  @GET(ApiEndpoints.cartOfLoggedUSer)
  Future<CartResponseModel> getCart();

  @DELETE(ApiEndpoints.cartOfLoggedUSer)
  Future<MessageResponseModel> clearCart();

  @POST(ApiEndpoints.cartOfLoggedUSer)
  Future<CartResponseModel> addProductToCart(@Body() AddProductRequest body);

  @DELETE("${ApiEndpoints.cartOfLoggedUSer}/{productId}")
  Future<CartResponseModel> removeProductFromCart(
    @Path("productId") String productId,
  );

  @PUT("${ApiEndpoints.cartOfLoggedUSer}/{productId}")
  Future<CartResponseModel> updateProductQuantity(
    @Path("productId") String productId,
    @Body() UpdateQuantityRequest body,
  );
}

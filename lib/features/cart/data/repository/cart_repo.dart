import '../../../../core/errors/server_failures.dart';
import '../../../../core/services/base_service.dart';
import 'package:dartz/dartz.dart';
import '../models/cart_response_model.dart';

abstract class CartRepo extends BaseServices {
  Future<Either<Failures, CartResponseModel>> getCartItems();
  Future<Either<Failures, CartSummaryModel>> getCartSummary();
  Future<Either<Failures, Map<String, dynamic>>> getCartTotal();
  Future<Either<Failures, Map<String, dynamic>>> addItemToCart({
    required String itemType,
    required String itemId,
  });
  Future<Either<Failures, Map<String, dynamic>>> removeItemFromCart(String cartItemId);
  Future<Either<Failures, Map<String, dynamic>>> clearCart();
}

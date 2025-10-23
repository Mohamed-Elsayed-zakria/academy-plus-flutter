import '../../../../core/constants/api_end_point.dart';
import '../../../../core/errors/server_failures.dart';
import '../../../../core/services/auth_service.dart';
import '../models/cart_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'cart_repo.dart';

class CartImplement extends CartRepo {
  @override
  Future<Either<Failures, CartResponseModel>> getCartItems() async {
    try {
      final token = await AuthService.getToken();
      if (token == null) {
        return left(ServerFailures(errMessage: 'Authentication required'));
      }

      const url = "${APIEndPoint.url}${APIEndPoint.cartItems}";
      final response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final cartResponse = CartResponseModel.fromJson(response.data);
        return right(cartResponse);
      } else {
        return left(ServerFailures(errMessage: 'Failed to fetch cart items'));
      }
    } catch (e) {
      return left(returnDioException(e));
    }
  }

  @override
  Future<Either<Failures, CartSummaryModel>> getCartSummary() async {
    try {
      final token = await AuthService.getToken();
      if (token == null) {
        return left(ServerFailures(errMessage: 'Authentication required'));
      }

      const url = "${APIEndPoint.url}${APIEndPoint.cartSummary}";
      final response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final cartSummary = CartSummaryModel.fromJson(response.data);
        return right(cartSummary);
      } else {
        return left(ServerFailures(errMessage: 'Failed to fetch cart summary'));
      }
    } catch (e) {
      return left(returnDioException(e));
    }
  }

  @override
  Future<Either<Failures, Map<String, dynamic>>> getCartTotal() async {
    try {
      final token = await AuthService.getToken();
      if (token == null) {
        return left(ServerFailures(errMessage: 'Authentication required'));
      }

      const url = "${APIEndPoint.url}${APIEndPoint.cartTotal}";
      final response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return right(response.data);
      } else {
        return left(ServerFailures(errMessage: 'Failed to fetch cart total'));
      }
    } catch (e) {
      return left(returnDioException(e));
    }
  }

  @override
  Future<Either<Failures, Map<String, dynamic>>> addItemToCart({
    required String itemType,
    required String itemId,
  }) async {
    try {
      final token = await AuthService.getToken();
      if (token == null) {
        return left(ServerFailures(errMessage: 'Authentication required'));
      }

      const url = "${APIEndPoint.url}${APIEndPoint.cartItems}";
      final requestData = {
        'itemType': itemType,
        'itemId': itemId,
      };

      final response = await dio.post(
        url,
        data: requestData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return right(response.data);
      } else {
        return left(ServerFailures(errMessage: 'Failed to add item to cart'));
      }
    } catch (e) {
      return left(returnDioException(e));
    }
  }

  @override
  Future<Either<Failures, Map<String, dynamic>>> removeItemFromCart(String cartItemId) async {
    try {
      final token = await AuthService.getToken();
      if (token == null) {
        return left(ServerFailures(errMessage: 'Authentication required'));
      }

      final url = "${APIEndPoint.url}${APIEndPoint.cartItems}/$cartItemId";
      final response = await dio.delete(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return right(response.data);
      } else {
        return left(ServerFailures(errMessage: 'Failed to remove item from cart'));
      }
    } catch (e) {
      return left(returnDioException(e));
    }
  }

  @override
  Future<Either<Failures, Map<String, dynamic>>> clearCart() async {
    try {
      final token = await AuthService.getToken();
      if (token == null) {
        return left(ServerFailures(errMessage: 'Authentication required'));
      }

      const url = "${APIEndPoint.url}${APIEndPoint.cartClear}";
      final response = await dio.delete(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return right(response.data);
      } else {
        return left(ServerFailures(errMessage: 'Failed to clear cart'));
      }
    } catch (e) {
      return left(returnDioException(e));
    }
  }
}

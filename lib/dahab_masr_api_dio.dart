import 'dart:convert';
import 'package:dio/dio.dart';

import 'dahab_masr/cart_item.dart';
import 'dahab_masr/address_info.dart';
import 'dahab_masr/dahab_masr_register_body.dart';

class DahabException implements Exception {
  final String message;

  DahabException(this.message);
}

class DahabMasrApiServicesDio {
  static const bearer = "s1nlrn9ppm74wqqezfreie780t1fj0l8";
  static Dio dio = Dio();

  static Future<void> register(CustomerBody customer) async {
    const url = 'http://dahabmasr.com/rest/V1/customers';
    final headers = {
      'Connection': 'keep-alive',
      'Accept-Encoding': '*/*',
      'Authorization': 'Bearer $bearer',
      'Content-Type': 'application/json',
      'Accept': '*/*',
    };

    print(customer.toJson());

    try {
      final response = await dio.post(
        url,
        options: Options(headers: headers),
        data: customer.toJson(),
      );
      print(response.data.toString());
    } on DioException catch (e) {
      final errorMessage = e.message.toString();
      print(errorMessage);
      // TODO
    }
  }

  static Future<String?> getToken({required String username, required String password}) async {
    final url = 'http://dahabmasr.com/rest/V1/integration/customer/token';
    final headers = {'Authorization': 'Bearer $bearer', 'Content-Type': 'application/json'};
    final data = {'username': username, 'password': password};

    try {
      final response = await dio.post(
        url,
        options: Options(headers: headers),
        data: jsonEncode(data),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        final errorMessage = response.data['message'];
        throw DahabException(errorMessage);
      }
    } catch (e) {
      throw DahabException('Network or request-related error: $e');
    }
  }

  static Future<int?> createCart({required String userToken}) async {
    final url = 'https://dahabmasr.live/a4dev/pub/rest/V1/carts/mine';
    final headers = {
      'Authorization': 'Bearer $userToken',
      'Content-Type': 'application/json',
    };

    try {
      final response = await dio.post(
        url,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return int.tryParse(response.data.toString());
      } else {
        final errorMessage = response.data['message'] ?? 'Failed to create a cart.';
        throw DahabException(errorMessage);
      }
    } catch (e) {
      throw DahabException('Network or request-related error: $e');
    }
  }

  static Future<CartItemResponse?> addToCart({required String userToken, required CartItem cartItem}) async {
    final url = 'https://dahabmasr.live/a4dev/pub/rest/V1/carts/mine/items';
    final headers = {
      'Authorization': 'Bearer $userToken',
      'Content-Type': 'application/json',
    };

    try {
      final response = await dio.post(
        url,
        options: Options(headers: headers),
        data: cartItem.toJson(),
      );

      if (response.statusCode == 200) {
        return CartItemResponse.fromJson(response.data);
      } else {
        final errorMessage = response.data['message'] ?? 'Failed to add item to the cart.';
        throw DahabException(errorMessage);
      }
    } catch (e) {
      throw DahabException('Network or request-related error: $e');
    }
  }

  static Future<void> submitShippingInformation({
    required String userToken,
    required AddressInformation addressInfo,
  }) async {
    final url = 'https://dahabmasr.live/a4dev/pub/rest/V1/carts/mine/shipping-information';
    final headers = {
      'Authorization': 'Bearer $userToken',
      'Content-Type': 'application/json',
    };

    try {
      final response = await dio.post(
        url,
        options: Options(headers: headers),
        data: addressInfo.toJson(),
      );

      if (response.statusCode == 200) {
        // Successfully submitted shipping information
      } else {
        final errorMessage = response.data['message'] ?? 'Failed to submit shipping information.';
        throw DahabException(errorMessage);
      }
    } catch (e) {
      throw DahabException('Network or request-related error: $e');
    }
  }

  static Future<int?> submitPaymentInformation(
    String bearerToken,
  ) async {
    final url = 'https://dahabmasr.live/a4dev/pub/rest/V1/carts/mine/payment-information';
    final headers = {
      'Authorization': 'Bearer $bearerToken',
      'Content-Type': 'application/json',
    };

    try {
      final response = await dio.post(
        url,
        options: Options(headers: headers),
        data: {
          "paymentMethod": {"method": "checkmo"}
        },
      );

      if (response.statusCode == 200) {
        return int.tryParse(response.data.toString());
      } else {
        final errorMessage = response.data['message'] ?? 'Failed to submit payment information.';
        throw DahabException(errorMessage);
      }
    } catch (e) {
      throw DahabException('Network or request-related error: $e');
    }
  }
}

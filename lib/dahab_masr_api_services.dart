import 'dart:convert';
import 'package:dahab_masr/dahab_masr/address_info.dart';
import 'package:dahab_masr/dahab_masr/dahab_masr_register_body.dart';
import 'package:http/http.dart' as http;

import 'dahab_masr/cart_item.dart';

class DahabException implements Exception {
  final String message;

  DahabException(this.message);
}

class DahabMasrApiServices {
  static const bearer = "s1nlrn9ppm74wqqezfreie780t1fj0l8";
  static Future<void> register(CustomerBody customer) async {
    final url = Uri.parse('http://dahabmasr.com/rest/V1/customers');
    final headers = {
      'Connection': 'keep-alive',
      'Accept-Encoding': '*/*',
      'Authorization': 'Bearer $bearer',
      'Content-Type': 'application/json',
      'Accept': '*/*',
      // 'User-Agent': 'PostmanRuntime/7.32.3'
    };

    final body = jsonEncode(customer.toJson());
    print(body);
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Customer created successfully.');
    } else {
      final responseBody = jsonDecode(response.body);
      final errorMessage = responseBody['message'];
      print(errorMessage);
      // throw DahabException(errorMessage);
    }
  }

  static Future<String?> getToken({required String username, required String password}) async {
    final url = Uri.parse('http://dahabmasr.com/rest/V1/integration/customer/token');
    final headers = {'Authorization': 'Bearer $bearer', 'Content-Type': 'application/json'};
    final body = jsonEncode({'username': username, 'password': password});
    try {
      final response = await http.post(url, body: body, headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      } else {
        final responseBody = jsonDecode(response.body);
        final errorMessage = responseBody['message'];
        throw DahabException(errorMessage);
      }
    } catch (e) {
      throw DahabException('Network or request-related error: $e');
    }
  }

  static Future<int?> createCart({required String userToken}) async {
    final url = Uri.parse('https://dahabmasr.live/a4dev/pub/rest/V1/carts/mine');
    final headers = {
      'Authorization': 'Bearer $userToken',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.post(url, headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Successfully created a cart
        return int.tryParse(response.body);
      } else {
        // Handle the error case, extracting the "message" field if available
        final responseBody = jsonDecode(response.body);
        final errorMessage = responseBody['message'] ?? 'Failed to create a cart.';
        throw DahabException(errorMessage);
      }
    } catch (e) {
      // Handle any network or request-related errors
      throw DahabException('Network or request-related error: $e');
    }
  }

  static Future<CartItemResponse?> addToCart({required String userToken, required CartItem cartItem}) async {
    final url = Uri.parse('https://dahabmasr.live/a4dev/pub/rest/V1/carts/mine/items');
    final headers = {
      'Authorization': 'Bearer $userToken',
      'Content-Type': 'application/json',
    };
    try {
      final body = jsonEncode(cartItem.toJson());
      print(body);
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return CartItemResponse.fromJson(jsonResponse);
      } else {
        // Handle the error case, extracting the "message" field if available
        final responseBody = jsonDecode(response.body);
        final errorMessage = responseBody['message'] ?? 'Failed to add item to the cart.';
        throw DahabException(errorMessage);
      }
    } catch (e) {
      // Handle any network or request-related errors
      throw DahabException('Network or request-related error: $e');
    }
  }

  static Future<void> submitShippingInformation({
    required String userToken,
    required AddressInformation addressInfo,
  }) async {
    final url = Uri.parse('https://dahabmasr.live/a4dev/pub/rest/V1/carts/mine/shipping-information');
    final headers = {
      'Authorization': 'Bearer $userToken',
      'Content-Type': 'application/json',
    };

    try {
      final body = jsonEncode(addressInfo.toJson());
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        // Successfully submitted shipping information
      } else {
        // Handle the error case, extracting the "message" field if available
        final responseBody = jsonDecode(response.body);
        final errorMessage = responseBody['message'] ?? 'Failed to submit shipping information.';
        throw DahabException(errorMessage);
      }
    } catch (e) {
      // Handle any network or request-related errors
      throw DahabException('Network or request-related error: $e');
    }
  }

  static Future<int?> submitPaymentInformation(
    String bearerToken,
  ) async {
    final url = Uri.parse('https://dahabmasr.live/a4dev/pub/rest/V1/carts/mine/payment-information');
    final headers = {
      'Authorization': 'Bearer $bearerToken',
      'Content-Type': 'application/json',
    };
    try {
      final body = jsonEncode({
        "paymentMethod": {"method": "checkmo"}
      });
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        return int.tryParse(response.body.toString());
        // Successfully submitted payment information
      } else {
        // Handle the error case, extracting the "message" field if available
        final responseBody = jsonDecode(response.body);
        final errorMessage = responseBody['message'] ?? 'Failed to submit payment information.';
        throw DahabException(errorMessage);
      }
    } catch (e) {
      // Handle any network or request-related errors
      throw DahabException('Network or request-related error: $e');
    }
  }
}

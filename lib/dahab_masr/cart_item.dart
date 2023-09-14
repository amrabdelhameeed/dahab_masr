class CartItem {
  String sku;
  int qty;
  String quoteId;

  CartItem({
    required this.sku,
    required this.qty,
    required this.quoteId,
  });

  Map<String, dynamic> toJson() {
    return {
      'cartItem': {
        'sku': sku,
        'qty': qty,
        'quote_id': quoteId,
      }
    };
  }
}

class CartItemResponse {
  final int itemId;
  final String sku;
  final int qty;
  final String name;
  final double price;
  final String productType;
  final String quoteId;

  CartItemResponse({
    required this.itemId,
    required this.sku,
    required this.qty,
    required this.name,
    required this.price,
    required this.productType,
    required this.quoteId,
  });

  factory CartItemResponse.fromJson(Map<String, dynamic> json) {
    return CartItemResponse(
      itemId: json['item_id'] ?? 0,
      sku: json['sku'] ?? '',
      qty: json['qty'] ?? 0,
      name: json['name'] ?? '',
      price: json['price']?.toDouble() ?? 0.0,
      productType: json['product_type'] ?? '',
      quoteId: json['quote_id'] ?? '',
    );
  }
}

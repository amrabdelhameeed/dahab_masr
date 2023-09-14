class AddressInformation {
  final ShippingAddress shippingAddress;
  final ShippingAddress billingAddress;
  final String shippingMethodCode;
  final String shippingCarrierCode;

  AddressInformation({
    required this.shippingAddress,
    required this.billingAddress,
    this.shippingMethodCode = "flatrate",
    this.shippingCarrierCode = "flatrate",
  });

  Map<String, dynamic> toJson() {
    return {
      'addressInformation': {
        'shippingAddress': shippingAddress.toJson(),
        'billingAddress': billingAddress.toJson(),
        'shipping_method_code': shippingMethodCode,
        'shipping_carrier_code': shippingCarrierCode,
      }
    };
  }
}

class ShippingAddress {
  final String region;
  final int regionId;
  final String regionCode;
  final String countryId;
  final List<String> street;
  final String postcode;
  final String city;
  final String firstname;
  final String lastname;
  final String email;
  final String telephone;

  ShippingAddress({
    required this.region,
    required this.regionId,
    required this.regionCode,
    required this.countryId,
    required this.street,
    required this.postcode,
    required this.city,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.telephone,
  });

  Map<String, dynamic> toJson() {
    return {
      'region': region,
      'region_id': regionId,
      'region_code': regionCode,
      'country_id': countryId,
      'street': street,
      'postcode': postcode,
      'city': city,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'telephone': telephone,
    };
  }
}

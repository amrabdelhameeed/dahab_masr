class CustomerBody {
  String? email;
  String? firstname;
  String? lastname;
  String? password;
  List<Address>? addresses;
  List<CustomAttribute>? customAttributes;

  CustomerBody({required this.email, required this.firstname, required this.lastname, required this.addresses, required this.customAttributes, required this.password});

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>>? addressesJson = addresses?.map((address) => address.toJson()).toList();
    List<Map<String, dynamic>>? customAttributesJson = customAttributes?.map((attribute) => attribute.toJson()).toList();

    return {
      'customer': {
        'email': email,
        'firstname': firstname,
        'lastname': lastname,
        'addresses': addressesJson,
        'custom_attributes': customAttributesJson,
      },
      'password': password,
    };
  }
}

class Address {
  bool? defaultShipping;
  bool? defaultBilling;
  String? firstname;
  String? lastname;
  Region? region;
  String? postcode;
  List<String>? street;
  String? city;
  String? telephone;
  String? countryId;

  Address({
    this.defaultShipping = true,
    this.defaultBilling = true,
    required this.firstname,
    required this.lastname,
    this.region,
    this.postcode = "10755",
    this.street = const [""],
    this.city = "Cairo",
    required this.telephone,
    this.countryId = "EG",
  });

  Map<String, dynamic> toJson() {
    List<String>? streetJson = street;

    return {
      'defaultShipping': defaultShipping,
      'defaultBilling': defaultBilling,
      'firstname': firstname,
      'lastname': lastname,
      'region': region?.toJson(),
      'postcode': postcode,
      'street': streetJson,
      'city': city,
      'telephone': telephone,
      'countryId': countryId,
    };
  }
}

class Region {
  String? regionCode;
  String? regionName;
  int? regionId;

  Region({
    this.regionCode = "Cairo",
    this.regionName = "Cairo",
    this.regionId = 1122,
  });

  Map<String, dynamic> toJson() {
    return {
      'regionCode': regionCode,
      'region': regionName,
      'regionId': regionId,
    };
  }
}

class CustomAttribute {
  String? attributeCode;
  String? value;

  CustomAttribute({
    this.attributeCode = "mobile_number",
    required this.value,
  });

  Map<String, dynamic> toJson() {
    return {
      'attribute_code': attributeCode,
      'value': value,
    };
  }
}

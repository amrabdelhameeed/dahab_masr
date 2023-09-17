import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magento Account Creation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Dio dio = Dio();
  final String apiUrl = 'https://dahabmasr.live/a4dev/pub/rest/V1/customers';
  final String apiToken = 's1nlrn9ppm74wqqezfreie780t1fj0l8'; // Replace with your Magento API token

  Future<void> createMagentoAccount() async {
    // Define the customer data and password
    final customerData = {
      "customer": {
        "email": "custome213r@example.com",
        "firstname": "John",
        "lastname": "Doe",
        "addresses": [
          {
            "defaultShipping": true,
            "defaultBilling": true,
            "firstname": "John",
            "lastname": "Doe",
            "region": {"regionCode": "Cairo", "region": "Cairo", "regionId": 1122},
            "postcode": "10755",
            "street": ["123 Oak Ave"],
            "city": "Cairo",
            "telephone": "512551111",
            "countryId": "EG"
          }
        ],
        "custom_attributes": [
          {"attribute_code": "mobile_number", "value": "123456789"}
        ]
      },
      "password": "Password123"
    };

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiToken',
      'Access-Control-Allow-Origin': '*',
    };

    try {
      final response = await dio.post(
        apiUrl,
        options: Options(
          headers: headers,
        ),
        data: customerData,
      );

      if (response.statusCode == 200) {
        print('Account created successfully');
        // Handle success as needed
      } else {
        print('Failed to create account. Status code: ${response.statusCode}');
        print('Error response: ${response.data}');
        // Handle error as needed
      }
    } catch (error) {
      print('Network request error: $error');
      // Handle the error accordingly
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Magento Account Creation'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: createMagentoAccount,
          child: Text('Create Account'),
        ),
      ),
    );
  }
}

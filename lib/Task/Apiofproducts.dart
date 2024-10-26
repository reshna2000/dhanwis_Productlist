import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Modelclass.dart';

class Apiofproducts {
  final String api = 'https://dummyjson.com/products';
  final int limit = 10;

  Future<List<Product>> fetchProducts(int page) async {
    final int skip = (page - 1) * limit;
    final response = await http.get(Uri.parse('$api?limit=$limit&skip=$skip'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("API Response Data: $data"); // Debugging output

      if (data['products'] != null) {
        return (data['products'] as List)
            .map((json) => Product.fromJson(json))
            .toList();
      } else {
        print("No 'products' key found in response data.");
        return [];
      }
    } else {
      print("Failed to load products. Status code: ${response.statusCode}");
      throw Exception('Failed to load products');
    }
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products {
    return [..._products];
  }

  Future<void> fetchProducts() async {
    const url = 'https://fakestoreapi.com/products';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> productData = json.decode(response.body);
        _products = productData
            .map((productJson) => Product.fromJson(productJson))
            .toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (error) {
      throw Exception('Failed to fetch data: $error');
    }
  }

  Product findById(String id) {
    return _products.firstWhere((prod) => prod.id == id);
  }
}

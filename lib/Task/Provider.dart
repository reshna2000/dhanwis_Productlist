import 'package:dhanwis/Task/Apiofproducts.dart';
import 'package:flutter/material.dart';
import 'Modelclass.dart';

class ProductProvider with ChangeNotifier {
 final Apiofproducts productRepository;
 List<Product> _products = [];
 bool _isLoading = false;
 bool _attheend = false;
 int _currentPage = 1;

 ProductProvider({required this.productRepository});
 List<Product> get products => _products;
 bool get isLoading => _isLoading;
 bool get hasReachedMax => _attheend;

 Future<void> fetchProducts() async {
  if (_isLoading || _attheend) return;

  _isLoading = true;
  notifyListeners();

  try {
   final newProducts = await productRepository.fetchProducts(_currentPage);

   if (newProducts.isEmpty) {
    _attheend = true;
   } else {
    _products.addAll(newProducts);
    _currentPage++;
   }
  } catch (e) {
   print("Error fetching products: $e");
  } finally {
   _isLoading = false;
   notifyListeners();
  }
 }

 void resetPagination() {
  _products.clear();
  _currentPage = 1;
  _attheend = false;
  fetchProducts();
 }
}
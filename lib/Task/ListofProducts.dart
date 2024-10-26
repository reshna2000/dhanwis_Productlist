import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Provider.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
      final productProvider = Provider.of<ProductProvider>(context, listen: false);
      productProvider.fetchProducts();


    _scrollController.addListener(() {
      final productProvider = Provider.of<ProductProvider>(context, listen: false);
        productProvider.fetchProducts();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Product List')),
      body: productProvider.isLoading && productProvider.products.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
           controller: _scrollController,
           itemCount: productProvider.hasReachedMax
            ? productProvider.products.length
            : productProvider.products.length + 1,
           itemBuilder: (context, index) {
          if (index >= productProvider.products.length) {
            return Center(child: CircularProgressIndicator());
          }
          final product = productProvider.products[index];
          return ListTile(
            title: Text(product.name,style: TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Text(product.description),
          );
        },
      ),
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wildbrevis_shop_app/providers/products_provider.dart';

class ProductDetailPage extends StatelessWidget {
  static const routeName = '/product_detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;

//listen=false turn off the listen possibility after the first usage of provider
//this prevents of rebuilding the widget after any change in ProductProvider class
//use it if need data only one time
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    final product = productsProvider.findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text('${product.name}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '\$${product.price}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              width: double.infinity,
              child: Text(
                product.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

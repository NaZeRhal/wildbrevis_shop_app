import 'package:flutter/material.dart';
import 'package:wildbrevis_shop_app/widgets/products_grid.dart';

class ProductsOverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wildbrevis'),
      ),
      body: ProductsGrid(),
    );
  }
}

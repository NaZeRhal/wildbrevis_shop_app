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
    );
  }
}

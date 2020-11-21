import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wildbrevis_shop_app/providers/products_provider.dart';
import 'package:wildbrevis_shop_app/screens/edit_product_page.dart';
import 'package:wildbrevis_shop_app/widgets/app_drawer.dart';
import 'package:wildbrevis_shop_app/widgets/user_product_item.dart';

class UserProductsPage extends StatelessWidget {
  static const routeName = '/user_products';

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).pushNamed(EditProductPage.routeName),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (ctx, index) => Column(
            children: [
              UserProductItem(
                id: productsProvider.items[index].id,
                name: productsProvider.items[index].name,
                imageUrl: productsProvider.items[index].imageUrl,
              ),
              Divider(),
            ],
          ),
          itemCount: productsProvider.items.length,
        ),
      ),
    );
  }
}

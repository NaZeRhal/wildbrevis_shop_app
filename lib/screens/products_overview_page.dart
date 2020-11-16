import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wildbrevis_shop_app/providers/cart_provider.dart';
import 'package:wildbrevis_shop_app/screens/cart_page.dart';
import 'package:wildbrevis_shop_app/widgets/app_drawer.dart';
import 'package:wildbrevis_shop_app/widgets/badge.dart';
import 'package:wildbrevis_shop_app/widgets/products_grid.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewPage extends StatefulWidget {
  @override
  _ProductsOverviewPageState createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wildbrevis'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<CartProvider>(
            //child of consumer doesn't rebuild!!!
            builder: (ctx, cart, childOfConsumer) => Badge(
              child: childOfConsumer,
              value: cart.itemsCount.toString(),
            ),
            //child of consumer doesn't rebuild!!!
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartPage.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(showOnlyFavorites: _showOnlyFavorites),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wildbrevis_shop_app/providers/cart_provider.dart'
    show CartProvider;
import 'package:wildbrevis_shop_app/providers/orders_provider.dart';
import 'package:wildbrevis_shop_app/widgets/cart_item.dart';

class CartPage extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cartProvider.totalSum.toStringAsFixed(2)}',
                      style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headline1
                              .color),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    onPressed: () {
                      Provider.of<OrdersProvider>(context, listen: false)
                          .addOrder(
                        cartProvider.items.values.toList(),
                        cartProvider.totalSum,
                      );
                      cartProvider.clear();
                    },
                    child: Text('ORDER NOW'),
                    textColor: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, index) => CartItem(
                id: cartProvider.items.values.toList()[index].id,
                productId: cartProvider.items.keys.toList()[index],
                price: cartProvider.items.values.toList()[index].price,
                quantity: cartProvider.items.values.toList()[index].quantity,
                name: cartProvider.items.values.toList()[index].name,
              ),
              itemCount: cartProvider.itemsCount,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wildbrevis_shop_app/providers/orders_provider.dart'
    show OrdersProvider;
import 'package:wildbrevis_shop_app/widgets/app_drawer.dart';
import 'package:wildbrevis_shop_app/widgets/order_item.dart';

class OrdersPage extends StatelessWidget {
  static const routeName = '/order_page';

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Order'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemBuilder: (ctx, index) =>
            OrderItem(order: ordersProvider.orders[index]),
        itemCount: ordersProvider.orders.length,
      ),
    );
  }
}

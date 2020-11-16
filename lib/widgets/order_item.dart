import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wildbrevis_shop_app/providers/orders_provider.dart'
    as order_provoder;

class OrderItem extends StatelessWidget {
  final order_provoder.OrderItem order;

  const OrderItem({@required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${order.amount}'),
            subtitle:
                Text(DateFormat('dd MMM yyyy HH:mm').format(order.dateTime)),
            trailing: IconButton(
              icon: Icon(Icons.expand_more),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

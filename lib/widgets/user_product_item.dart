import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wildbrevis_shop_app/providers/products_provider.dart';
import 'package:wildbrevis_shop_app/screens/edit_product_page.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String name;
  final String imageUrl;

  const UserProductItem({
    @required this.name,
    @required this.imageUrl,
    @required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
        radius: 26,
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => Navigator.of(context).pushNamed(
                      EditProductPage.routeName,
                      arguments: id,
                    ),
                color: Theme.of(context).primaryColor),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                Provider.of<ProductsProvider>(context, listen: false)
                    .deleteProduct(id);
              },
              color: Theme.of(context).errorColor,
            )
          ],
        ),
      ),
    );
  }
}

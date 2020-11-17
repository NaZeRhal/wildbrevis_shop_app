import 'package:flutter/material.dart';
import 'package:wildbrevis_shop_app/screens/edit_product_page.dart';

class UserProductItem extends StatelessWidget {
  final String name;
  final String imageUrl;

  const UserProductItem({
    @required this.name,
    @required this.imageUrl,
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
                onPressed: () =>
                    Navigator.of(context).pushNamed(EditProductPage.routeName),
                color: Theme.of(context).primaryColor),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {},
              color: Theme.of(context).errorColor,
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/foundation.dart';

class ProductProvider with ChangeNotifier {
  final String id;
  final String name;
  final double price;
  final String description;
  final String imageUrl;
  bool isFavorite;

  ProductProvider({
    @required this.id,
    @required this.name,
    @required this.price,
    @required this.description,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}

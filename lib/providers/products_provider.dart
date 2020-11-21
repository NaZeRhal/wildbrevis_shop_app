import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wildbrevis_shop_app/providers/product.dart';

class ProductsProvider with ChangeNotifier {
  List<ProductProvider> _items = [
    ProductProvider(
      id: 'p1',
      name: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    ProductProvider(
      id: 'p2',
      name: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    ProductProvider(
      id: 'p3',
      name: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    ProductProvider(
      id: 'p4',
      name: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<ProductProvider> get items {
    return [..._items];
  }

  List<ProductProvider> get favoriteItems {
    return _items.where((product) => product.isFavorite).toList();
  }

  Future<void> addProduct(ProductProvider product) {
    const url = 'https://fluttertestapp-b5e73.firebaseio.com/products.json';
    return http
        .post(
      url,
      body: json.encode(
        {
          'title': product.name,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavorite,
        },
      ),
    )
        .then((response) {
      final newProduct = ProductProvider(
        id: json.decode(response.body)['name'],
        name: product.name,
        price: product.price,
        description: product.description,
        imageUrl: product.imageUrl,
      );
      _items.add(newProduct);
      notifyListeners();
    }).catchError((error) {
      print(error);
      throw error;
    });
  }

  void updateProduct(String id, ProductProvider product) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = product;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  ProductProvider findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }
}

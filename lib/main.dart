import 'package:flutter/material.dart';
import 'package:wildbrevis_shop_app/providers/cart.dart';
import 'package:wildbrevis_shop_app/providers/products_provider.dart';
import 'package:wildbrevis_shop_app/screens/cart_page.dart';
import 'package:wildbrevis_shop_app/screens/product_detail.dart';
import 'package:wildbrevis_shop_app/screens/products_overview_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CartProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Wildbrevis',
        theme: ThemeData(
          primaryTextTheme: TextTheme(
            headline1: TextStyle(
              color: Colors.white,
            ),
          ),
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewPage(),
        routes: {
          ProductDetailPage.routeName: (ctx) => ProductDetailPage(),
          CartPage.routeName: (ctx) => CartPage(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wildbrevis'),
      ),
      body: Center(
        child: Text('Text'),
      ),
    );
  }
}
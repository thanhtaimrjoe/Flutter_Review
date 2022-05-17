import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yama_shopping/modal/cart.dart';
import 'package:yama_shopping/modal/user.dart';
import 'package:yama_shopping/screen/cart.dart';
import 'package:yama_shopping/screen/catalog.dart';
import 'package:yama_shopping/screen/product.dart';
import 'package:yama_shopping/services/category_service.dart';
import 'screen/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  CategoryService categoryService = CategoryService();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //catalog.fetchCategories;
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => User('thanhtaimrjoe', 'Thanhtai100'),
        ),
        // Provider(
        //   create: (context) => Catalog(),
        // ),
        FutureProvider<List<dynamic>>(
          initialData: [],
          create: (context) => categoryService.fetchCategories(),
        ),
        // ChangeNotifierProvider(
        //   create: (context) => Cart(),
        // ),
      ],
      child: MaterialApp(
        theme: ThemeData(backgroundColor: Colors.teal[400]),
        initialRoute: '/',
        routes: {
          '/': (context) => MyLogin(),
          '/catalog': (context) => MyCatalog(),
          '/product': (context) => MyProduct(),
          //'/cart': (context) => MyCart(),
        },
      ),
    );
  }
}

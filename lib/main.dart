import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:yama_shopping/modal/cart.dart';
import 'package:yama_shopping/modal/user.dart';
import 'package:yama_shopping/screen/cart.dart';
import 'package:yama_shopping/screen/catalog.dart';
import 'package:yama_shopping/screen/product.dart';
import 'package:yama_shopping/services/category_service.dart';
import 'screen/login.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
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
          FutureProvider<List<dynamic>>(
            initialData: [],
            create: (context) => categoryService.fetchCategories(),
          ),
          ChangeNotifierProvider<Cart>(
            create: (context) => Cart(),
          ),
        ],
        child: FutureBuilder(
          future: _fbApp,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print('You have an error! ${snapshot.error.toString()}');
              // ignore: prefer_const_constructors
              return Center(child: Text('Something went wrong'));
            } else if (snapshot.hasData) {
              return MaterialApp(
                theme: ThemeData(backgroundColor: Colors.teal[400]),
                initialRoute: '/',
                routes: {
                  '/': (context) => MyLogin(),
                  '/catalog': (context) => MyCatalog(),
                  '/product': (context) => MyProduct(),
                  '/cart': (context) => MyCart(),
                },
              );
            } else {
              return SpinKitCubeGrid(
                color: Colors.teal[400],
              );
            }
          },
        ));
  }
}

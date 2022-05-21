import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yama_shopping/modal/cart.dart';
import 'package:yama_shopping/screen/cart.dart';
import 'package:yama_shopping/screen/catalog.dart';
import 'package:yama_shopping/screen/product.dart';
import 'package:yama_shopping/services/authentication_service.dart';
import 'package:yama_shopping/services/category_service.dart';
import 'screen/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
          Provider<AuthenticationService>(
              create: (_) => AuthenticationService(FirebaseAuth.instance)),
          StreamProvider(
            create: (context) =>
                context.read<AuthenticationService>().authStateChanges,
            initialData: null,
          ),
          FutureProvider<List<dynamic>>(
            initialData: [],
            create: (context) => categoryService.firestoreCategories(),
          ),
          ChangeNotifierProvider<Cart>(
            create: (context) => Cart(),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(backgroundColor: Colors.teal[400]),
          initialRoute: '/',
          routes: {
            '/': (context) => MyLogin(),
            '/catalog': (context) => MyCatalog(),
            '/product': (context) => MyProduct(),
            '/cart': (context) => MyCart(),
          },
        ));
  }
}

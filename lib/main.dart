import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yama_shopping/constants.dart';
import 'package:yama_shopping/modal/cart.dart';
import 'package:yama_shopping/screen/home/home.dart';
import 'package:yama_shopping/screen/list_product.dart';
import 'package:yama_shopping/screen/product/product.dart';
import 'package:yama_shopping/services/authentication_service.dart';
import 'package:yama_shopping/services/category_service.dart';
import 'screen/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  CategoryService categoryService = CategoryService();

  MyApp({Key? key}) : super(key: key);
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
            initialData: const [],
            create: (context) => categoryService.firestoreCategories(),
          ),
          ChangeNotifierProvider<Cart>(
            create: (context) => Cart(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.teal,
              scaffoldBackgroundColor: bgColor,
              fontFamily: "Gordita",
              textTheme:
                  const TextTheme(bodyText2: TextStyle(color: Colors.black54))),
          initialRoute: '/',
          routes: {
            '/': (context) => const MyLogin(),
            '/catalog': (context) => const MyHome(),
            '/list_product': (context) => MyListProductPage(),
            '/product': (context) => const MyProductPage(),
          },
        ));
  }
}

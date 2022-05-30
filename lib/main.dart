import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yamabi_admin/constants.dart';
import 'package:yamabi_admin/modal/user.dart';
import 'package:yamabi_admin/screen/home/home.dart';
import 'package:yamabi_admin/screen/login.dart';
import 'package:yamabi_admin/screen/product/product.dart';
import 'package:yamabi_admin/services/categories_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => User('', '', '', '')),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const MyLoginPage(),
          '/home': (context) => const MyHomePage(),
          '/product': (context) => const MyProduct()
        },
      ),
    );
  }
}

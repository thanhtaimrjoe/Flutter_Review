import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:provider/provider.dart';
import 'package:yamabi_admin/modal/user.dart';
import 'package:yamabi_admin/routes/route_names.dart';
import 'package:yamabi_admin/routes/router.dart';
import 'package:yamabi_admin/screen/templete/templete.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUrlStrategy(PathUrlStrategy());
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
        builder: (context, child) => MyTemplete(widget: child!),
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: RoutesName.LOGIN_PAGE,
      ),
    );
  }
}

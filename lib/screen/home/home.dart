import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yamabi_admin/modal/user.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);
    return Scaffold(
      body: Center(
        child: Text('Welcome ${user.fullname}'),
      ),
    );
  }
}

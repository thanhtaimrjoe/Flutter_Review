import 'package:flutter/material.dart';
import 'package:yamabi_admin/constants.dart';
import 'package:yamabi_admin/screen/home/components/appbar.dart';
import 'package:yamabi_admin/screen/home/components/view_page.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          automaticallyImplyLeading: false,
          elevation: 0,
          toolbarHeight: 100.0,
          title: const MyAppBar(),
        ),
        body: const MyViewPage(),
      ),
    );
  }
}

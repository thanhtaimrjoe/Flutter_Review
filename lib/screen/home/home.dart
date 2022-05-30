import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yamabi_admin/constants.dart';
import 'package:yamabi_admin/modal/user.dart';
import 'package:yamabi_admin/screen/home/components/appbar.dart';
import 'package:yamabi_admin/screen/home/components/view_page.dart';
import 'package:yamabi_admin/services/categories_service.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);
    CategoryService categoryService = CategoryService();
    return FutureProvider<List<dynamic>>(
      create: (context) => categoryService.fetchCategories(),
      initialData: const [],
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            automaticallyImplyLeading: false,
            elevation: 0,
            toolbarHeight: 100.0,
            title: const MyAppBar(),
            bottom: const TabBar(tabs: [
              Tab(text: 'View'),
              Tab(text: 'Create'),
            ]),
          ),
          body: TabBarView(children: [
            MyViewPage(),
            Center(
                child: ElevatedButton(
              child: Text('Go to nested page'),
              onPressed: () {},
            )),
          ]),
        ),
      ),
    );
  }
}

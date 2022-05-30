import 'package:flutter/material.dart';
import 'package:yamabi_admin/constants.dart';
import 'package:yamabi_admin/modal/product.dart';
import 'package:yamabi_admin/screen/home/components/appbar.dart';

class MyProduct extends StatelessWidget {
  const MyProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final product = ModalRoute.of(context)!.settings.arguments as Product;
    Size size = MediaQuery.of(context).size;
    var outlineInputBorder = const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(5.0)));
    Product product = Product(
        'A1',
        'ワンピース',
        'https://firebasestorage.googleapis.com/v0/b/yama-98f64.appspot.com/o/%E3%82%A2%E3%82%AF%E3%82%B7%E3%83%A7%E3%83%B3%2Fproducts%2F%E3%83%AF%E3%83%B3%E3%83%94%E3%83%BC%E3%82%B9%2Fonepiece001.jpg?alt=media&token=8143c2f9-2130-43e8-8ae7-6905664df4a6',
        'overview',
        'A11');
    return Scaffold(
        appBar: AppBar(
            backgroundColor: primaryColor,
            automaticallyImplyLeading: false,
            elevation: 0,
            toolbarHeight: 130.0,
            title: MyAppBar(outlineInputBorder: outlineInputBorder)),
        body: Container(
          width: size.width,
          color: backgroundColor,
          child: Column(
            children: [Text('Hello')],
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:yama_shopping/modal/product.dart';
import 'package:yama_shopping/screen/product/components/product_appbar.dart';

class MyProductPage extends StatelessWidget {
  const MyProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var argument = ModalRoute.of(context)!.settings.arguments as Map;
    Product product = Product(argument['categoryID'], argument['name'],
        argument['price'], argument['image']);
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        const ProductAppBar(),
        SliverToBoxAdapter(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  width: size.width,
                  height: 200,
                  color: Colors.amberAccent,
                ),
                Container(
                  margin: const EdgeInsets.all(8),
                  width: size.width,
                  height: 200,
                  color: Colors.black26,
                ),
                Container(
                  margin: const EdgeInsets.all(8),
                  width: size.width,
                  height: 200,
                  color: Colors.greenAccent,
                ),
                Container(
                  margin: const EdgeInsets.all(8),
                  width: size.width,
                  height: 200,
                  color: Colors.redAccent,
                ),
                Container(
                  margin: const EdgeInsets.all(8),
                  width: size.width,
                  height: 200,
                  color: Colors.pinkAccent,
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:yama_shopping/modal/product.dart';

class MyProductPage extends StatelessWidget {
  const MyProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var argument = ModalRoute.of(context)!.settings.arguments as Map;
    Product product = Product(
        argument['id'], argument['name'], argument['price'], argument['image']);
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          floating: true,
          snap: true,
          title: Text('AppBar'),
          centerTitle: true,
        )
      ],
      body: SingleChildScrollView(
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
    ));
  }
}

// Image.network(product.image,
//           width: size.width,
//           height: size.height * 0.4,
//           fit: BoxFit.fitWidth,
//           color: const Color.fromARGB(125, 2, 16, 53),
//           colorBlendMode: BlendMode.modulate)
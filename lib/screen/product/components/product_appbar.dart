import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:yama_shopping/modal/product.dart';

class ProductAppBar extends StatelessWidget {
  const ProductAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var argument = ModalRoute.of(context)!.settings.arguments as Map;
    Product product = Product(argument['categoryID'], argument['name'],
        argument['price'], argument['image']);
    return SliverAppBar(
      //title: Text(product.name),
      floating: true,
      pinned: true,
      expandedHeight: 200,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios)),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.star_border)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          padding: const EdgeInsets.only(top: 80),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(product.image), fit: BoxFit.fitWidth),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Image.network(product.image, height: 130),
                  const SizedBox(width: 16),
                  SizedBox(
                    width: size.width - 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                              color: Colors.grey,
                              backgroundBlendMode: BlendMode.modulate),
                          child: Text(
                            product.categoryID,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

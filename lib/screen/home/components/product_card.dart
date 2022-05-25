import 'package:flutter/material.dart';
import 'package:yama_shopping/constants.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.title,
    required this.image,
    required this.press,
  }) : super(key: key);

  final String title, image;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        width: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(image),
            Text(
              title,
              maxLines: 1,
              style: const TextStyle(color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}

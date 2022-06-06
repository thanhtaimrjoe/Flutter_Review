import 'package:flutter/material.dart';
import 'package:yamabi_admin/constants.dart';
import 'package:yamabi_admin/modal/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product,
    required this.press,
  }) : super(key: key);

  final Product product;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // ignore: sort_child_properties_last
      child: Container(
        margin: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                product.image,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: defaultPadding / 4),
            Text(
              product.name,
              maxLines: 1,
            ),
          ],
        ),
      ),
      onTap: press,
    );
  }
}

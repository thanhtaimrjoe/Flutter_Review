import 'package:flutter/material.dart';
import 'package:yamabi_admin/constants.dart';
import 'package:yamabi_admin/modal/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: Column(
          children: [
            Image.network(product.image, width: double.infinity),
            const SizedBox(height: defaultPadding / 4),
            Text(
              product.name,
              maxLines: 1,
            ),
          ],
        ),
      ),
      onTap: () {
        print('productID: ${product.productID}');
      },
    );
  }
}

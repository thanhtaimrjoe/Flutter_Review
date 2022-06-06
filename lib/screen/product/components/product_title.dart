import 'package:flutter/material.dart';
import 'package:yama_shopping/constants.dart';

class ProductTitle extends StatelessWidget {
  const ProductTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.all(defaultPadding),
        child: Row(
          children: [
            Container(width: 10, height: 25, color: primaryColor),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

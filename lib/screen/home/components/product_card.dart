import 'package:flutter/material.dart';
import 'package:yama_shopping/constants.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.title,
    required this.image,
    required this.price,
    required this.press,
  }) : super(key: key);

  final String title, image;
  final int price;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 154,
        padding: const EdgeInsets.all(defaultPadding / 2),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.all(Radius.circular(defaultBorderRadius))),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(defaultBorderRadius))),
              // ignore: sort_child_properties_last
              child: Image.network(image),
              height: 130,
            ),
            const SizedBox(height: defaultPadding / 2),
            Row(
              children: [
                Expanded(
                    child: Text(
                  title,
                  maxLines: 2,
                  style: const TextStyle(color: Colors.black),
                )),
                const SizedBox(width: defaultPadding / 4),
                Text(
                  "\$$price",
                  style: Theme.of(context).textTheme.subtitle2,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

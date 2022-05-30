import 'package:flutter/material.dart';
import 'package:yamabi_admin/constants.dart';

class ProductField extends StatelessWidget {
  const ProductField({
    Key? key,
    required this.width,
    required this.title,
    required this.maxLine,
    required this.controller,
  }) : super(key: key);

  final String title;
  final double width;
  final int maxLine;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    var outlineInputBorder = const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(defaultPadding / 4)));
    return Container(
      padding: const EdgeInsets.all(defaultPadding / 2),
      width: width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding / 2, vertical: defaultPadding),
              width: 80,
              child: Center(child: Text(title))),
          const SizedBox(width: defaultPadding),
          Expanded(
              child: TextField(
            controller: controller,
            maxLines: maxLine,
            decoration: InputDecoration(
                filled: true,
                fillColor: whiteColor,
                border: outlineInputBorder),
          ))
        ],
      ),
    );
  }
}

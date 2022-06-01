import 'package:flutter/material.dart';
import 'package:yamabi_admin/constants.dart';

class FieldTemplete extends StatelessWidget {
  FieldTemplete({
    Key? key,
    required this.width,
    required this.title,
    required this.maxLine,
    required this.controller,
    required this.validate,
    required this.errorMsg,
  }) : super(key: key);

  final String title;
  final double width;
  final int maxLine;
  final TextEditingController controller;
  bool validate;
  String errorMsg;

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
                errorText: validate ? errorMsg : null,
                filled: true,
                fillColor: secondaryColor,
                border: outlineInputBorder),
          ))
        ],
      ),
    );
  }
}

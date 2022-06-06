import 'package:flutter/material.dart';
import 'package:yamabi_admin/constants.dart';

class GridField extends StatelessWidget {
  GridField({
    Key? key,
    required this.width,
    required this.maxLine,
    required this.controller,
    required this.validate,
    required this.errorMsg,
    required this.isEdit,
  }) : super(key: key);

  final double width;
  final int maxLine;
  final TextEditingController controller;
  bool validate;
  String errorMsg;
  bool isEdit;

  @override
  Widget build(BuildContext context) {
    var outlineInputBorder = const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(defaultPadding / 4)));
    return SizedBox(
      width: width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: TextField(
            enabled: isEdit,
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

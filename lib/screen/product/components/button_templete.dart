import 'package:flutter/material.dart';
import 'package:yamabi_admin/constants.dart';

class ButtonTemplete extends StatelessWidget {
  const ButtonTemplete({
    Key? key,
    required this.title,
    required this.press,
  }) : super(key: key);

  final String title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: press,
        style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: primaryColor,
            padding: const EdgeInsets.all(defaultPadding + 2)),
        child: Text(title));
  }
}

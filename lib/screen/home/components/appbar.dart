import 'package:flutter/material.dart';
import 'package:yamabi_admin/constants.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    Key? key,
    required this.outlineInputBorder,
  }) : super(key: key);

  final OutlineInputBorder outlineInputBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: defaultPadding * 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text(
            "YAMABI",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 650,
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search manga',
                  prefixIconColor: Colors.red,
                  filled: true,
                  fillColor: whiteColor,
                  border: outlineInputBorder,
                  focusedBorder: outlineInputBorder),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/yama-98f64.appspot.com/o/%E3%82%A2%E3%82%AF%E3%82%B7%E3%83%A7%E3%83%B3%2Fproducts%2F%E3%83%AF%E3%83%B3%E3%83%94%E3%83%BC%E3%82%B9%2Fonepiece_character6.jpg?alt=media&token=ea1c49f7-59e6-48b7-88e1-1c70125efcf0',
                  width: 70,
                  height: 70),
              const SizedBox(width: defaultPadding),
              const Text('Yano'),
              const SizedBox(width: defaultPadding),
              IconButton(
                iconSize: 40,
                icon: const Icon(
                  Icons.output,
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/');
                },
              )
            ],
          )
        ],
      ),
    );
  }
}

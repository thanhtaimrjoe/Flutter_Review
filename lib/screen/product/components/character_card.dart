import 'package:flutter/material.dart';
import 'package:yama_shopping/constants.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({
    Key? key,
    required this.image,
    required this.name,
  }) : super(key: key);

  final String image, name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: defaultPadding / 2, horizontal: defaultPadding / 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            image,
            width: 100,
          ),
          Text(name),
        ],
      ),
    );
  }
}

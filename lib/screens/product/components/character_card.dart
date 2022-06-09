import 'package:flutter/material.dart';
import 'package:yama_shopping/constants.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({
    Key? key,
    required this.index,
    required this.characters,
  }) : super(key: key);

  final List<dynamic> characters;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
      padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
      decoration: BoxDecoration(
          border: Border(
              top: const BorderSide(width: 0),
              bottom: (index == characters.length - 1)
                  ? const BorderSide(width: 0)
                  : BorderSide.none)),
      child: Row(
        children: [
          Image.network(
            characters[index].image,
            width: 80,
            height: 120,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: defaultPadding),
          Text(characters[index].name,
              style: const TextStyle(fontSize: 16, color: Colors.black)),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:yama_shopping/constants.dart';

class EpisodeCard extends StatelessWidget {
  const EpisodeCard({
    Key? key,
    required this.index,
    required this.episodes,
    required this.press,
  }) : super(key: key);
  final int index;
  final List<dynamic> episodes;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
        padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
        decoration: BoxDecoration(
            border: Border(
                top: const BorderSide(width: 0),
                bottom: (index == episodes.length - 1)
                    ? const BorderSide(width: 0)
                    : BorderSide.none)),
        child: Row(
          children: [
            Image.network(
              episodes[index].image,
              width: 100,
              height: 160,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: defaultPadding),
            Expanded(
              child: Text(
                episodes[index].name,
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
            IconButton(
                iconSize: 35,
                onPressed: press,
                icon: const Icon(Icons.add_shopping_cart))
          ],
        ));
  }
}

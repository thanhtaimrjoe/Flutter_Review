import 'package:flutter/material.dart';

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
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(vertical: 8),
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
              width: 80,
            ),
            const SizedBox(width: 16),
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

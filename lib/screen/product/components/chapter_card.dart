import 'package:flutter/material.dart';
import 'package:yamabi_admin/constants.dart';
import 'package:yamabi_admin/modal/episode.dart';
import 'package:yamabi_admin/screen/product/components/product_field.dart';

class EpisodeCard extends StatelessWidget {
  const EpisodeCard({
    Key? key,
    required this.episode,
  }) : super(key: key);

  final Episode episode;

  @override
  Widget build(BuildContext context) {
    TextEditingController characterName =
        TextEditingController(text: episode.name);
    TextEditingController characterPrice =
        TextEditingController(text: '${episode.price}');
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      color: thirdColor,
      child: Row(children: [
        Image.network(episode.image, width: 100),
        const SizedBox(width: defaultPadding * 2),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductField(
                width: 500,
                title: 'Name',
                maxLine: 1,
                controller: characterName),
            ProductField(
                width: 300,
                title: 'Price',
                maxLine: 1,
                controller: characterPrice),
          ],
        ),
      ]),
    );
  }
}

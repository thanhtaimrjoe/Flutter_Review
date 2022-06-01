import 'package:flutter/material.dart';
import 'package:yamabi_admin/constants.dart';
import 'package:yamabi_admin/modal/episode.dart';
import 'package:yamabi_admin/screen/product/components/field_templete.dart';

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
            FieldTemplete(
                width: 500,
                title: 'Name',
                maxLine: 1,
                controller: characterName,
                validate: false,
                errorMsg: ''),
            FieldTemplete(
                width: 300,
                title: 'Price',
                maxLine: 1,
                controller: characterPrice,
                validate: false,
                errorMsg: ''),
          ],
        ),
      ]),
    );
  }
}

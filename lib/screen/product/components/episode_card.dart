import 'package:flutter/material.dart';
import 'package:yamabi_admin/constants.dart';
import 'package:yamabi_admin/modal/episode.dart';
import 'package:yamabi_admin/screen/product/components/button_templete.dart';
import 'package:yamabi_admin/screen/product/components/field_templete.dart';
import 'package:yamabi_admin/services/episode_service.dart';

class EpisodeCard extends StatelessWidget {
  const EpisodeCard({
    Key? key,
    required this.episode,
  }) : super(key: key);

  final Episode episode;

  @override
  Widget build(BuildContext context) {
    EpisodeService episodeService = EpisodeService();
    TextEditingController characterName =
        TextEditingController(text: episode.name);
    TextEditingController characterPrice =
        TextEditingController(text: '${episode.price}');
    return Container(
      margin: const EdgeInsets.all(8),
      color: thirdColor,
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Image.network(episode.image, fit: BoxFit.fitHeight),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FieldTemplete(
                  width: 400,
                  title: 'Name',
                  maxLine: 1,
                  controller: characterName,
                  validate: false,
                  errorMsg: 'Input invalid name'),
              FieldTemplete(
                  width: 300,
                  title: 'Price',
                  maxLine: 1,
                  controller: characterPrice,
                  validate: false,
                  errorMsg: 'Input invalid price'),
            ],
          ),
        ),
        IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                          title: const Text('Warning'),
                          content:
                              const Text('Are you sure you want to delete?'),
                          actions: [
                            ButtonTemplete(
                                title: 'Yes',
                                press: () {
                                  Navigator.pop(context, 'No');
                                  episodeService.deleteEpisode(
                                      episode.episodeID, episode.image);
                                }),
                            ButtonTemplete(
                                title: 'No',
                                press: () {
                                  Navigator.pop(context, 'No');
                                })
                          ]));
            }),
      ]),
    );
  }
}

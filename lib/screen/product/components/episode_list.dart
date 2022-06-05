import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:yamabi_admin/constants.dart';
import 'package:yamabi_admin/modal/episode.dart';
import 'package:yamabi_admin/screen/product/components/episode_card.dart';
import 'package:yamabi_admin/services/episode_service.dart';

class EpisodeList extends StatelessWidget {
  const EpisodeList({
    Key? key,
    required this.productID,
  }) : super(key: key);
  final String productID;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    EpisodeService episodeService = EpisodeService();
    return StreamBuilder<QuerySnapshot>(
        stream: episodeService.fetchRealtimeEpisodes(productID),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: SpinKitCubeGrid(color: primaryColor));
          }
          if (snapshot.data!.docs.isEmpty) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(children: [
                  Image.network(
                    noRecordImg,
                    height: 100,
                  ),
                  const SizedBox(height: defaultPadding),
                  const Text('No record')
                ]),
              ],
            );
          } else {
            return GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: size.height / size.width * 4),
              shrinkWrap: true,
              children: snapshot.data!.docs.map((document) {
                Episode episode = Episode(
                    document['episodeID'],
                    document['name'],
                    document['image'],
                    document['price'],
                    document['productID']);
                return Padding(
                  padding: const EdgeInsets.only(bottom: defaultPadding),
                  child: EpisodeCard(episode: episode),
                );
              }).toList(),
            );
          }
        });
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:yamabi_admin/constants.dart';
import 'package:yamabi_admin/modal/character.dart';
import 'package:yamabi_admin/screen/product/components/character_card.dart';
import 'package:yamabi_admin/services/character_service.dart';

class CharacterList extends StatelessWidget {
  const CharacterList({
    Key? key,
    required this.productID,
  }) : super(key: key);

  final String productID;

  @override
  Widget build(BuildContext context) {
    CharacterService characterService = CharacterService();

    return StreamBuilder<QuerySnapshot>(
      stream: characterService.fetchRealtimeCharacters(productID),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: SpinKitCubeGrid(color: primaryColor));
        }
        return ListView(
          shrinkWrap: true,
          children: snapshot.data!.docs.map((document) {
            Character character =
                Character(document['name'], document['image']);
            return Padding(
              padding: const EdgeInsets.only(top: defaultPadding),
              child: CharacterCard(character: character),
            );
          }).toList(),
        );
      },
    );
  }
}

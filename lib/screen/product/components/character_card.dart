import 'package:flutter/material.dart';
import 'package:yamabi_admin/constants.dart';
import 'package:yamabi_admin/modal/character.dart';
import 'package:yamabi_admin/screen/product/components/button_templete.dart';
import 'package:yamabi_admin/screen/product/components/field_templete.dart';
import 'package:yamabi_admin/services/character_service.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({Key? key, required this.character}) : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) {
    CharacterService characterService = CharacterService();
    TextEditingController characterName =
        TextEditingController(text: character.name);
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      color: thirdColor,
      child: Row(children: [
        Image.network(
          character.image,
          width: 125,
        ),
        const SizedBox(width: defaultPadding * 2),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FieldTemplete(
                  width: 500,
                  title: 'Name',
                  maxLine: 1,
                  controller: characterName,
                  validate: false,
                  errorMsg: 'Input invalid name'),
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
                                  characterService.deleteCharacter(
                                      character.characterID, character.image);
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

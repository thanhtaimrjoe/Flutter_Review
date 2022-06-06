import 'package:flutter/material.dart';
import 'package:yamabi_admin/constants.dart';
import 'package:yamabi_admin/modal/character.dart';
import 'package:yamabi_admin/screen/product/components/button_templete.dart';
import 'package:yamabi_admin/screen/templete/grid_field.dart';
import 'package:yamabi_admin/services/character_service.dart';

class CharacterCard extends StatefulWidget {
  const CharacterCard({Key? key, required this.character}) : super(key: key);

  final Character character;

  @override
  State<CharacterCard> createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard> {
  //late FocusNode myFocusNode;
  bool isEdit = false;

  // @override
  // void initState() {
  //   super.initState();
  //   myFocusNode = FocusNode();
  // }

  @override
  Widget build(BuildContext context) {
    CharacterService characterService = CharacterService();
    TextEditingController characterName =
        TextEditingController(text: widget.character.name);
    return Container(
      margin: const EdgeInsets.all(8),
      color: thirdColor,
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Image.network(widget.character.image,
              width: 150, height: 230, fit: BoxFit.cover),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GridField(
                  width: 210,
                  maxLine: 1,
                  controller: characterName,
                  validate: false,
                  errorMsg: 'Input invalid name',
                  isEdit: isEdit,
                ),
              ],
            ),
          ),
        ),
        if (isEdit == false)
          IconButton(
              onPressed: () {
                if (isEdit == false) {
                  setState(() {
                    isEdit = true;
                  });
                  //myFocusNode.requestFocus();
                }
              },
              icon: const Icon(Icons.edit)),
        if (isEdit == true)
          IconButton(
              onPressed: () async {
                if (isEdit == true) {
                  String result = await characterService.updateCharacter(
                      characterName.text, widget.character.docID);
                  if (result != 'Update successfully') {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                                title: const Text('Fail'),
                                content: Text(result),
                                actions: [
                                  ButtonTemplete(
                                      title: 'OK',
                                      press: () {
                                        Navigator.pop(context, 'OK');
                                      })
                                ]));
                  }
                  setState(() {
                    isEdit = false;
                  });
                }
              },
              icon: const Icon(Icons.done)),
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
                                      widget.character.characterID,
                                      widget.character.image);
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

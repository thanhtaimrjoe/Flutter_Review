import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:yamabi_admin/constants.dart';
import 'package:yamabi_admin/modal/character.dart';
import 'package:yamabi_admin/screen/product/components/field_templete.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({Key? key, required this.character}) : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) {
    TextEditingController characterName =
        TextEditingController(text: character.name);
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      color: thirdColor,
      child: Row(children: [
        Image.network(character.image, width: 100),
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
          ],
        ),
      ]),
    );
  }
}

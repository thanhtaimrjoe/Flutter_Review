import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:yamabi_admin/constants.dart';
import 'package:yamabi_admin/modal/character.dart';
import 'package:yamabi_admin/screen/product/components/button_templete.dart';
import 'package:yamabi_admin/screen/product/components/field_templete.dart';
import 'package:yamabi_admin/services/character_service.dart';

class CharacterDialog extends StatefulWidget {
  const CharacterDialog({
    Key? key,
    required this.productID,
  }) : super(key: key);

  final String productID;

  @override
  State<CharacterDialog> createState() => _CharacterDialogState();
}

class _CharacterDialogState extends State<CharacterDialog> {
  PlatformFile imgFile =
      PlatformFile(name: '', size: 0, bytes: Uint8List.fromList([]));
  bool nameValidate = false;
  @override
  Widget build(BuildContext context) {
    CharacterService characterService = CharacterService();
    TextEditingController nameController = TextEditingController();
    return Dialog(
        elevation: 16,
        child: Container(
          padding: const EdgeInsets.all(defaultPadding),
          width: 730,
          height: 260,
          color: thirdColor,
          child: Row(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (imgFile.bytes!.isEmpty)
                  Container(
                      color: whiteColor,
                      child: Image.network(
                        noAvtarImg,
                        width: 170,
                      )),
                if (imgFile.bytes!.isNotEmpty)
                  Image.memory(Uint8List.fromList(imgFile.bytes!), width: 170),
                ButtonTemplete(
                    title: 'Choose Image',
                    press: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();
                      if (result != null) {
                        setState(() {
                          imgFile = result.files.first;
                        });
                      }
                    })
              ],
            ),
            const SizedBox(width: defaultPadding),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FieldTemplete(
                    width: 500,
                    title: 'Name',
                    maxLine: 1,
                    controller: nameController,
                    validate: nameValidate,
                    errorMsg: 'Input invalid name'),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 6.5,
                      vertical: defaultPadding),
                  child: ButtonTemplete(
                      title: 'Confirm',
                      press: () async {
                        String characterID = const Uuid().v1();
                        String fileName = characterID;
                        bool result = false;
                        if (nameController.text.isEmpty) {
                          setState(() {
                            nameValidate = true;
                          });
                          result = true;
                        }
                        if (imgFile.bytes!.isEmpty) {
                          result = true;
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                      title: const Text('Invalidate'),
                                      content:
                                          const Text('Please choose a image'),
                                      actions: [
                                        ButtonTemplete(
                                            title: 'OK',
                                            press: () {
                                              Navigator.pop(context, 'OK');
                                            })
                                      ]));
                        }
                        if (result == false) {
                          //Upload file
                          final uploadTask = await FirebaseStorage.instance
                              .ref('characters/$fileName')
                              .putData(
                                  imgFile.bytes!,
                                  SettableMetadata(
                                      contentType:
                                          'image/${imgFile.extension}'));
                          switch (uploadTask.state) {
                            case TaskState.success:
                              String imageURL =
                                  await uploadTask.ref.getDownloadURL();
                              Character character = Character(
                                  characterID,
                                  imageURL,
                                  nameController.text,
                                  widget.productID);
                              String result = await characterService
                                  .addNewCharacter(character);
                              if (result == 'Add New Character successfully') {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                            title: const Text('Success'),
                                            content: Text(result),
                                            actions: [
                                              ButtonTemplete(
                                                  title: 'OK',
                                                  press: () {
                                                    Navigator.pop(
                                                        context, 'OK');
                                                  })
                                            ]));
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                            title: const Text('Fail'),
                                            content: Text(result),
                                            actions: [
                                              ButtonTemplete(
                                                  title: 'OK',
                                                  press: () {
                                                    Navigator.pop(
                                                        context, 'OK');
                                                  })
                                            ]));
                              }
                              break;
                            case TaskState.paused:
                              break;
                            case TaskState.running:
                              break;
                            case TaskState.canceled:
                              break;
                            case TaskState.error:
                              break;
                          }
                        }
                      }),
                )
              ],
            ),
          ]),
        ));
  }
}

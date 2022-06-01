import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:uuid/uuid.dart';
import 'package:yamabi_admin/constants.dart';
import 'package:yamabi_admin/modal/episode.dart';
import 'package:yamabi_admin/screen/product/components/product_button.dart';
import 'package:yamabi_admin/screen/product/components/field_templete.dart';

class EpisodeDialog extends StatefulWidget {
  const EpisodeDialog({
    Key? key,
    required this.productID,
  }) : super(key: key);

  final String productID;

  @override
  State<EpisodeDialog> createState() => _EpisodeDialogState();
}

class _EpisodeDialogState extends State<EpisodeDialog> {
  Uint8List fileBytes = Uint8List.fromList([]);
  bool nameValidate = false;
  bool priceValidate = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController episodeName = TextEditingController();
    TextEditingController episodePrice = TextEditingController();
    return Dialog(
        elevation: 16,
        child: Container(
          padding: const EdgeInsets.all(defaultPadding),
          width: size.width / 2.6,
          height: 350,
          color: thirdColor,
          child: Row(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (fileBytes.isEmpty)
                  Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/yama-98f64.appspot.com/o/%E3%82%A2%E3%82%AF%E3%82%B7%E3%83%A7%E3%83%B3%2Fproducts%2F%E3%83%AF%E3%83%B3%E3%83%94%E3%83%BC%E3%82%B9%2Fonepiece001.jpg?alt=media&token=8143c2f9-2130-43e8-8ae7-6905664df4a6',
                      width: 170),
                //if (fileBytes!.isNotEmpty) Text('Hello not empty'),
                if (fileBytes.isNotEmpty)
                  Image.memory(Uint8List.fromList(fileBytes), width: 170),
                ProductButton(
                    title: 'Choose Image',
                    press: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();
                      if (result != null) {
                        setState(() {
                          fileBytes = result.files.first.bytes!;
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
                    controller: episodeName,
                    validate: nameValidate,
                    errorMsg: 'Input invalid name'),
                FieldTemplete(
                    width: 300,
                    title: 'Price',
                    maxLine: 1,
                    controller: episodePrice,
                    validate: priceValidate,
                    errorMsg: 'Input invalid price'),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 6.5,
                      vertical: defaultPadding),
                  child: ProductButton(
                      title: 'Confirm',
                      press: () async {
                        String episodeID = widget.productID + const Uuid().v1();
                        String fileName = episodeID;
                        bool result = false;
                        if (episodeName.text.isEmpty) {
                          setState(() {
                            nameValidate = true;
                          });
                          result = true;
                        }
                        if (episodePrice.text.isEmpty) {
                          setState(() {
                            priceValidate = true;
                          });
                          result = true;
                        }
                        if (result == false) {
                          //Upload file
                          final uploadTask = await FirebaseStorage.instance
                              .ref('episodes/$fileName')
                              .putData(fileBytes);
                          switch (uploadTask.state) {
                            case TaskState.success:
                              String image =
                                  await uploadTask.ref.getDownloadURL();
                              print('URL: $image');
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
                          //Episode episode = Episode(episodeID, episodeName.text, image, price, productID)

                        }
                      }),
                )
              ],
            ),
          ]),
        ));
  }
}

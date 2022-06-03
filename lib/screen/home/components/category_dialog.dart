import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:yamabi_admin/constants.dart';
import 'package:yamabi_admin/modal/category.dart';
import 'package:yamabi_admin/screen/product/components/button_templete.dart';
import 'package:yamabi_admin/screen/product/components/field_templete.dart';
import 'package:yamabi_admin/services/categories_service.dart';

class CategoryDialog extends StatefulWidget {
  const CategoryDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoryDialog> createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<CategoryDialog> {
  PlatformFile imgFile =
      PlatformFile(name: '', size: 0, bytes: Uint8List.fromList([]));
  bool nameValidate = false;
  @override
  Widget build(BuildContext context) {
    CategoryService categoryService = CategoryService();
    TextEditingController nameController = TextEditingController();
    return Dialog(
        elevation: 16,
        child: Container(
            padding: const EdgeInsets.all(defaultPadding),
            width: 730,
            height: 300,
            color: thirdColor,
            child: Row(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (imgFile.bytes!.isEmpty)
                    Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: defaultPadding / 2),
                        color: whiteColor,
                        child: Image.network(noAvtarImg, width: 170)),
                  if (imgFile.bytes!.isNotEmpty)
                    Image.memory(Uint8List.fromList(imgFile.bytes!),
                        width: 170),
                  const SizedBox(height: defaultPadding),
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
                            String categoryID = const Uuid().v1();
                            String fileName = categoryID;
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
                                          content: const Text(
                                              'Please choose a image'),
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
                                  .ref('categories/$fileName')
                                  .putData(
                                      imgFile.bytes!,
                                      SettableMetadata(
                                          contentType:
                                              'image/${imgFile.extension}'));
                              switch (uploadTask.state) {
                                case TaskState.success:
                                  String imageURL =
                                      await uploadTask.ref.getDownloadURL();
                                  Category category = Category(categoryID,
                                      nameController.text, imageURL);
                                  String result = await categoryService
                                      .addNewCategory(category);
                                  if (result ==
                                      'Add new category successfully') {
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
                  ]),
            ])));
  }
}

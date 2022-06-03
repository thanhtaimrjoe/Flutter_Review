import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:yamabi_admin/constants.dart';
import 'package:yamabi_admin/modal/episode.dart';
import 'package:yamabi_admin/modal/product.dart';
import 'package:yamabi_admin/screen/product/components/button_templete.dart';
import 'package:yamabi_admin/screen/product/components/field_templete.dart';
import 'package:yamabi_admin/services/product_service.dart';

class ProductDialog extends StatefulWidget {
  const ProductDialog({
    Key? key,
    required this.categories,
  }) : super(key: key);

  final List<dynamic> categories;

  @override
  State<ProductDialog> createState() => _ProductDialogState();
}

class _ProductDialogState extends State<ProductDialog> {
  PlatformFile imgFile =
      PlatformFile(name: '', size: 0, bytes: Uint8List.fromList([]));
  bool nameValidate = false;
  bool overviewValidate = false;
  String categoryID = 'A1';
  @override
  Widget build(BuildContext context) {
    ProductService productService = ProductService();
    TextEditingController nameController = TextEditingController();
    TextEditingController overviewController = TextEditingController();
    return Dialog(
        elevation: 16,
        child: Container(
          padding: const EdgeInsets.all(defaultPadding),
          width: 730,
          height: 440,
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
                      child: Image.asset('/images/no-image.png', width: 170)),
                if (imgFile.bytes!.isNotEmpty)
                  Image.memory(Uint8List.fromList(imgFile.bytes!), width: 170),
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
                Container(
                  padding: const EdgeInsets.all(defaultPadding / 2),
                  width: 250,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding / 2,
                              vertical: defaultPadding),
                          width: 80,
                          child: const Center(child: Text('Category'))),
                      const SizedBox(width: defaultPadding),
                      Expanded(
                        child: DropdownButton(
                          value: categoryID,
                          elevation: 0,
                          onChanged: (String? newValue) {
                            setState(() {
                              categoryID = newValue!;
                            });
                          },
                          items: widget.categories
                              .map<DropdownMenuItem<String>>((category) {
                            return DropdownMenuItem<String>(
                                value: category['id'],
                                child: Text(category['name']));
                          }).toList(),
                        ),
                      )
                    ],
                  ),
                ),
                FieldTemplete(
                    width: 500,
                    title: 'Name',
                    maxLine: 1,
                    controller: nameController,
                    validate: nameValidate,
                    errorMsg: 'Input invalid name'),
                FieldTemplete(
                    width: 500,
                    title: 'Overview',
                    maxLine: 1,
                    controller: overviewController,
                    validate: overviewValidate,
                    errorMsg: 'Input invalid overview'),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 6.5,
                      vertical: defaultPadding),
                  child: ButtonTemplete(
                      title: 'Confirm',
                      press: () async {
                        String productID = const Uuid().v1();
                        String fileName = productID;
                        bool result = false;
                        if (nameController.text.isEmpty) {
                          setState(() {
                            nameValidate = true;
                          });
                          result = true;
                        }
                        if (overviewController.text.isEmpty) {
                          setState(() {
                            overviewValidate = true;
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
                              .ref('products/$fileName')
                              .putData(
                                  imgFile.bytes!,
                                  SettableMetadata(
                                      contentType:
                                          'image/${imgFile.extension}'));
                          switch (uploadTask.state) {
                            case TaskState.success:
                              String imageURL =
                                  await uploadTask.ref.getDownloadURL();
                              Product product = Product(
                                  categoryID,
                                  nameController.text,
                                  imageURL,
                                  overviewController.text,
                                  productID,
                                  '');
                              String result =
                                  await productService.addNewProduct(product);
                              if (result == 'Add new product successfully') {
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

import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:yamabi_admin/constants.dart';
import 'package:yamabi_admin/modal/product.dart';
import 'package:yamabi_admin/routes/route_names.dart';
import 'package:yamabi_admin/screen/product/components/button_templete.dart';
import 'package:yamabi_admin/screen/product/components/field_templete.dart';
import 'package:yamabi_admin/services/product_service.dart';

class ProductInformation extends StatefulWidget {
  const ProductInformation({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  State<ProductInformation> createState() => _ProductInformationState();
}

class _ProductInformationState extends State<ProductInformation> {
  PlatformFile imgFile =
      PlatformFile(name: '', size: 0, bytes: Uint8List.fromList([]));
  bool nameValidate = false;
  bool overviewValidate = false;
  @override
  Widget build(BuildContext context) {
    ProductService productService = ProductService();
    TextEditingController productIDController =
        TextEditingController(text: widget.product.productID);
    TextEditingController nameController =
        TextEditingController(text: widget.product.name);
    TextEditingController overviewController =
        TextEditingController(text: widget.product.overview);
    return Container(
      color: thirdColor,
      padding: const EdgeInsets.all(defaultPadding / 2),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.all(defaultPadding / 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (imgFile.bytes!.isEmpty)
                  Image.network(widget.product.image, height: 280),
                if (imgFile.bytes!.isNotEmpty)
                  Image.memory(Uint8List.fromList(imgFile.bytes!), height: 280),
                const SizedBox(height: defaultPadding / 2),
                ButtonTemplete(
                    title: 'Choose image',
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
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FieldTemplete(
                    title: 'ProductID',
                    width: double.infinity,
                    maxLine: 1,
                    controller: productIDController,
                    validate: false,
                    errorMsg: ''),
                FieldTemplete(
                    title: 'Name',
                    width: double.infinity,
                    maxLine: 1,
                    controller: nameController,
                    validate: nameValidate,
                    errorMsg: 'Input invalid name'),
                FieldTemplete(
                    title: 'Overview',
                    width: double.infinity,
                    maxLine: 5,
                    controller: overviewController,
                    validate: overviewValidate,
                    errorMsg: 'Input invalid overview'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(defaultPadding / 2),
                      child: ButtonTemplete(
                          title: 'Save',
                          press: () async {
                            String fileName = const Uuid().v1();
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
                            if (result == false) {
                              String imageURL = '';
                              if (imgFile.bytes!.isNotEmpty) {
                                //Upload file
                                final uploadTask = await FirebaseStorage
                                    .instance
                                    .ref('products/$fileName')
                                    .putData(
                                        imgFile.bytes!,
                                        SettableMetadata(
                                            contentType:
                                                'image/${imgFile.extension}'));
                                switch (uploadTask.state) {
                                  case TaskState.success:
                                    imageURL =
                                        await uploadTask.ref.getDownloadURL();
                                    productService
                                        .removeOldImage(widget.product.image);
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
                              Product updatedProduct = Product(
                                  widget.product.categoryID,
                                  nameController.text,
                                  imageURL,
                                  overviewController.text,
                                  widget.product.productID,
                                  widget.product.docID);
                              String result = await productService
                                  .updateProduct(updatedProduct);
                              if (result == 'Update successfully') {
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
                            }
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(defaultPadding / 2),
                      child: ButtonTemplete(
                          title: 'Delete',
                          press: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                        title: const Text('Warning'),
                                        content: const Text(
                                            'Are you sure you want to delete?'),
                                        actions: [
                                          ButtonTemplete(
                                              title: 'Yes',
                                              press: () {
                                                productService.deleteProduct(
                                                    widget.product.productID,
                                                    widget.product.image);
                                                Navigator.pop(context, 'Yes');
                                                Navigator.pop(context, 'Yes');
                                              }),
                                          ButtonTemplete(
                                              title: 'No',
                                              press: () {
                                                Navigator.pop(context, 'No');
                                              })
                                        ]));
                          }),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

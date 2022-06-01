import 'dart:html';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:yamabi_admin/constants.dart';
import 'package:yamabi_admin/modal/product.dart';
import 'package:yamabi_admin/screen/product/components/product_button.dart';
import 'package:yamabi_admin/screen/product/components/product_field.dart';
import 'package:yamabi_admin/services/product_service.dart';

class ProductInformation extends StatelessWidget {
  const ProductInformation({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    ProductService productService = ProductService();
    TextEditingController productID =
        TextEditingController(text: product.productID);
    TextEditingController name = TextEditingController(text: product.name);
    TextEditingController overview =
        TextEditingController(text: product.overview);
    return Container(
      color: thirdColor,
      padding: const EdgeInsets.all(defaultPadding / 2),
      child: Row(
        children: [
          SizedBox(
            width: 300,
            child: Column(
              children: [
                Image.network(product.image, height: 300),
                ProductButton(
                    title: 'Choose image',
                    press: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();
                      if (result != null) {
                        //Single file
                        // File file = File(result.files.single.path);
                        // print('file path: ${result.files.single.path}');
                        //Load result and file details
                        // PlatformFile file = result.files.first;
                        // print(file.name);
                        // print(file.bytes);
                        // print(file.size);
                        // print(file.extension);
                        // print(file.path);

                        //Pick and upload a file to Firebase Storage with Flutter Web
                        Uint8List? fileBytes = result.files.first.bytes;
                        String fileName = result.files.first.name;

                        //Upload file
                        final uploadTask = await FirebaseStorage.instance
                            .ref('flutter_web/$fileName')
                            .putData(fileBytes!);
                        switch (uploadTask.state) {
                          case TaskState.running:
                            final progress = 100.0 *
                                (uploadTask.bytesTransferred /
                                    uploadTask.totalBytes);
                            print("Upload is $progress% complete.");
                            break;
                          case TaskState.success:
                            print('Upload successfully');
                            break;
                          case TaskState.paused:
                            // TODO: Handle this case.
                            break;
                          case TaskState.canceled:
                            // TODO: Handle this case.
                            break;
                          case TaskState.error:
                            // TODO: Handle this case.
                            break;
                        }
                      }
                    })
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductField(
                    title: 'ProductID',
                    width: 400,
                    maxLine: 1,
                    controller: productID),
                ProductField(
                    title: 'Name',
                    width: double.infinity,
                    maxLine: 1,
                    controller: name),
                ProductField(
                    title: 'Overview',
                    width: double.infinity,
                    maxLine: 5,
                    controller: overview),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(defaultPadding / 2),
                      child: ProductButton(
                          title: 'Save',
                          press: () async {
                            Product updatedProduct = Product(
                                'A1',
                                name.text,
                                'none',
                                overview.text,
                                productID.text,
                                product.docID);
                            String result = await productService
                                .updateProduct(updatedProduct);
                            if (result == 'Update successfully') {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: const Text('Success'),
                                        content: Text(result),
                                        actions: [
                                          ElevatedButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, 'OK'),
                                              child: const Text('OK'))
                                        ],
                                      ));
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: const Text('Fail'),
                                        content: Text(result),
                                        actions: [
                                          ElevatedButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, 'OK'),
                                              child: const Text('OK'))
                                        ],
                                      ));
                            }
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(defaultPadding / 2),
                      child: ProductButton(title: 'Cancel', press: () {}),
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

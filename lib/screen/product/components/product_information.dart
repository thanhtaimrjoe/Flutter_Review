import 'package:flutter/material.dart';
import 'package:yamabi_admin/constants.dart';
import 'package:yamabi_admin/modal/product.dart';
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
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 300,
              child: Image.network(product.image, height: 250),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                color: Colors.orange[100],
                padding: const EdgeInsets.all(defaultPadding),
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
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: defaultPadding),
        Container(
          margin: const EdgeInsets.only(left: defaultPadding * 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    Product updatedProduct = Product(
                        'A1', name.text, 'none', overview.text, productID.text);
                    String result =
                        await productService.updateProduct(updatedProduct);
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
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: primaryColor,
                      padding: const EdgeInsets.all(defaultPadding + 2)),
                  child: const Text('Save')),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: primaryColor,
                      padding: const EdgeInsets.all(defaultPadding + 2)),
                  child: const Text('Cancel')),
            ],
          ),
        )
      ],
    );
  }
}

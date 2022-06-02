import 'package:flutter/material.dart';
import 'package:yamabi_admin/constants.dart';
import 'package:yamabi_admin/modal/product.dart';
import 'package:yamabi_admin/screen/home/components/appbar.dart';
import 'package:yamabi_admin/screen/product/components/character_dialog.dart';
import 'package:yamabi_admin/screen/product/components/character_list.dart';
import 'package:yamabi_admin/screen/product/components/episode_dialog.dart';
import 'package:yamabi_admin/screen/product/components/episode_list.dart';
import 'package:yamabi_admin/screen/product/components/button_templete.dart';
import 'package:yamabi_admin/screen/product/components/product_information.dart';

class MyProduct extends StatelessWidget {
  const MyProduct({Key? key, this.arguments}) : super(key: key);

  final arguments;

  @override
  Widget build(BuildContext context) {
    // Product product = Product(
    //     'A1',
    //     'ワンピース',
    //     'https://firebasestorage.googleapis.com/v0/b/yama-98f64.appspot.com/o/%E3%82%A2%E3%82%AF%E3%82%B7%E3%83%A7%E3%83%B3%2Fproducts%2F%E3%83%AF%E3%83%B3%E3%83%94%E3%83%BC%E3%82%B9%2Fonepiece001.jpg?alt=media&token=8143c2f9-2130-43e8-8ae7-6905664df4a6',
    //     'overview',
    //     'A11',
    //     '');
    final product = arguments as Product;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: primaryColor,
            automaticallyImplyLeading: false,
            elevation: 0,
            toolbarHeight: 100.0,
            title: const MyAppBar()),
        body: SingleChildScrollView(
          child: Container(
            width: size.width,
            color: backgroundColor,
            padding:
                const EdgeInsets.symmetric(horizontal: defaultPadding * 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(defaultPadding / 2),
                  child: Text(
                    'Manga information',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                ProductInformation(product: product),
                const SizedBox(height: defaultPadding),
                Padding(
                  padding: const EdgeInsets.all(defaultPadding / 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'List of episode',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      ButtonTemplete(
                          title: 'Create new episode',
                          press: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return EpisodeDialog(
                                      productID: product.productID);
                                });
                          })
                    ],
                  ),
                ),
                EpisodeList(productID: product.productID),
                Padding(
                  padding: const EdgeInsets.all(defaultPadding / 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'List of character',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      ButtonTemplete(
                          title: 'Create new character',
                          press: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return CharacterDialog(
                                      productID: product.productID);
                                });
                          })
                    ],
                  ),
                ),
                CharacterList(productID: product.productID)
              ],
            ),
          ),
        ));
  }
}

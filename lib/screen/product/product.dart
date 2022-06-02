import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:yamabi_admin/constants.dart';
import 'package:yamabi_admin/modal/character.dart';
import 'package:yamabi_admin/modal/product.dart';
import 'package:yamabi_admin/screen/home/components/appbar.dart';
import 'package:yamabi_admin/screen/product/components/character_card.dart';
import 'package:yamabi_admin/screen/product/components/character_dialog.dart';
import 'package:yamabi_admin/screen/product/components/episode_dialog.dart';
import 'package:yamabi_admin/screen/product/components/episode_list.dart';
import 'package:yamabi_admin/screen/product/components/button_templete.dart';
import 'package:yamabi_admin/screen/product/components/product_information.dart';
import 'package:yamabi_admin/services/character_service.dart';

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
    CharacterService characterService = CharacterService();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: primaryColor,
            automaticallyImplyLeading: false,
            elevation: 0,
            toolbarHeight: 130.0,
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
                StreamBuilder<QuerySnapshot>(
                  stream: characterService
                      .fetchRealtimeCharacters(product.productID),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Center(child: Text('Something went wrong'));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: SpinKitCubeGrid(color: primaryColor));
                    }
                    return ListView(
                      shrinkWrap: true,
                      children: snapshot.data!.docs.map((document) {
                        Character character =
                            Character(document['name'], document['image']);
                        return Padding(
                          padding: const EdgeInsets.only(top: defaultPadding),
                          child: CharacterCard(character: character),
                        );
                      }).toList(),
                    );
                  },
                )
              ],
            ),
          ),
        ));
  }
}

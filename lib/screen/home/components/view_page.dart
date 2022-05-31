import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:yamabi_admin/constants.dart';
import 'package:yamabi_admin/screen/home/components/product_card.dart';
import 'package:yamabi_admin/services/product_service.dart';

class MyViewPage extends StatelessWidget {
  const MyViewPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _categoriesStream =
        FirebaseFirestore.instance.collection('category').snapshots();
    Size size = MediaQuery.of(context).size;
    ProductService productService = ProductService();
    return StreamBuilder<QuerySnapshot>(
        stream: _categoriesStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading');
          }
          return SingleChildScrollView(
              child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 14),
                  color: backgroundColor,
                  child: ListView(
                    shrinkWrap: true,
                    children: snapshot.data!.docs.map((document) {
                      return FutureProvider<List<dynamic>>(
                        create: (context) => productService
                            .fetchProductsByCategoryID(document['id']),
                        initialData: const [],
                        child: Container(
                            margin: const EdgeInsets.only(top: defaultPadding),
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.all(defaultPadding / 2),
                                  child: Text(document['name'],
                                      style: const TextStyle(fontSize: 24)),
                                ),
                                Consumer<List<dynamic>>(
                                    builder: (context, products, child) =>
                                        GridView.builder(
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    childAspectRatio:
                                                        size.height /
                                                            size.width *
                                                            1.2,
                                                    crossAxisCount: 5),
                                            shrinkWrap: true,
                                            itemCount: products.length,
                                            itemBuilder: (context, index) =>
                                                ProductCard(
                                                  product: products[index],
                                                  press: () {
                                                    Navigator.pushNamed(
                                                        context, '/product',
                                                        arguments:
                                                            products[index]);
                                                  },
                                                )))
                              ],
                            )),
                      );
                    }).toList(),
                  )));
        });
  }
}

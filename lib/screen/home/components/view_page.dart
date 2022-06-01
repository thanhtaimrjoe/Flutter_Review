import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:yamabi_admin/constants.dart';
import 'package:yamabi_admin/screen/home/components/product_list.dart';
import 'package:yamabi_admin/services/categories_service.dart';
import 'package:yamabi_admin/services/product_service.dart';

class MyViewPage extends StatelessWidget {
  const MyViewPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CategoryService categoryService = CategoryService();
    return StreamBuilder<QuerySnapshot>(
        stream: categoryService.fetchRealtimeCategories(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: SpinKitCubeGrid(color: primaryColor));
          }
          return SingleChildScrollView(
              child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 24),
                  color: backgroundColor,
                  child: ListView(
                    shrinkWrap: true,
                    children: snapshot.data!.docs.map((document) {
                      return Container(
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
                              ProductList(categoryID: document['id']),
                            ],
                          ));
                    }).toList(),
                  )));
        });
  }
}

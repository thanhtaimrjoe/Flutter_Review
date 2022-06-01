import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:yamabi_admin/constants.dart';
import 'package:yamabi_admin/modal/product.dart';
import 'package:yamabi_admin/routes/route_names.dart';
import 'package:yamabi_admin/screen/home/components/product_card.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    Key? key,
    required this.categoryID,
  }) : super(key: key);

  final String categoryID;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Stream<QuerySnapshot> productsStream = FirebaseFirestore.instance
        .collection('product')
        .where('categoryID', isEqualTo: categoryID)
        .snapshots();
    return StreamBuilder(
        stream: productsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: SpinKitCubeGrid(color: primaryColor));
          }
          return GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: size.height / size.width * 1.1,
                crossAxisCount: 5,
              ),
              shrinkWrap: true,
              children: snapshot.data!.docs.map((document) {
                Product product = Product(
                    document['categoryID'],
                    document['name'],
                    document['image'],
                    document['overview'],
                    document['productID'],
                    document.id);
                return ProductCard(
                  product: product,
                  press: () {
                    Navigator.pushNamed(context, RoutesName.PRODUCT_DETAIL,
                        arguments: product);
                  },
                );
              }).toList());
        });
  }
}

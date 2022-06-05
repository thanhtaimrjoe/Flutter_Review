import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:yamabi_admin/constants.dart';
import 'package:yamabi_admin/modal/product.dart';
import 'package:yamabi_admin/routes/route_names.dart';
import 'package:yamabi_admin/screen/home/components/product_card.dart';
import 'package:yamabi_admin/services/product_service.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    Key? key,
    required this.categoryID,
  }) : super(key: key);

  final String categoryID;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ProductService productService = ProductService();
    return StreamBuilder(
        stream: productService.fetchRealtimeProducts(categoryID),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: SpinKitCubeGrid(color: primaryColor));
          }
          if (snapshot.data!.docs.isEmpty) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(children: [
                  Image.network(
                    noRecordImg,
                    height: 100,
                  ),
                  const SizedBox(height: defaultPadding),
                  const Text('No record')
                ]),
              ],
            );
          } else {
            return GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: size.height / size.width * 1.1,
                  crossAxisCount: 6,
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
          }
        });
  }
}

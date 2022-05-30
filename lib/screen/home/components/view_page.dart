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
    Size size = MediaQuery.of(context).size;
    ProductService productService = ProductService();
    return Consumer<List<dynamic>>(
      builder: (context, categories, child) => categories.isNotEmpty
          ? SingleChildScrollView(
              child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 14),
                  color: backgroundColor,
                  child: ListView.builder(
                    itemCount: categories.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>
                        FutureProvider<List<dynamic>>(
                      create: (context) => productService
                          .fetchProductsByCategoryID(categories[index].id),
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
                                child: Text(categories[index].name,
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
                    ),
                  )))
          : const Center(
              child: SpinKitCubeGrid(
                color: primaryColor,
              ),
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yama_shopping/constants.dart';
import 'package:yama_shopping/screen/home/components/product_card.dart';
import 'package:yama_shopping/services/product_service.dart';

class NewArrival extends StatelessWidget {
  const NewArrival({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductService productService = ProductService();
    return FutureProvider<List<dynamic>>(
      create: (context) => productService.fetchNewArrival(),
      initialData: const [],
      child: Consumer<List<dynamic>>(
        builder: (context, products, child) => SizedBox(
          height: 200,
          child: ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: defaultPadding),
                child: ProductCard(
                  title: products[index].name,
                  image: products[index].image,
                  price: products[index].price,
                  press: () {},
                ),
              );
            },
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
          ),
        ),
      ),
    );
  }
}

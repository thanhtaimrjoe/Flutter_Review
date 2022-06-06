import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:yama_shopping/screen/home/components/product_card.dart';
import 'package:yama_shopping/services/product_service.dart';

class MyListProductPage extends StatelessWidget {
  final ProductService productService = ProductService();

  MyListProductPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var argument = ModalRoute.of(context)!.settings.arguments as Map;
    String categoryID = argument['id'];
    String categoryName = argument['name'];
    final Color theme = Theme.of(context).backgroundColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        centerTitle: true,
        backgroundColor: theme,
      ),
      body: FutureProvider<List<dynamic>>(
        create: (context) =>
            productService.findProductsByCategoryID(categoryID),
        initialData: const [],
        child: Consumer<List<dynamic>>(
          builder: (context, products, child) {
            return products.isEmpty
                ? Center(
                    child: SpinKitCubeGrid(
                      color: theme,
                    ),
                  )
                : SingleChildScrollView(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1 / 2,
                      ),
                      padding: const EdgeInsets.all(10.0),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return ProductCard(
                            title: products[index].name,
                            image: products[index].image,
                            press: () {
                              Navigator.pushNamed(context, '/product',
                                  arguments: {
                                    'categoryID': products[index].categoryID,
                                    'name': products[index].name,
                                    'image': products[index].image,
                                    'productID': products[index].productID,
                                    'overview': products[index].overview,
                                  });
                            });
                      },
                    ),
                  );
          },
        ),
      ),
    );
  }
}

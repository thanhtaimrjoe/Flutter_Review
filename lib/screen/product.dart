import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:yama_shopping/constants.dart';
import 'package:yama_shopping/modal/cart.dart';
import 'package:yama_shopping/services/product_service.dart';

class MyProductPage extends StatelessWidget {
  final ProductService productService = ProductService();

  MyProductPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String categoryID = ModalRoute.of(context)!.settings.arguments as String;
    Cart cart = Provider.of<Cart>(context);
    final Color theme = Theme.of(context).backgroundColor;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yama Shoping'),
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
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: size.width / (size.height / 1.5),
                    ),
                    padding: const EdgeInsets.all(10.0),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(defaultPadding),
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 5,
                          )
                        ]),
                        child: Column(children: [
                          Image.network(
                            products[index].image,
                            width: 200,
                            height: 120,
                          ),
                          const SizedBox(height: 26),
                          Expanded(
                            child: Text(
                              products[index].name,
                              maxLines: 2,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          Text(
                            '\$${products[index].price}',
                            style: const TextStyle(
                                color: Colors.red, fontSize: 16),
                          ),
                        ]),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}

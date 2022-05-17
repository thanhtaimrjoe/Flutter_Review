import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:yama_shopping/modal/cart.dart';
import 'package:yama_shopping/modal/product.dart';
import 'package:yama_shopping/services/product_service.dart';

class MyProduct extends StatelessWidget {
  final ProductService productService = ProductService();
  @override
  Widget build(BuildContext context) {
    String categoryID = ModalRoute.of(context)!.settings.arguments as String;
    Cart cart = Provider.of<Cart>(context);
    final Color theme = Theme.of(context).backgroundColor;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yama Shoping'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/cart');
              },
              icon: Icon(Icons.shopping_cart_sharp)),
        ],
        backgroundColor: theme,
      ),
      body: Center(
        child: FutureProvider<Product>(
          create: (context) => productService.fetchProducts(categoryID),
          initialData: Product('', []),
          child: Consumer<Product>(
            builder: (context, products, child) {
              return products.items.isEmpty
                  ? SpinKitCubeGrid(
                      color: theme,
                    )
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1 / 1.2,
                      ),
                      padding: const EdgeInsets.all(8.0),
                      itemCount: products.items.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.all(8.0),
                          decoration:
                              BoxDecoration(color: Colors.white, boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 20,
                            )
                          ]),
                          child: Column(children: [
                            Image.network(
                              products.items[index].image,
                              width: 200,
                              height: 120,
                            ),
                            const SizedBox(height: 15),
                            Text(
                              products.items[index].name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '\$${products.items[index].price}',
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 16),
                                ),
                                IconButton(
                                    onPressed: () {
                                      cart.add(products.items[index]);
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: const Text('Success'),
                                                content: const Text(
                                                    'Add to cart successfully'),
                                                actions: [
                                                  ElevatedButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            context, 'Cancel'),
                                                    child: Text('OK'),
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(theme)),
                                                  )
                                                ],
                                              ));
                                    },
                                    icon: Icon(
                                      Icons.add_box_sharp,
                                      color: theme,
                                      size: 40,
                                    ))
                              ],
                            )
                          ]),
                        );
                      },
                    );
            },
          ),
        ),
      ),
    );
  }
}

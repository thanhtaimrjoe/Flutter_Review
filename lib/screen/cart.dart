import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yama_shopping/modal/cart.dart';

class MyCartPage extends StatelessWidget {
  const MyCartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Cart cart = Provider.of<Cart>(context);
    final Color theme = Theme.of(context).backgroundColor;
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        backgroundColor: theme,
      ),
      body: Column(
        children: [
          Expanded(
              child: cart.items.isEmpty
                  ? EmptyCart(theme: theme)
                  : const MyCartList()),
          const MyTotalPrice()
        ],
      ),
    );
  }
}

class EmptyCart extends StatelessWidget {
  final Color theme;
  // ignore: use_key_in_widget_constructors
  const EmptyCart({required this.theme});
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(
          'https://firebasestorage.googleapis.com/v0/b/yama-98f64.appspot.com/o/empty-cart.png?alt=media&token=93bdf841-30a4-496a-9fb0-1e38184b207d',
          width: 200,
          height: 200,
        ),
        const SizedBox(height: 16),
        Text(
          'Your cart was empty',
          style: TextStyle(fontSize: 18, color: theme),
        ),
      ],
    ));
  }
}

class MyTotalPrice extends StatelessWidget {
  const MyTotalPrice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Cart cart = Provider.of<Cart>(context);
    return Container(
      color: Colors.teal[200],
      width: size.width,
      height: 100,
      child: Center(
        child: Text(
          'Total: \$${cart.getTotal()}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
      ),
    );
  }
}

class MyCartList extends StatelessWidget {
  const MyCartList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Cart cart = Provider.of<Cart>(context);
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: cart.items.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(12.0),
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 20,
            )
          ]),
          child: Row(children: [
            Image.network(
              cart.items[index].product.image,
              width: 100,
              height: 150,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    cart.items[index].product.name,
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('Quantity: ${cart.items[index].quantity}'),
                ],
              ),
            ),
            Text(
                '\$${cart.items[index].product.price * cart.items[index].quantity}'),
            IconButton(
                onPressed: () {
                  cart.delete(cart.items[index].product.id);
                },
                icon: const Icon(Icons.delete_sharp))
          ]),
        );
      },
    );
  }
}

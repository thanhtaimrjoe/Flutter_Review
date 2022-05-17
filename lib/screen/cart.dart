import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yama_shopping/modal/cart.dart';

class MyCart extends StatelessWidget {
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
                  ? const Text('Cart was empty')
                  : MyCartList()),
          MyTotalPrice()
        ],
      ),
    );
  }
}

class MyTotalPrice extends StatelessWidget {
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
              cart.items[index].productItem.image,
              width: 100,
              height: 150,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    cart.items[index].productItem.name,
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('Quantity: ${cart.items[index].quantity}'),
                ],
              ),
            ),
            Text(
                '\$${cart.items[index].productItem.price * cart.items[index].quantity}'),
            IconButton(
                onPressed: () {
                  cart.delete(cart.items[index].productItem.id);
                },
                icon: const Icon(Icons.delete_sharp))
          ]),
        );
      },
    );
  }
}

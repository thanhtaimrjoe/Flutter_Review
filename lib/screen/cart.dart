// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:yama_shopping/modal/cart.dart';

// class MyCart extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     Cart cart = Provider.of<Cart>(context);
//     final Color theme = Theme.of(context).backgroundColor;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Cart'),
//         backgroundColor: theme,
//       ),
//       body: Container(
//           child: Column(
//         children: [
//           Expanded(
//               child: cart.items.isEmpty
//                   ? const Text('Cart was empty')
//                   : MyCartList()),
//           MyTotalPrice()
//         ],
//       )),
//     );
//   }
// }

// class MyTotalPrice extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     Cart cart = Provider.of<Cart>(context);
//     return Container(
//       color: Colors.teal[200],
//       width: size.width,
//       height: 100,
//       child: Center(
//         child: Text(
//           'Total: ',
//           // 'Total: \$${cart.getTotal()}',
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
//         ),
//       ),
//     );
//   }
// }

// class MyCartList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     Cart cart = Provider.of<Cart>(context);
//     return ListView.builder(
//       padding: const EdgeInsets.all(8.0),
//       itemCount: cart.items.length,
//       itemBuilder: (context, index) {
//         return Container(
//           padding: const EdgeInsets.all(8.0),
//           margin: const EdgeInsets.all(8.0),
//           height: 100,
//           color: Colors.teal[100],
//           child:
//               Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//             Image.network(cart.items[index].item.image),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   cart.items[index].item.name,
//                   style: const TextStyle(
//                       fontSize: 18.0, fontWeight: FontWeight.bold),
//                 ),
//                 Text('Quantity: ${cart.items[index].quantity}'),
//               ],
//             ),
//             IconButton(
//                 onPressed: () {
//                   cart.delete(cart.items[index].item.id);
//                 },
//                 icon: const Icon(Icons.delete_sharp))
//           ]),
//         );
//       },
//     );
//   }
// }

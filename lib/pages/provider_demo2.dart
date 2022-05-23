// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class Counter with ChangeNotifier {
//   int _count = 0;

//   int get count => _count;

//   increment() {
//     _count++;
//     notifyListeners();
//   }
// }

// class ProviderDemo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => Counter(),
//       child: MyCenter(),
//     );
//   }
// }

// class MyCenter extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     Counter counter = Provider.of<Counter>(context);
//     return Center(
//         child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//       Text(counter.count.toString(), style: const TextStyle(fontSize: 40)),
//       ElevatedButton(
//         onPressed: () {
//           counter.increment();
//         },
//         child: const Text('Increment', style: TextStyle(fontSize: 20)),
//       )
//     ]));
//   }
// }

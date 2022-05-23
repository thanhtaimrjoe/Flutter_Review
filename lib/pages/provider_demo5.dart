// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class ProviderDemo extends StatelessWidget {
//   const ProviderDemo({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return FutureProvider<int>.value(
//       initialData: 0,
//       value: getAge(),
//       child: DemoWidget(),
//     );
//   }
// }

// Future<int> getAge() {
//   return Future.delayed(
//     Duration(seconds: 5),
//     () {
//       return 5000;
//     },
//   );
// }

// class DemoWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<int>(
//       builder: (context, value, child) {
//         return Center(
//           child: Text(
//             value.toString(),
//             style: TextStyle(fontSize: 28.0),
//           ),
//         );
//       },
//     );
//   }
// }

// import 'dart:math';
// import 'package:flutter/material.dart';

// class SwapTile extends StatefulWidget {
//   const SwapTile({Key? key}) : super(key: key);

//   @override
//   State<SwapTile> createState() => _SwapTileState();
// }

// class _SwapTileState extends State<SwapTile> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.pink,
//       ),
//       home: const MyHomePage(title: 'Flutter Swap Two Tile'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   var listTile = <Widget>[
//     Padding(
//       key: ValueKey(1),
//       padding: const EdgeInsets.all(8.0),
//       child: Tile(),
//     ),
//     Padding(
//       key: ValueKey(2),
//       padding: const EdgeInsets.all(8.0),
//       child: Tile(),
//     )
//   ];

//   void swapTwoTileWidget() {
//     setState(() {
//       listTile.insert(1, listTile.removeAt(0));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//           child: Row(
//         children: listTile,
//       )),
//       floatingActionButton: FloatingActionButton(
//         onPressed: swapTwoTileWidget,
//         child: const Icon(Icons.swap_horiz_outlined),
//       ),
//     );
//   }
// }

// class Tile extends StatefulWidget {
//   @override
//   State<Tile> createState() => _TileState();
// }

// class _TileState extends State<Tile> {
//   final Color color = generateRandomColor();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: color,
//       width: 100,
//       height: 100,
//     );
//   }
// }

// Color generateRandomColor() {
//   final Random random = Random();
//   return Color.fromRGBO(
//       random.nextInt(255), random.nextInt(255), random.nextInt(255), 1);
// }

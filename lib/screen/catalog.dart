import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class MyCatalog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<dynamic> categories = Provider.of<List<dynamic>>(context);
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
          child: categories.isEmpty
              ? SpinKitCubeGrid(
                  color: theme,
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.all(8.0),
                      color: Colors.teal[100],
                      child: Column(children: [
                        Image.network(
                          categories[index].image,
                          width: 100,
                          height: 100,
                        ),
                        Text(categories[index].name),
                      ]),
                    );
                  },
                )),
    );
  }
}

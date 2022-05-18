import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class MyCatalog extends StatefulWidget {
  @override
  State<MyCatalog> createState() => _MyCatalogState();
}

class _MyCatalogState extends State<MyCatalog> {
  int _selectedItem = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedItem = index;
    });
  }

  final List<Widget> _widgetOptions = <Widget>[
    MyHome(),
    MyPersonal(),
  ];

  @override
  Widget build(BuildContext context) {
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
              icon: const Icon(Icons.shopping_cart_sharp)),
        ],
        backgroundColor: theme,
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 36,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Person'),
        ],
        selectedItemColor: theme,
        currentIndex: _selectedItem,
        onTap: _onItemTapped,
      ),
      body: _widgetOptions.elementAt(_selectedItem),
    );
  }
}

class MyPersonal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color theme = Theme.of(context).backgroundColor;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              padding: const EdgeInsets.all(8),
              // ignore: sort_child_properties_last
              child: Icon(
                Icons.person,
                size: 80,
                color: theme,
              ),
              decoration: BoxDecoration(
                  border: Border.all(color: theme, width: 3),
                  borderRadius: BorderRadius.circular(50))),
          const SizedBox(height: 16),
          Text(
            "Welcome user01",
            style: TextStyle(
                color: theme, fontSize: 24, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
            // ignore: sort_child_properties_last
            child: const Text('Log Out'),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(theme),
                elevation: MaterialStateProperty.all(0.0)),
          )
        ],
      ),
    );
  }
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<dynamic> categories = Provider.of<List<dynamic>>(context);
    final Color theme = Theme.of(context).backgroundColor;
    return Center(
        child: categories.isEmpty
            ? SpinKitCubeGrid(
                color: theme,
              )
            : ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/product',
                          arguments: categories[index].id);
                    },
                    child: Container(
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
                          categories[index].image,
                          width: 100,
                          height: 100,
                        ),
                        Text(categories[index].name),
                      ]),
                    ),
                  );
                },
              ));
  }
}

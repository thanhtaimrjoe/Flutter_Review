import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:yama_shopping/services/authentication_service.dart';

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

class Option {
  String name;
  Icon icon;
  Option(this.name, this.icon);
}

class MyPersonal extends StatelessWidget {
  final options = [
    Option('Change language', const Icon(Icons.language)),
    Option('Change location', const Icon(Icons.location_on)),
    Option('About me', const Icon(Icons.person)),
  ];
  @override
  Widget build(BuildContext context) {
    //final firebaseUser = context.watch<User?>();
    final user = FirebaseAuth.instance.currentUser;
    final Color theme = Theme.of(context).backgroundColor;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
              radius: 40, backgroundImage: NetworkImage('${user?.photoURL}')),
          Text(
            "${user?.displayName}",
            style: TextStyle(
                color: theme, fontSize: 24, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
              padding: const EdgeInsets.all(24.0),
              itemCount: options.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(12),
                  color: Colors.grey[300],
                  child: Row(
                    //mainAxisAlignment: Main,
                    children: [
                      options[index].icon,
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          options[index].name,
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AuthenticationService>().signOut();
              Navigator.pushReplacementNamed(context, '/');
            },
            // ignore: sort_child_properties_last
            child: const Text('Sign Out'),
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

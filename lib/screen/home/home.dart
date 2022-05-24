import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:yama_shopping/constants.dart';
import 'package:yama_shopping/screen/cart.dart';
import 'package:yama_shopping/screen/home/components/categories.dart';
import 'package:yama_shopping/screen/home/components/new_arrival.dart';
import 'package:yama_shopping/screen/home/components/popular.dart';
import 'package:yama_shopping/screen/home/components/search_form.dart';
import 'package:yama_shopping/screen/home/components/section_title.dart';
import 'package:yama_shopping/services/authentication_service.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int _selectedItem = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedItem = index;
    });
  }

  final List<Widget> _widgetOptions = <Widget>[
    const MyHomePage(),
    const MyCartPage(),
    MyPersonalPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final Color theme = Theme.of(context).backgroundColor;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {}, icon: SvgPicture.asset("assets/icons/menu.svg")),
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          SvgPicture.asset("assets/icons/Location.svg"),
          const SizedBox(width: defaultPadding / 2),
          Text(
            "829 Dong Bac, Tan Hoa",
            style: Theme.of(context).textTheme.subtitle2,
          )
        ]),
        actions: [
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset("assets/icons/Notification.svg"))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 36,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
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

class MyPersonalPage extends StatelessWidget {
  final options = [
    Option('Change language', const Icon(Icons.language)),
    Option('Change location', const Icon(Icons.location_on)),
    Option('About me', const Icon(Icons.person)),
  ];

  MyPersonalPage({Key? key}) : super(key: key);
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

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> categories = Provider.of<List<dynamic>>(context);
    final Color theme = Theme.of(context).backgroundColor;
    return categories.isEmpty
        ? Center(
            child: SpinKitCubeGrid(
              color: theme,
            ),
          )
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Explore",
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontWeight: FontWeight.w500, color: Colors.black),
                  ),
                  const Text(
                    "best manga for you",
                    style: TextStyle(fontSize: 18),
                  ),
                  const SearchForm(),
                  Categories(categories: categories),
                  SectionTitle(
                    title: "New Arrival",
                    pressSeeAll: () {},
                  ),
                  const NewArrival(),
                  const SizedBox(height: defaultPadding),
                  SectionTitle(
                    title: "Popular",
                    pressSeeAll: () {},
                  ),
                  const Popular(),
                ],
              ),
            ),
          );
  }
}

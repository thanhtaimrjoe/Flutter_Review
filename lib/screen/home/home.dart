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
import 'package:yama_shopping/screen/personal/personal.dart';

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

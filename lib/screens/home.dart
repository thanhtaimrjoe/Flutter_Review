import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:yama_shopping/constants.dart';
import 'package:yama_shopping/screens/cart.dart';
import 'package:yama_shopping/widgets/home/categories.dart';
import 'package:yama_shopping/widgets/home/new_arrival.dart';
import 'package:yama_shopping/widgets/home/popular.dart';
import 'package:yama_shopping/widgets/home/search_form.dart';
import 'package:yama_shopping/widgets/home/section_title.dart';
import 'package:yama_shopping/screens/personal.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        //   leading: IconButton(
        //       onPressed: () {}, icon: SvgPicture.asset("assets/icons/menu.svg")),
        //   title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        //     SvgPicture.asset("assets/icons/Location.svg"),
        //     const SizedBox(width: defaultPadding / 2),
        //     Text(
        //       "829 Dong Bac, Tan Hoa",
        //       style: Theme.of(context).textTheme.subtitle2,
        //     )
        //   ]),
        //   actions: [
        //     IconButton(
        //         onPressed: () {},
        //         icon: SvgPicture.asset("assets/icons/Notification.svg"))
        //   ],
        // ),
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 36,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: AppLocalizations.of(context)!.bottomBarHome),
            BottomNavigationBarItem(
                icon: const Icon(Icons.shopping_cart),
                label: AppLocalizations.of(context)!.bottomBarCart),
            BottomNavigationBarItem(
                icon: const Icon(Icons.person),
                label: AppLocalizations.of(context)!.bottomBarPersonal),
          ],
          selectedItemColor: theme,
          currentIndex: _selectedItem,
          onTap: _onItemTapped,
        ),
        body: _widgetOptions.elementAt(_selectedItem),
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
                    AppLocalizations.of(context)!.hello,
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontWeight: FontWeight.w500, color: Colors.black),
                  ),
                  Text(
                    AppLocalizations.of(context)!.helloTitle,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SearchForm(),
                  Categories(categories: categories),
                  SectionTitle(
                    title: "New Arrival",
                    pressSeeAll: () {},
                  ),
                  const NewArrival(),
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

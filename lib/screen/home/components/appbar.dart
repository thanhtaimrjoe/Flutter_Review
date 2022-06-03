import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yamabi_admin/constants.dart';
import 'package:yamabi_admin/modal/user.dart';
import 'package:yamabi_admin/routes/route_names.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);
    var outlineInputBorder = const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(defaultPadding / 4)));
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: defaultPadding * 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, RoutesName.HOME_PAGE),
            child: const Text(
              "YAMABI",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: 650,
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search manga',
                  prefixIconColor: Colors.red,
                  filled: true,
                  fillColor: whiteColor,
                  border: outlineInputBorder,
                  focusedBorder: outlineInputBorder),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  user.avatar,
                ),
              ),
              const SizedBox(width: defaultPadding),
              Text(user.fullname),
              const SizedBox(width: defaultPadding),
              IconButton(
                iconSize: 40,
                icon: const Icon(
                  Icons.output,
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/');
                },
              )
            ],
          )
        ],
      ),
    );
  }
}

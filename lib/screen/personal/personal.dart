import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
              //context.read<AuthenticationService>().signOut();
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

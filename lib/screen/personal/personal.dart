import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yama_shopping/services/authentication_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyPersonalPage extends StatelessWidget {
  final options = [
    Option(
        'Change information', const Icon(Icons.person), '/changeInformation'),
    Option('Change language', const Icon(Icons.language), '/changeLanguage'),
    Option('About me', const Icon(Icons.person), '/aboutMe'),
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
                return GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    color: Colors.grey[300],
                    child: Row(
                      children: [
                        options[index].icon,
                        const SizedBox(width: 8),
                        if (options[index].name == 'Change information')
                          Expanded(
                            child: Text(AppLocalizations.of(context)!
                                .changeInformation),
                          ),
                        if (options[index].name == 'Change language')
                          Expanded(
                            child: Text(
                                AppLocalizations.of(context)!.changeLanguage),
                          ),
                        if (options[index].name == 'About me')
                          Expanded(
                            child: Text(AppLocalizations.of(context)!.aboutMe),
                          ),
                        const Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                  onTap: () {},
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Provider.of<AuthenticationService>(context, listen: false)
                  .signOut();
              context.read<AuthenticationService>().signOut();
              Navigator.pushReplacementNamed(context, '/');
            },
            // ignore: sort_child_properties_last
            child: Text(AppLocalizations.of(context)!.signOut),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(theme),
                elevation: MaterialStateProperty.all(0.0)),
          )
        ],
      ),
    );
  }
}

class Option {
  String name;
  Icon icon;
  String route;
  Option(this.name, this.icon, this.route);
}

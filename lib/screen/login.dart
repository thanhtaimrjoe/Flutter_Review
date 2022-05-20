import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:yama_shopping/services/authentication_service.dart';

class MyLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> fbApp = Firebase.initializeApp();
    final Color theme = Theme.of(context).backgroundColor;
    return FutureBuilder(
        future: fbApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('You have an error! ${snapshot.error.toString()}');
            // ignore: prefer_const_constructors
            return Scaffold(body: Center(child: Text('Something went wrong')));
          } else if (snapshot.hasData) {
            return Scaffold(
              body: Container(
                color: theme,
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/shopping-bag.png',
                      width: 150,
                      height: 150,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'YAMA SHOPPING',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.black,
                            minimumSize: Size(double.infinity, 50)),
                        label: const Text("Sign In with Google",
                            style: TextStyle(fontSize: 18)),
                        onPressed: () async {
                          String result = await context
                              .read<AuthenticationService>()
                              .signInWithGoogle();
                          if (result == 'Signed In') {
                            // ignore: use_build_context_synchronously
                            Navigator.pushReplacementNamed(context, '/catalog');
                          }
                        },
                        icon: const Icon(FontAwesomeIcons.google)),
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(
              body: SpinKitCubeGrid(
                color: Colors.teal[400],
              ),
            );
          }
        });
  }
}

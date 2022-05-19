import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:yama_shopping/services/authentication_service.dart';

class MyLogin extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
    final Color theme = Theme.of(context).backgroundColor;
    return FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('You have an error! ${snapshot.error.toString()}');
            // ignore: prefer_const_constructors
            return Scaffold(body: Center(child: Text('Something went wrong')));
          } else if (snapshot.hasData) {
            return Scaffold(
              body: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/shopping-bag.png',
                      width: 150,
                      height: 150,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'YAMA SHOPPING',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: theme),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Email'),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Password'),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        String result = await context
                            .read<AuthenticationService>()
                            .signIn(
                                emailController.text, passwordController.text);
                        if (result == 'Signed In') {
                          Navigator.pushReplacementNamed(context, '/catalog');
                        } else if (result == 'wrong-password') {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text('Alert'),
                                    content: const Text(
                                        'Email or password was wrong, please try again'),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'OK'),
                                        child: Text('OK'),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    theme)),
                                      )
                                    ],
                                  ));
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text('Alert'),
                                    content: Text(
                                        'Some thing wrong, please try again.\n$result'),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'OK'),
                                        child: Text('OK'),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    theme)),
                                      )
                                    ],
                                  ));
                        }
                      },
                      child: Text('Login'),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(theme)),
                    )
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

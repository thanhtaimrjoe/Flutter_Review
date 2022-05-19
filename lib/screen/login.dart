import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyLogin extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                      try {
                        final credential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text);
                        if (credential.user != null) {
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacementNamed(context, '/catalog');
                        }
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
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
                        } else if (e.code == 'wrong-password') {
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
                        }
                      } catch (e) {
                        print(e.toString());
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
      },
    );
  }
}

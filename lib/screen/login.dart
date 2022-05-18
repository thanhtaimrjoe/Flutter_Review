import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yama_shopping/modal/user.dart';

class MyLogin extends StatelessWidget {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Color theme = Theme.of(context).backgroundColor;
    User user = Provider.of<User>(context);
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
                  fontSize: 24, fontWeight: FontWeight.bold, color: theme),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Username'),
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
              onPressed: () {
                var result = true;
                if (usernameController.text != user.username) {
                  result = false;
                }
                if (passwordController.text != user.password) {
                  result = false;
                }
                if (result) {
                  //test firebase database
                  DatabaseReference _testRef =
                      FirebaseDatabase.instance.ref().child("test");
                  _testRef
                      .set("Hello firebase database ${Random().nextInt(100)}");

                  Navigator.pushReplacementNamed(context, '/catalog');
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: const Text('Warning'),
                            content: const Text(
                                'Your username or password was wrong. Please try again'),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context, 'OK');
                                },
                                child: Text('OK'),
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(theme)),
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
  }
}

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('YAMA SHOPPING'),
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

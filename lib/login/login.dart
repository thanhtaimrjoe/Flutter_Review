import 'package:flutter/material.dart';
import 'package:yamabi_admin/constants.dart';

class MyLoginPage extends StatelessWidget {
  const MyLoginPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    TextEditingController username = TextEditingController();
    TextEditingController password = TextEditingController();
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover)),
        child: Center(
            child: Container(
                width: 500,
                height: 300,
                padding: const EdgeInsets.all(defaultPadding * 2),
                color: Colors.white,
                child: Column(
                  children: [
                    const Text('YAMABI',
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: 32,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: defaultPadding),
                    TextField(
                      controller: username,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Username'),
                    ),
                    const SizedBox(height: defaultPadding),
                    TextField(
                      obscureText: true,
                      controller: password,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Password'),
                    ),
                    const SizedBox(height: defaultPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: primaryColor,
                                padding: const EdgeInsets.all(defaultPadding)),
                            onPressed: () {
                              print('username: ${username.text}');
                              print('password: ${password.text}');
                            },
                            child: const Text('Sign In')),
                        const SizedBox(width: defaultPadding),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: primaryColor,
                                padding: const EdgeInsets.all(defaultPadding)),
                            onPressed: () {
                              username.clear();
                              password.clear();
                            },
                            child: const Text('Reset'))
                      ],
                    )
                  ],
                ))),
      ),
    );
  }
}

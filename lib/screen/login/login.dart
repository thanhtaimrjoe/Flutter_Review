import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:yamabi_admin/constants.dart';
import 'package:yamabi_admin/modal/user.dart';
import 'package:yamabi_admin/routes/route_names.dart';
import 'package:yamabi_admin/services/user_service.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  bool isError = false;
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> fbApp = Firebase.initializeApp();
    final size = MediaQuery.of(context).size;
    TextEditingController username = TextEditingController();
    TextEditingController password = TextEditingController();
    UserService userService = UserService();
    return Scaffold(
      body: FutureBuilder(
        future: fbApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Firebase error'));
          } else if (snapshot.hasData) {
            return Container(
              width: size.width,
              height: size.height,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(backgroundImg), fit: BoxFit.cover)),
              child: Center(
                  child: Container(
                      width: 500,
                      height: 320,
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
                                border: OutlineInputBorder(),
                                labelText: 'Username'),
                          ),
                          const SizedBox(height: defaultPadding),
                          TextField(
                            obscureText: true,
                            controller: password,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Password'),
                          ),
                          const SizedBox(height: defaultPadding),
                          isError
                              ? const Text(
                                  "Username or password wrong. Please try again",
                                  style: TextStyle(color: Colors.red),
                                )
                              : const Text(''),
                          const SizedBox(height: defaultPadding),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      primary: primaryColor,
                                      padding:
                                          const EdgeInsets.all(defaultPadding)),
                                  onPressed: () async {
                                    User result =
                                        await userService.checkUserExist(
                                            username.text, password.text);
                                    if (result.username == username.text) {
                                      // ignore: use_build_context_synchronously
                                      final user = Provider.of<User>(context,
                                          listen: false);
                                      user.addUser(result);
                                      // ignore: use_build_context_synchronously
                                      Navigator.pushReplacementNamed(
                                          context, RoutesName.HOME_PAGE);
                                    } else {
                                      setState(() {
                                        isError = true;
                                      });
                                    }
                                  },
                                  child: const Text('Sign In')),
                              const SizedBox(width: defaultPadding),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      primary: primaryColor,
                                      padding:
                                          const EdgeInsets.all(defaultPadding)),
                                  onPressed: () {
                                    username.clear();
                                    password.clear();
                                  },
                                  child: const Text('Reset'))
                            ],
                          )
                        ],
                      ))),
            );
          } else {
            return const Center(child: SpinKitCubeGrid(color: primaryColor));
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderDemo extends StatelessWidget {
  String club = 'Real Madric';

  @override
  Widget build(BuildContext context) {
    return Provider<String>.value(
      value: club,
      child: MyCenter(),
    );
  }
}

class MyCenter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          MyEnglishText(),
          MyJapaneseText(),
        ],
      ),
    );
  }
}

class MyJapaneseText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String club = Provider.of<String>(context);
    return Text('ようこそ$clubクラブへ');
  }
}

class MyEnglishText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<String>(
        builder: (context, value, child) => Text('Welcome to $value club'));
  }
}

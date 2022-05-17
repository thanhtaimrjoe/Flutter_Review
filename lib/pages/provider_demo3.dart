import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//-------------------DEMO 1---------------------

class Counter1 with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  increment() {
    _count++;
    notifyListeners();
  }
}

class Counter2 with ChangeNotifier {
  int _count = 10;

  int get count => _count;

  increment() {
    _count += 10;
    notifyListeners();
  }
}

class ProviderDemo1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Counter1(),
        ),
        ChangeNotifierProvider(
          create: (context) => Counter2(),
        ),
      ],
      child: MyCenter1(),
    );
  }
}

class MyCenter1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Counter1 counter1 = Provider.of<Counter1>(context);
    Counter2 counter2 = Provider.of<Counter2>(context);
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text('Counter1: ${counter1._count.toString()}',
          style: const TextStyle(fontSize: 40)),
      Text('Counter2: ${counter2._count.toString()}',
          style: const TextStyle(fontSize: 40)),
      ElevatedButton(
        onPressed: () {
          counter1.increment();
          counter2.increment();
        },
        child: const Text('Increment', style: TextStyle(fontSize: 20)),
      )
    ]));
  }
}

//-------------------DEMO 2 (Not working)---------------------

class Counter3 {
  int _count = 0;

  increment() {
    _count++;
  }
}

class Counter4 {
  int _count = 0;

  increment() {
    _count += 10;
  }
}

class ProviderDemo2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Counter3>.value(value: Counter3()),
        Provider<Counter4>.value(value: Counter4()),
      ],
      child: MyCenter2(),
    );
  }
}

class MyCenter2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Counter3 counter3 = Provider.of<Counter3>(context);
    Counter4 counter4 = Provider.of<Counter4>(context);
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text('Counter3: ${counter3._count.toString()}',
          style: const TextStyle(fontSize: 40)),
      Text('Counter4: ${counter4._count.toString()}',
          style: const TextStyle(fontSize: 40)),
      ElevatedButton(
        onPressed: () {
          counter3.increment();
          counter4.increment();
        },
        child: const Text('Increment', style: TextStyle(fontSize: 20)),
      )
    ]));
  }
}

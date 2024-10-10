import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CupertinoApp(
    title: 'TO-DO LIST',
    home: FirstScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(

      navigationBar: const CupertinoNavigationBar(
        middle: Text('TO DO LIST'),
      ),

      child: Center(
        child: CupertinoButton(
          child: const Text('Go to Setting'),
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => const SecondScreen()),
            );
          },
        ),
      ),
    );
  }
}

@override
Widget build2(BuildContext context) {
  const String appTitle = 'TO DO List';
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: appTitle,
    home: Scaffold(
      appBar: AppBar(
        title: const Text(appTitle),
      ),
      body: const Center(
        child: Text('Hello World'),


      ),
    ),
  );
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('SETTINGS'),
      ),
      child: Center(
        child: CupertinoButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go to To-do List'),
        ),
      ),
    );
  }
}
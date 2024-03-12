import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const Maintodo(),
    );
  }
}

class Maintodo extends StatefulWidget {
  const Maintodo({super.key});

  @override
  State<Maintodo> createState() => _MaintodoState();
}

class _MaintodoState extends State<Maintodo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "TODO List",
        ),
        backgroundColor: Colors.purple,
      ),
      body: const Center(
        child: Text(
          "안녕하세요",
          style: TextStyle(
            fontSize: 50,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:magic_gathering/modules/home/Home.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF43B9B8),
      ),
      home: Home(),
    );
  }
}

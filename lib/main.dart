import 'package:flutter/material.dart';
import 'package:mobile_adressbook/screens/loading_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adressbok',
      theme: ThemeData.dark(),
      home: LoadingScreen(),
    );
  }
}

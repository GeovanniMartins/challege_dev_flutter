import 'package:challege_dev_flutter/pages/home_Page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:frontend/screens/writer/writer_screen.dart';
import 'package:frontend/themes.dart';




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Name',
      theme: LightTheme.themeData,
      darkTheme: DarkTheme.themeData,
      home: BookDetailScreen(),
    );
  }
}
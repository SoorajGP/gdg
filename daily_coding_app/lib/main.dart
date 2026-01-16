import 'package:flutter/material.dart';
import 'screens/home_shell.dart';

void main() {
  runApp(const DailyCodingApp());
}

class DailyCodingApp extends StatelessWidget {
  const DailyCodingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeShell(),
    );
  }
}

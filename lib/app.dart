import 'package:flutter/material.dart';
import 'package:test_zadanie/page.dart';
import 'package:test_zadanie/presentation/characters/screen/characters_page.dart';
import 'package:test_zadanie/presentation/main/main_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainScreen(),
    );
  }
}

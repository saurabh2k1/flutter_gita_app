import 'package:flutter/material.dart';

class RandomVerse extends StatelessWidget {
  const RandomVerse({super.key});

  String getRandomVerse() {
    return "random";
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      getRandomVerse(),
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    );
  }
}

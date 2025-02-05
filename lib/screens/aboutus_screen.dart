import 'package:flutter/material.dart';

class AboutusScreen extends StatelessWidget {
  const AboutusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('About us',style: TextStyle(fontSize: 24),),
      ),
    );
  }
}

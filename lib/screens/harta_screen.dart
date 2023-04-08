// create a simple screen wiht only shqiperia.svg
//image in center which redirests to /bashkia route
// when clicked

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HartaScreen extends StatelessWidget {
  const HartaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Harta'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () => context.go('/bashkite'),
          child: const Padding(
            padding: EdgeInsets.only(left: 10, right: 6, top: 3, bottom: 3),
            child: Image(
              image: AssetImage(
                'assets/images/shqiperia.png',
              ),
            ),
          ),
        ),
      ),
    );
  }
}

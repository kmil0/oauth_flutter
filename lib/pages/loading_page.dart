import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.green, Colors.green.withOpacity(0.45)]),
        ),
        child: const Icon(
          Icons.cake,
          color: Colors.white,
          size: 150,
        ),
      )),
    );
  }
}

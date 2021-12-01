import 'package:flutter/material.dart';

class BarGradient extends StatelessWidget {
  final String? name;
  final IconData? icon;

  const BarGradient({Key? key, this.icon, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30.0),
      height: 220,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.topLeft,
              colors: [Colors.green, Colors.green.withOpacity(0.45)]),
          borderRadius:
              const BorderRadius.only(bottomLeft: Radius.circular(90))),
      child: Column(
        children: [
          const Spacer(),
          Align(
            alignment: Alignment.center,
            child: Icon(
              icon,
              size: 90,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32, right: 32),
              child: Text(
                name!,
                style: const TextStyle(
                    color: Colors.white, fontSize: 25, letterSpacing: 10),
              ),
            ),
          )
        ],
      ),
    );
  }
}

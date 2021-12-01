import 'package:flutter/material.dart';

class ButtonBase extends StatelessWidget {
  final String name;
  final VoidCallback onTap;
  final double width;
  const ButtonBase(this.name, this.onTap, {Key? key, this.width = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          onTap: onTap,
          child: Container(
              height: 45,
              padding: const EdgeInsets.all(10),
              width: width > 0 ? width : null,
              decoration: BoxDecoration(
                  color: Colors.green[400],
                  borderRadius: const BorderRadius.all(Radius.circular(50))),
              child: Center(
                  child: Text(
                name.toUpperCase(),
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              )))),
    );
  }
}

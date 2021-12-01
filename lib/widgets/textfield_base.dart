import 'package:flutter/material.dart';

class TextFieldBase extends StatelessWidget {
  final String name;
  final IconData? icon;
  final bool obscureText;
  final TextEditingController controller;
  const TextFieldBase(
    this.name,
    this.controller, {
    this.obscureText = false,
    this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      height: 45,
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            icon: icon != null ? Icon(icon, color: Colors.green) : null,
            hintText: name,
            border: InputBorder.none),
      ),
    );
  }
}

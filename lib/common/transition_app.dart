import 'package:flutter/material.dart';
import 'package:oauth_app/main.dart';
import 'package:oauth_app/model/count.dart';
import 'package:oauth_app/model/user.dart';

class TransitionApp {
  static closePageOrDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  static openPage(BuildContext context, var page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  static goMain(BuildContext context, {Count? count, User? user}) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => MyApp(
                  count: count,
                  user: user,
                )),
        ModalRoute.withName("/MyApp"));
  }
}

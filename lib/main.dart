import 'package:flutter/material.dart';
import 'package:oauth_app/model/count.dart';
import 'package:oauth_app/model/user.dart';
import 'package:oauth_app/pages/home_page.dart';
import 'package:oauth_app/pages/loading_page.dart';
import 'package:oauth_app/pages/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  User? user;
  Count? count;
  MyApp({this.count, this.user});
  @override
  State<StatefulWidget> createState() => MyAppState(this.count, this.user);
}

class MyAppState extends State<MyApp> {
  User? user;
  Count? count;
  bool isLoading = false;
  MyAppState(this.count, this.user);

  @override
  void initState() {
    if (count == null && user == null) {
      getUserAndCount();
    }
    super.initState();
  }

  getUserAndCount() async {
    setState(() => isLoading = true);

    Count? count = await Count().getCount();
    User? user = await User().getUser();

    if (mounted) {
      if (count != null && user != null) {
        setState(() {
          this.user = user;
          this.count = count;
          this.isLoading = false;
        });
      } else {
        setState(() => this.isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: getPage());
  }

  Widget getPage() {
    return (isLoading)
        ? const LoadingPage()
        : (count != null && user != null)
            ? HomePage(count, user)
            : LoginPage();
  }
}

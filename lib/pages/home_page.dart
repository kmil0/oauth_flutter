import 'package:flutter/material.dart';
import 'package:oauth_app/common/transition_app.dart';
import 'package:oauth_app/common/validate.dart';
import 'package:oauth_app/model/count.dart';
import 'package:oauth_app/model/user.dart';

class HomePage extends StatefulWidget {
  User? user;
  Count? count;
  HomePage(this.count, this.user);

  @override
  State<StatefulWidget> createState() => HomePageState(this.count, this.user);
}

class HomePageState extends State<HomePage> {
  User? user;
  Count? count;
  HomePageState(this.count, this.user);

  @override
  void initState() {
    User().getUserServer();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Cake Shop"),
        actions: [
          IconButton(
              onPressed: () => closeSession(context),
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ))
        ],
        centerTitle: true,
        backgroundColor: Colors.green[400],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(user!.name),
              accountEmail: Text(user!.email),
              decoration: BoxDecoration(color: Colors.green[400]),
            )
          ],
        ),
      ),
      body: Center(
        child: Text("Bienvenid@"),
      ),
    );
  }

  closeSession(context) async {
    if (await Validate.deleteUserAndCount(this.count, this.user)) {
      TransitionApp.goMain(context);
    }
  }
}

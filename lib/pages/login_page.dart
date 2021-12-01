import 'package:flutter/material.dart';
import 'package:oauth_app/common/transition_app.dart';
import 'package:oauth_app/common/validate.dart';
import 'package:oauth_app/http/status.dart';
import 'package:oauth_app/model/count.dart';
import 'package:oauth_app/model/user.dart';
import 'package:oauth_app/pages/home_page.dart';
import 'package:oauth_app/pages/signup_page.dart';
import 'package:oauth_app/widgets/bar_gradient.dart';
import 'package:oauth_app/widgets/button_base.dart';
import 'package:oauth_app/widgets/progress_dialog.dart';
import 'package:oauth_app/widgets/reset_password_dialog.dart';
import 'package:oauth_app/widgets/snackbar_app.dart';
import 'package:oauth_app/widgets/text_message.dart';
import 'package:oauth_app/widgets/textfield_base.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController ctrlEmail = TextEditingController();
  final TextEditingController ctrlPass = TextEditingController();
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const BarGradient(
              name: "Cake Shop",
              icon: Icons.store,
            ),
            TextFieldBase(
              "Usuario",
              ctrlEmail,
              icon: Icons.person,
            ),
            TextFieldBase(
              "Password",
              ctrlPass,
              icon: Icons.remove_red_eye,
              obscureText: true,
            ),
            InkWell(
              onTap: () => resetPassword(context),
              child: const Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 32.0, top: 16),
                  child: Text(
                    "Se te olvido la contraseña?",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ),
            ButtonBase("Iniciar Sesion", () => login(context)),
            InkWell(
              onTap: () => signUp(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("¿No tienes una cuenta?"),
                  Text(" Crear cuenta",
                      style: TextStyle(color: Colors.green[400]))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  login(BuildContext context) async {
    showProgress(context);
    var count = await Count().login("test@gmail.com", "nmJvS7Fq6b6kvff");
    if (Validate.isNotStatus(count)) {
      var user = await User().getUserServer();
      if (Validate.isNotStatus(user)) {
        TransitionApp.closePageOrDialog(context);
        TransitionApp.goMain(context, count: count, user: user);
      } else {
        error(context, user);
      }
    } else {
      error(context, count);
    }
    User().getUser();

    // TransitionApp.openPage(context, HomePage());
    // showProgress(context);
  }

  error(BuildContext context, Status status) {
    TransitionApp.closePageOrDialog(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBarApp(
        Validate.isWrongEmailPassword(status.response)
            ? const TextMessage(
                text: "Usuario o contraseña incorrecta. Intente de nuevo")
            : status.statusWidget));
  }

  Future<void> showProgress(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return const ProgressDialog();
        });
  }

  signUp(BuildContext context) {
    TransitionApp.openPage(context, SignUpPage());
  }

  Future<void> resetPassword(BuildContext context) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return ResetPasswordDialog(ctrlEmail: ctrlEmail);
        });
  }
}

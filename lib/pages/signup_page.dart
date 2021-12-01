import 'package:flutter/material.dart';
import 'package:oauth_app/common/transition_app.dart';
import 'package:oauth_app/widgets/bar_gradient.dart';
import 'package:oauth_app/widgets/button_base.dart';
import 'package:oauth_app/widgets/textfield_base.dart';

class SignUpPage extends StatelessWidget {
  TextEditingController ctrlName = TextEditingController();
  TextEditingController ctrlUser = TextEditingController();
  TextEditingController ctrlEmail = TextEditingController();
  TextEditingController ctrlPassword = TextEditingController();
  SignUpPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const BarGradient(
                name: "Crear Usuario",
                icon: Icons.person_add_alt_1_rounded,
              ),
              TextFieldBase("Nombre", ctrlName),
              TextFieldBase("Usuario", ctrlUser),
              TextFieldBase("Correo", ctrlEmail),
              TextFieldBase("Contraseña", ctrlPassword),
              ButtonBase("Crear Cuenta", () => signUp()),
              InkWell(
                onTap: () => TransitionApp.closePageOrDialog(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("¿Tienes una cuenta?"),
                    Text(" Iniciar Sesión",
                        style: TextStyle(color: Colors.green[400]))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  signUp() {}
}

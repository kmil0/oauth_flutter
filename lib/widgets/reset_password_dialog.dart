import 'package:flutter/material.dart';
import 'package:oauth_app/common/transition_app.dart';
import 'package:oauth_app/widgets/button_base.dart';
import 'package:oauth_app/widgets/textfield_base.dart';

class ResetPasswordDialog extends StatelessWidget {
  final TextEditingController ctrlEmail;
  const ResetPasswordDialog({Key? key, required this.ctrlEmail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFieldBase("Correo", ctrlEmail),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ButtonBase("Cancerlar", () => close(context)),
                ButtonBase("Restablecer", () => reset())
              ],
            )
          ],
        ),
      ),
    );
  }

  close(BuildContext context) {
    TransitionApp.closePageOrDialog(context);
  }

  reset() {}
}

import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {
  const ProgressDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: SimpleDialog(
        children: [
          Center(
            child: Column(
              children: const [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "Por favor espere...",
                  style: TextStyle(color: Colors.green),
                )
              ],
            ),
          )
        ],
      ),
      onWillPop: () async => false,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:potagenieux/globals.dart' as globals;
import 'package:potagenieux/providers/login_provider.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    Key? key,
    required this.loginProvider,
  }) : super(key: key);

  final LoginProvider loginProvider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Text(
        "email :",
        style: globals.loginTextStyle(context),
      ),
    );
  }
}

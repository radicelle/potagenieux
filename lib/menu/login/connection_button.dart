import 'package:flutter/material.dart';
import 'package:potagenieux/globals.dart' as globals;
import 'package:potagenieux/menu/login/login_item.dart';

import '../../providers/login_provider.dart';

class ConnectionButton extends LoginItem {
  const ConnectionButton(
      {Key? key,
      required this.width,
      required this.height,
      required LoginProvider loginProvider})
      : super(key: key, stateProvider: loginProvider);
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 100),
        opacity: stateProvider.opacity(Item.connection),
        child: GestureDetector(
          onTap: () => stateProvider.state = LoginState.email,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              "Se connecter",
              style: globals.loginTextStyle(context),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginProviderState {}

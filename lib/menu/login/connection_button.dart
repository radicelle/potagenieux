import 'package:flutter/material.dart';
import 'package:potagenieux/globals.dart' as globals;
import 'package:provider/provider.dart';

import '../../providers/login_provider.dart';

class ConnectionButton extends StatelessWidget {
  const ConnectionButton({Key? key, required this.width, required this.height})
      : super(key: key);
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Consumer<LoginProvider>(builder: (_, stateProvider, __) {
        return AnimatedOpacity(
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
        );
      }),
    );
  }
}

class LoginProviderState {}

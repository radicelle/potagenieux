import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:potagenieux/globals.dart' as globals;
import 'package:provider/provider.dart';

import '../../../providers/login_provider.dart';

class ConnectionButton extends StatelessWidget {
  const ConnectionButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (_, stateProvider, __) {
      return AnimatedOpacity(
        duration: const Duration(milliseconds: 100),
        opacity: stateProvider.opacity(Item.connection),
        child: GestureDetector(
          onTap: () => stateProvider.state = LoginState.email,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PlatformText(
                    "Se connecter",
                    style: globals.loginTextStyle(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}

class LoginProviderState {}

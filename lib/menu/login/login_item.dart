import 'package:flutter/cupertino.dart';
import 'package:potagenieux/providers/login_provider.dart';

abstract class LoginItem extends StatelessWidget {
  const LoginItem({Key? key, required this.stateProvider});

  final LoginProvider stateProvider;
}

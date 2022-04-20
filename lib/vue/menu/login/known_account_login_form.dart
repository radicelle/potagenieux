import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:potagenieux/globals.dart' as globals;
import 'package:potagenieux/providers/login_provider.dart';
import 'package:provider/provider.dart';

class KnownAccountLoginForm extends StatefulWidget {
  const KnownAccountLoginForm({
    Key? key,
    required this.callback,
  }) : super(key: key);

  final void Function(String password) callback;

  @override
  State<KnownAccountLoginForm> createState() => _KnownAccountLoginFormState();
}

class _KnownAccountLoginFormState extends State<KnownAccountLoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (_, loginProvider, __) {
        return Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              Row(children: [
                Expanded(
                  child: PlatformTextFormField(
                    controller: _passwordController,
                    textAlign: TextAlign.left,
                    material: (_, __) => MaterialTextFormFieldData(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.email),
                        hintText: 'Mot de passe',
                      ),
                    ),
                    cupertino: (_, __) => CupertinoTextFormFieldData(),
                    obscureText: true,
                    validator: passwordValidator,
                    onFieldSubmitted: (value) async {
                      widget.callback(_passwordController.text);
                    },
                  ),
                ),
                PlatformIconButton(
                    material: (_, __) =>
                        MaterialIconButtonData(splashRadius: 15),
                    cupertino: (_, __) => CupertinoIconButtonData(),
                    color: globals.menuColor,
                    onPressed: () => loginProvider.returnToEmail(),
                    icon: const Icon(Icons.arrow_left)),
              ]),
              PlatformTextButton(
                onPressed: () async {
                  widget.callback(_passwordController.text);
                },
                child: Text(
                  "Se connected",
                  style: globals.loginTextStyle(context),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String? passwordValidator(value) {
    if (value!.isEmpty) {
      return 'Enter your password';
    }
    return null;
  }
}

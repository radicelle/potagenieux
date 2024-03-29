import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:potagenieux/globals.dart' as globals;
import 'package:potagenieux/providers/login_provider.dart';
import 'package:provider/provider.dart';

class UnknownAccountLoginForm extends StatefulWidget {
  const UnknownAccountLoginForm({
    Key? key,
    required this.callback,
  }) : super(key: key);

  final void Function(String lastname, String firstname, String password)
      callback;

  @override
  State<UnknownAccountLoginForm> createState() =>
      _UnknownAccountLoginFormState();
}

class _UnknownAccountLoginFormState extends State<UnknownAccountLoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _firstnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (_, loginProvider, __) {
      return Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              Expanded(
                child: PlatformTextFormField(
                  controller: _passwordController,
                  validator: passwordValidator,
                  textAlign: TextAlign.left,
                  material: (_, __) => MaterialTextFormFieldData(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.email),
                      hintText: 'Mot de passe',
                    ),
                  ),
                  cupertino: (_, __) => CupertinoTextFormFieldData(),
                  obscureText: true,
                ),
              ),
              Expanded(
                child: PlatformTextFormField(
                  controller: _lastnameController,
                  textAlign: TextAlign.left,
                  material: (_, __) => MaterialTextFormFieldData(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: 'Nom',
                    ),
                  ),
                  cupertino: (_, __) => CupertinoTextFormFieldData(),
                  obscureText: true,
                ),
              ),
              Expanded(
                child: PlatformTextFormField(
                  controller: _firstnameController,
                  textAlign: TextAlign.left,
                  material: (_, __) => MaterialTextFormFieldData(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: 'Prénom',
                    ),
                  ),
                  cupertino: (_, __) => CupertinoTextFormFieldData(),
                  obscureText: true,
                ),
              ),
              PlatformTextButton(
                  onPressed: () async {
                    widget.callback(_lastnameController.text,
                        _firstnameController.text, _passwordController.text);
                  },
                  child: Text(
                    "S'enregistrer",
                    style: globals.loginTextStyle(context),
                  )),
              IconButton(
                  splashRadius: 15,
                  color: globals.menuColor,
                  onPressed: () => loginProvider.cancelRegistration(),
                  icon: const Icon(Icons.arrow_left))
            ],
          ));
    });
  }

  String? passwordValidator(String? value) {
    if (value?.isEmpty ?? true) return "Ne peut être vide";
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    if (regExp.hasMatch(value!)) {
      return null;
    } else {
      return "8 car. : 1 Maj, 1 min, 1 chiffre, 1 car. special ";
    }
  }
}

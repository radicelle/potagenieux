import 'package:flutter/material.dart';
import 'package:potagenieux/globals.dart' as globals;
import 'package:potagenieux/providers/login_provider.dart';
import 'package:provider/provider.dart';

class UnknownAccountLoginForm extends StatefulWidget {
  const UnknownAccountLoginForm({
    Key? key,
    required this.width,
    required this.height,
    required this.callback,
  }) : super(key: key);

  final void Function(String lastname, String firstname, String password)
      callback;
  final double width;
  final double height;

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
    var paddingLeft = 20.0;
    return Padding(
        padding: EdgeInsets.only(left: paddingLeft),
        child: Container(
          width: widget.width - 100,
          height: widget.height,
          alignment: Alignment.centerLeft,
          child: Consumer<LoginProvider>(builder: (_, loginProvider, __) {
            return Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _passwordController,
                        validator: passwordValidator,
                        textAlign: TextAlign.left,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.email),
                          hintText: 'Mot de passe',
                        ),
                        obscureText: true,
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _lastnameController,
                        textAlign: TextAlign.left,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.email),
                          hintText: 'Nom',
                        ),
                        obscureText: true,
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _firstnameController,
                        textAlign: TextAlign.left,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.email),
                          hintText: 'Prénom',
                        ),
                        obscureText: true,
                      ),
                    ),
                    TextButton(
                        onPressed: () async {
                          widget.callback(
                              _lastnameController.text,
                              _firstnameController.text,
                              _passwordController.text);
                        },
                        child: const Text("S'enregistrer")),
                    IconButton(
                        splashRadius: 15,
                        color: globals.menuColor,
                        onPressed: () => loginProvider.cancelRegistration(),
                        icon: const Icon(Icons.arrow_left))
                  ],
                ));
          }),
        ));
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

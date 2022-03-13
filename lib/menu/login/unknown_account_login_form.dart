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
                    Row(children: [
                      Expanded(
                        child: TextFormField(
                          controller: _passwordController,
                          textAlign: TextAlign.left,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.email),
                            hintText: 'mot de passe',
                            labelText: 'mot de passe',
                          ),
                          obscureText: true,
                          validator: passwordValidator,
                        ),
                      ),
                      IconButton(
                          splashRadius: 15,
                          color: globals.menuColor,
                          onPressed: () => loginProvider.returnToEmail(),
                          icon: const Icon(Icons.arrow_left)),
                    ]),
                    TextButton(
                        onPressed: () async {
                          widget.callback(
                              _lastnameController.text,
                              _firstnameController.text,
                              _passwordController.text);
                        },
                        child: const Text("se connected"))
                  ],
                ));
          }),
        ));
  }

  String? passwordValidator(value) {
    if (value!.isEmpty) {
      return 'Enter your password';
    }
    return null;
  }
}

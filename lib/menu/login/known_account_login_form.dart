import 'package:flutter/material.dart';
import 'package:potagenieux/globals.dart' as globals;
import 'package:potagenieux/providers/login_provider.dart';
import 'package:provider/provider.dart';

class KnownAccountLoginForm extends StatefulWidget {
  const KnownAccountLoginForm({
    Key? key,
    required this.width,
    required this.height,
    required this.callback,
  }) : super(key: key);

  final void Function(String password) callback;
  final double width;
  final double height;

  @override
  State<KnownAccountLoginForm> createState() => _KnownAccountLoginFormState();
}

class _KnownAccountLoginFormState extends State<KnownAccountLoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
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
                            hintText: 'Mot de passe',
                          ),
                          obscureText: true,
                          validator: passwordValidator,
                          onFieldSubmitted: (value) async {
                            widget.callback(_passwordController.text);
                          },
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
                          widget.callback(_passwordController.text);
                        },
                        child: const Text("Se connected"))
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

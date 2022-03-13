import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:potagenieux/globals.dart' as globals;
import 'package:potagenieux/providers/login_provider.dart';
import 'package:provider/provider.dart';

class EmailTextField extends StatefulWidget {
  const EmailTextField({
    Key? key,
    required this.loginProvider,
    required this.width,
    required this.height,
    required this.callback,
  }) : super(key: key);

  final LoginProvider loginProvider;
  final void Function(String email) callback;
  final double width;
  final double height;

  @override
  State<EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
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
                          controller: _controller,
                          textAlign: TextAlign.left,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.email),
                            hintText: 'abc@quelquechose.xyz',
                            labelText: 'email',
                          ),
                          validator: emailValidator,
                        ),
                      ),
                      IconButton(
                          splashRadius: 15,
                          color: globals.menuColor,
                          onPressed: () => loginProvider.cancelRegistration(),
                          icon: const Icon(Icons.arrow_left)),
                    ]),
                    TextButton(
                        onPressed: () async {
                          widget.callback(_controller.text);
                        },
                        child: const Text("se connected"))
                  ],
                ));
          }),
        ));
  }

  String? emailValidator(value) {
    if (EmailValidator.validate(value ?? "")) {
      return null;
    } else {
      return "Saisissez un email valide";
    }
  }
}

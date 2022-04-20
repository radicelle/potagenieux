import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:potagenieux/globals.dart' as globals;
import 'package:potagenieux/providers/login_provider.dart';
import 'package:provider/provider.dart';

class EmailTextField extends StatefulWidget {
  const EmailTextField({
    Key? key,
    required this.callback,
    this.knownEmail,
  }) : super(key: key);

  final String? knownEmail;
  final void Function(String email) callback;

  @override
  State<EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.knownEmail);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (_, loginProvider, __) {
        return Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              Row(children: [
                Flexible(
                  flex: 3,
                  child: PlatformTextFormField(
                    controller: _controller,
                    textAlign: TextAlign.left,
                    material: (_, __) => MaterialTextFormFieldData(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.email),
                        hintText: 'abc@quelquechose.xyz',
                        labelText: 'email',
                      ),
                    ),
                    cupertino: (_, __) => CupertinoTextFormFieldData(),
                    validator: globals.emailValidator,
                    onFieldSubmitted: (value) async {
                      widget.callback(value);
                    },
                  ),
                ),
                IconButton(
                    splashRadius: 15,
                    color: globals.menuColor,
                    onPressed: () => loginProvider.cancelRegistration(),
                    icon: const Icon(Icons.arrow_left)),
              ]),
              Flexible(
                flex: 2,
                child: PlatformTextButton(
                  onPressed: () async {
                    widget.callback(_controller.text);
                  },
                  child: Text(
                    "Suivant",
                    style: globals.loginTextStyle(context),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

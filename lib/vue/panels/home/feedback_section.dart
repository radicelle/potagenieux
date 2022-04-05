import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:potagenieux/globals.dart' as globals;
import 'package:responsive_framework/responsive_framework.dart';

class FeedbackSection extends StatefulWidget {
  const FeedbackSection({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  State<FeedbackSection> createState() => _FeedbackSectionState();
}

class _FeedbackSectionState extends State<FeedbackSection> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;

  late final TextEditingController _subjectController;

  late final TextEditingController _messageController;
  bool _canSend = false;
  bool _sent = false;
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _subjectController = TextEditingController();
    _messageController = TextEditingController();
    _messageController.addListener(() {
      setState(() {
        _canSend = _messageController.text.isNotEmpty &&
            _subjectController.text.isNotEmpty &&
            _emailController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _subjectController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var emailFunction =
        FirebaseFunctions.instanceFor(region: 'europe-west1').httpsCallable(
      globals.CloudFunctions.sendMail.name,
      options: HttpsCallableOptions(
        timeout: const Duration(seconds: 4),
      ),
    );
    return LayoutBuilder(builder: (context, constraints) {
      return FractionallySizedBox(
        widthFactor:
            ResponsiveWrapper.of(context).isLargerThan(TABLET) ? 0.7 : 0.9,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: !_sent
                ? [
                    PlatformText(
                      "Contactez le Potagénieux",
                      style: globals.menuTextStyle(context),
                    ),
                    FeedbackSectionTextFormField(
                      controller: _emailController,
                      name: "Courriel",
                      validator: globals.emailValidator,
                    ),
                    FeedbackSectionTextFormField(
                      controller: _subjectController,
                      name: "Sujet",
                    ),
                    FeedbackSectionTextFormField(
                      controller: _messageController,
                      maxLines: 7,
                      name: "Message",
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: PlatformElevatedButton(
                          onPressed: _canSend
                              ? () async {
                                  setState(() {
                                    _canSend = false;
                                  });

                                  try {
                                    await emailFunction.call(<String, dynamic>{
                                      'email': _emailController.text,
                                      'subject': "[Potagenieux]: " +
                                          _subjectController.text,
                                      'message': _messageController.text,
                                    });
                                    setState(() {
                                      _sent = true;
                                    });
                                  } catch (e) {
                                    setState(() {
                                      _canSend = true;
                                    });
                                    (e);
                                    globals.showErrorDialog(
                                        context,
                                        "Erreur lors de l'envoie du courriel",
                                        Exception(
                                            "Le message n'a pas pu être envoyé."));
                                    return;
                                  }
                                  await Future.delayed(
                                      const Duration(seconds: 4), () => {});
                                  setState(() {
                                    _messageController.clear();
                                    _subjectController.clear();
                                    _sent = false;
                                  });
                                }
                              : null,
                          child: PlatformText("Envoyer")),
                    )
                  ]
                : [
                    PlatformText("Votre message à bien été envoyé.",
                        style: globals.menuTextStyle(context))
                  ],
          ),
        ),
      );
    });
  }
}

class FeedbackSectionTextFormField extends StatelessWidget {
  const FeedbackSectionTextFormField({
    Key? key,
    required this.controller,
    this.name = "",
    this.maxLines,
    this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final String? name;
  final int? maxLines;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none);

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: PlatformTextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        validator: validator ?? globals.notEmptyValidator,
        material: (_, __) => MaterialTextFormFieldData(
          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Colors.grey[300],
            filled: true,
            labelText: name,
            focusedErrorBorder: border,
            focusedBorder: border,
            enabledBorder: border,
            errorBorder: border,
          ),
        ),
        cupertino: (_, __) => CupertinoTextFormFieldData(
          decoration: BoxDecoration(
            border: Border.all(width: 0),
            color: Colors.grey[300],
          ),
        ),
        maxLines: maxLines,
      ),
    );
  }
}

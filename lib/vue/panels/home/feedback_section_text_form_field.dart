import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeedbackSectionTextFormField extends StatelessWidget {
  const FeedbackSectionTextFormField({
    Key? key,
    required TextEditingController subjectController,
  })  : _subjectController = subjectController,
        super(key: key);

  final TextEditingController _subjectController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _subjectController,
    );
  }
}

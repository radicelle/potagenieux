import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class FeedbackSectionTextFormField extends StatelessWidget {
  const FeedbackSectionTextFormField({
    Key? key,
    required TextEditingController subjectController,
  })  : _subjectController = subjectController,
        super(key: key);

  final TextEditingController _subjectController;

  @override
  Widget build(BuildContext context) {
    return PlatformTextFormField(
      controller: _subjectController,
    );
  }
}

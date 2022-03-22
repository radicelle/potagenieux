import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:potagenieux/globals.dart' as globals;

import 'future_terms_markdown.dart';

class InfoBottomSheet extends StatelessWidget {
  const InfoBottomSheet({
    Key? key,
    required AnimationController sheetController,
    required this.width,
    required this.height,
  })  : _sheetController = sheetController,
        super(key: key);
  final double width;
  final double height;
  final AnimationController _sheetController;

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      animationController: _sheetController,
      backgroundColor: Colors.transparent,
      elevation: height / 8,
      onClosing: () {},
      builder: (BuildContext context) {
        var dividerSideIndent = width / 5;
        return PlatformElevatedButton(
          onPressed: () {
            showDialog(
                barrierColor: Colors.white,
                context: context,
                builder: (context) => const FutureTermsMarkdown());
          },
          child: Text(
            "Termes & conditions",
            style: globals.bodyTextStyle(context),
          ),
        );
      },
    );
  }
}

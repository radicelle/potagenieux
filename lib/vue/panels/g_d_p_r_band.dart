import 'package:flutter/material.dart';
import 'package:potagenieux/globals.dart' as globals;
import 'package:potagenieux/providers/gdpr_provider.dart';
import 'package:potagenieux/vue/panels/home/info_bottom_sheet.dart';
import 'package:provider/provider.dart';

class GDPRBand extends StatelessWidget {
  const GDPRBand({
    Key? key,
    required AnimationController sheetController,
  })  : _sheetController = sheetController,
        super(key: key);

  final AnimationController _sheetController;

  @override
  Widget build(BuildContext context) {
    return Consumer<GDPRProvider>(builder: (_, gdpr, __) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(
              child: SizedBox(),
            ),
            InfoBottomSheet(
              sheetController: _sheetController,
              height: 200,
            ),
            const VerticalDivider(),
            IconButton(
              tooltip: "politique des cookies et données",
              icon: Icon(
                Icons.cookie,
                color: globals.headerTextColor,
              ),
              onPressed: () => gdpr.askForConsent(context),
            ),
            const Expanded(
              child: SizedBox(),
            ),
          ],
        ),
      );
    });
  }
}

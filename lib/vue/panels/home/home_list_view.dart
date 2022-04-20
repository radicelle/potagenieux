import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:potagenieux/globals.dart' as globals;
import 'package:potagenieux/providers/gdpr_provider.dart';
import 'package:potagenieux/vue/panels/home/info_bottom_sheet.dart';
import 'package:provider/provider.dart';

import 'feedback_section.dart';
import 'home_list_view_texts.dart';
import 'image_switcher.dart';

class HomeListView extends StatefulWidget {
  const HomeListView({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeListView> createState() => _HomeListViewState();
}

class _HomeListViewState extends State<HomeListView>
    with TickerProviderStateMixin {
  late ScrollController _scrollController;
  bool _isTermsDisplayed = false;
  bool _delayListen = false;
  late AnimationController _sheetController;

  @override
  void dispose() {
    _scrollController.dispose();
    _sheetController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _sheetController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (!_delayListen) {
        var position = _scrollController.position;
        setState(() {
          if (position.pixels >=
              position.maxScrollExtent -
                  MediaQuery.of(context).size.width / 10) {
            _isTermsDisplayed = true;
            _delayListen = true;
            Future.delayed(
                const Duration(milliseconds: 500),
                () => _delayListen =
                    false); // TODO: find a fix for this regardless the platform
          } else {
            _isTermsDisplayed = false;
          }
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: LayoutBuilder(builder: (context, constraints) {
            var widgets = [
              const ImageSwitcher(),
              const HomeListViewTexts(start: 0, numberToDisplay: 4),
              const FeedbackSection(),
            ];
            return ListView.builder(
              controller: _scrollController,
              itemExtent: 0.8 * MediaQuery.of(context).size.height,
              itemCount: widgets.length,
              itemBuilder: (BuildContext context, int index) {
                return widgets[index];
              },
            );
          }),
        ),
        _isTermsDisplayed
            ? Consumer<GDPRProvider>(builder: (_, gdpr, __) {
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
              })
            : const SizedBox()
      ],
    );
  }
}

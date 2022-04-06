import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:potagenieux/globals.dart' as globals;
import 'package:potagenieux/providers/gdpr_provider.dart';
import 'package:potagenieux/providers/image_panel_change_notifier.dart';
import 'package:potagenieux/vue/panels/home/info_bottom_sheet.dart';
import 'package:provider/provider.dart';

import 'feedback_section.dart';
import 'home_list_view_texts.dart';
import 'image_switcher.dart';

class HomeListView extends StatefulWidget {
  const HomeListView({
    Key? key,
    required this.itemExtend,
  }) : super(key: key);
  final double itemExtend;

  @override
  State<HomeListView> createState() => _HomeListViewState();
}

class _HomeListViewState extends State<HomeListView>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool _isTermsDisplayed = false;
  late AnimationController _sheetController;
  @override
  void initState() {
    super.initState();
    _sheetController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _scrollController.addListener(() {
      var position = _scrollController.position;
      setState(() {
        if (position.pixels >=
            position.maxScrollExtent - widget.itemExtend / 4) {
          _isTermsDisplayed = true;
        } else {
          _isTermsDisplayed = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ImagePanelChangeNotifier.fromIndex(0),
      child: Column(
        children: [
          Expanded(
            child: LayoutBuilder(builder: (context, constraints) {
              var itemExtent = 0.8 * constraints.maxHeight;

              return ListView(
                itemExtent: itemExtent,
                children: [
                  const ImageSwitcher(),
                  HomeListViewTexts(height: itemExtent),
                  FeedbackSection(height: itemExtent),
                  SizedBox(
                    height: constraints.maxHeight / 4,
                  )
                ],
              );
            }),
          ),
          _isTermsDisplayed
              ? Padding(
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
                      Consumer<GDPRProvider>(builder: (_, gdpr, __) {
                        return IconButton(
                          tooltip: "politique des cookies et données",
                          icon: Icon(
                            Icons.cookie,
                            color: globals.headerTextColor,
                          ),
                          onPressed: () => gdpr.askForConsent(context),
                        );
                      }),
                      const Expanded(
                        child: SizedBox(),
                      ),
                    ],
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}

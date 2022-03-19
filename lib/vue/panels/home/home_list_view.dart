import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:potagenieux/globals.dart' as globals;
import 'package:potagenieux/providers/image_panel_change_notifier.dart';
import 'package:provider/provider.dart';

import 'feedback_section.dart';
import 'future_terms_markdown.dart';
import 'home_list_view_texts.dart';
import 'image_switcher.dart';

class HomeListView extends StatefulWidget {
  const HomeListView({
    Key? key,
    required this.width,
    required this.height,
    required this.miniImagesHeight,
  }) : super(key: key);

  final double width;
  final double height;
  final double miniImagesHeight;

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
        if (position.pixels >= position.maxScrollExtent - widget.height / 7) {
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
            child: ListView(
              physics: const BouncingScrollPhysics(),
              controller: _scrollController,
              children: [
                ImageSwitcher(
                    width: widget.width,
                    height: widget.height,
                    miniImagesHeight: widget.miniImagesHeight),
                HomeListViewTexts(
                  width: widget.width,
                  height: widget.height,
                ),
                FeedbackSection(width: widget.width, height: widget.height),
              ],
              itemExtent: widget.height,
            ),
          ),
          _isTermsDisplayed
              ? BottomSheet(
                  animationController: _sheetController,
                  backgroundColor: Colors.transparent,
                  elevation: widget.height / 8,
                  onClosing: () {},
                  builder: (BuildContext context) => Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Divider(
                              height: 1,
                              thickness: 2,
                              endIndent: widget.width / 5,
                              indent: widget.width / 5,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                    barrierColor: Colors.white,
                                    context: context,
                                    builder: (context) =>
                                        const FutureTermsMarkdown());
                              },
                              child: Text(
                                "Termes & conditions",
                                style: globals.bodyTextStyle(context),
                              ),
                            ),
                          )
                        ],
                      ))
              : Container()
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:potagenieux/providers/image_panel_change_notifier.dart';
import 'package:potagenieux/vue/panels/home/info_bottom_sheet.dart';
import 'package:provider/provider.dart';

import 'feedback_section.dart';
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
              itemExtent: widget.height,
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
            ),
          ),
          _isTermsDisplayed
              ? InfoBottomSheet(
                  sheetController: _sheetController,
                  width: widget.width,
                  height: widget.height,
                )
              : const SizedBox()
        ],
      ),
    );
  }
}

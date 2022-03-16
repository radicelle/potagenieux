import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:potagenieux/panels/home/feedback_section.dart';
import 'package:potagenieux/panels/home/home_list_view_texts.dart';
import 'package:potagenieux/panels/home/image_switcher.dart';
import 'package:potagenieux/providers/image_panel_change_notifier.dart';
import 'package:provider/provider.dart';

class HomeListView extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ImagePanelChangeNotifier.fromIndex(0),
      child: ListView(
        children: [
          ImageSwitcher(
              width: width, height: height, miniImagesHeight: miniImagesHeight),
          HomeListViewTexts(
            width: width,
            height: height,
          ),
          FeedbackSection(width: width, height: height),
          SizedBox(
            height: height / 6,
          )
        ],
        itemExtent: height,
      ),
    );
  }
}

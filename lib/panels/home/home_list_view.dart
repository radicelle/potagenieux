import 'package:flutter/cupertino.dart';
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
          SizedBox(
            width: width,
            height: height,
          )
        ],
        itemExtent: height,
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:potagenieux/providers/image_panel_change_notifier.dart';
import 'package:provider/provider.dart';

import '../../globals.dart' as globals;
import 'hover_selectable_image.dart';

class ImageSwitcher extends StatelessWidget {
  const ImageSwitcher({
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
    return Stack(children: [
      Positioned(
        child: Consumer<ImagePanelChangeNotifier>(builder: (_, imgCons, __) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) =>
                FadeTransition(
              opacity: animation,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(width: width, height: height, child: child),
              ),
            ),
            child: imgCons.selectedImage,
          );
        }),
      ),
      Positioned(
          top: height - miniImagesHeight,
          right: 0,
          child: ConstrainedBox(
            constraints:
                BoxConstraints(maxHeight: miniImagesHeight, minWidth: width),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ...globals.imagesNamesMap.keys
                    .map((index) => HoverSelectableImage(index: index))
              ],
            ),
          ))
    ]);
  }
}

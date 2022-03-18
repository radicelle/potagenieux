import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:potagenieux/globals.dart' as globals;
import 'package:potagenieux/providers/image_panel_change_notifier.dart';
import 'package:provider/provider.dart';

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
    var bottomShiftHorizontal = width / 10;
    var bottomShiftUp = bottomShiftHorizontal / 5;

    var miniImagesHeight2 = height / 8;
    return Stack(children: [
      Positioned(
        child: Consumer<ImagePanelChangeNotifier>(builder: (_, imgCons, __) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: ClipPath(
                  clipper: BackgroundClipper(
                      bottomHeight: height / 10 - bottomShiftUp / 2,
                      bottomWidth: bottomShiftHorizontal),
                  child: SizedBox(
                      width: width,
                      height: height - bottomShiftUp,
                      child: child),
                ),
              );
            },
            child: imgCons.selectedImage,
          );
        }),
      ),
      Positioned(
          top: height - miniImagesHeight2,
          right: bottomShiftHorizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: miniImagesHeight2 * 2,
                maxWidth: width - bottomShiftHorizontal * 2),
            child: GridView(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: globals.imagesNamesMap.length,
                  childAspectRatio: width / height * 0.7,
                  crossAxisSpacing: width / 60),
              children: [
                ...globals.imagesNamesMap.keys
                    .map((index) => HoverSelectableImage(index: index))
              ],
            ),
          ))
    ]);
  }
}

class BackgroundClipper extends CustomClipper<Path> {
  const BackgroundClipper(
      {required this.bottomHeight, required this.bottomWidth});
  final double bottomHeight;
  final double bottomWidth;

  @override
  Path getClip(Size size) {
    var path = Path();
    var borderWidth = bottomWidth;
    var borderHeight = bottomHeight + 10;

    //top left
    //path.moveTo(0, borderHeight);
    var midBorderHeight = borderHeight / 2;
    var midBorderWidth = borderWidth / 2;
    path.lineTo(0, size.height - midBorderHeight); //bottom left
    path.quadraticBezierTo(0, size.height, midBorderWidth, size.height);
    path.lineTo(midBorderWidth, size.height);
    path.quadraticBezierTo(borderWidth, size.height, borderWidth * 0.8,
        size.height - midBorderHeight);
    path.quadraticBezierTo(borderWidth, size.height - borderHeight,
        borderWidth * 1.5, size.height - borderHeight);
    path.lineTo(size.width - borderWidth * 1.5,
        size.height - borderHeight); // right side
    path.quadraticBezierTo(size.width - borderWidth, size.height - borderHeight,
        size.width - borderWidth * 0.8, size.height - midBorderHeight);
    path.quadraticBezierTo(size.width - borderWidth, size.height,
        size.width - midBorderWidth, size.height);
    path.lineTo(size.width - borderWidth, size.height);
    path.lineTo(size.width - midBorderWidth, size.height); // bottom right
    path.quadraticBezierTo(size.width, size.height, size.width,
        size.height - midBorderHeight); // bottom right
    path.lineTo(size.width, 0); //top right
    //path.quadraticBezierTo(size.width, 0, size.width - borderWidth, 0);
    path.lineTo(borderHeight, 0);
    //path.quadraticBezierTo(0, 0, 0, borderHeight);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

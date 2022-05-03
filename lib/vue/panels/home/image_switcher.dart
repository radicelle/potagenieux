import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:potagenieux/globals.dart' as globals;
import 'package:potagenieux/providers/image_panel_change_notifier.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_grid/responsive_grid.dart';

import 'hover_selectable_image.dart';

class ImageSwitcher extends StatelessWidget {
  const ImageSwitcher({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double width = constraints.maxWidth;
      double height = globals.displayDrawer(context)
          ? constraints.maxHeight / 1.2
          : constraints.maxHeight;
      var bottomShiftHorizontal = width / 10;
      var bottomShiftUp = bottomShiftHorizontal / 5;
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
                        bottomHeight: ResponsiveWrapper.of(context)
                                .isLargerThan(globals.largeMobile)
                            ? height / 8
                            : height / 6,
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
            bottom: globals.displayDrawer(context)
                ? constraints.maxHeight * 0.1
                : 0,
            left: 0,
            child: SizedBox(
              width: width,
              child: Padding(
                padding: EdgeInsets.only(
                    right: bottomShiftHorizontal, left: bottomShiftHorizontal),
                child: ResponsiveGridList(
                  scroll: false,
                  desiredItemWidth: ResponsiveWrapper.of(context)
                          .isLargerThan(globals.largeMobile)
                      ? width / 11
                      : width / 6,
                  minSpacing: 2,
                  rowMainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...globals.imagesNamesMap.keys.map(
                      (index) => HoverSelectableImage(index: index),
                    )
                  ],
                ),
              ),
            ))
      ]);
    });
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

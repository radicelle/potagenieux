import 'package:flutter/material.dart';

class CamPreviewCondensed extends StatelessWidget {
  const CamPreviewCondensed(
      {required this.width,
      required this.height,
      required this.preview,
      required this.aspectRatio,
      Key? key})
      : super(key: key);

  final double width;
  final double height;
  final double aspectRatio;
  final Widget preview;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        child: OverflowBox(
          alignment: Alignment.center,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: SizedBox(
              width: width,
              height: _isPortrait(context)
                  ? height / (1 / aspectRatio)
                  : height / aspectRatio,
              child: preview, // this is my CameraPreview
            ),
          ),
        ),
      ),
    );
  }

  _isPortrait(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.portrait;
}

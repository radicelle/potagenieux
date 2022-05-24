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
    return Container(
      width: width,
      height: height,
      child: ClipRect(
        child: OverflowBox(
          alignment: Alignment.center,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Container(
              width: width,
              height: height / aspectRatio,
              child: preview, // this is my CameraPreview
            ),
          ),
        ),
      ),
    );
  }
}

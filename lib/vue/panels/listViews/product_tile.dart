import 'package:flutter/material.dart';
import 'package:potagenieux/providers/ProviderWidgets/cached_firebase_image.dart';

import '../../../globals.dart' as globals;

class ProductTile extends StatelessWidget {
  const ProductTile({
    Key? key,
    required this.desc,
    required this.inStock,
    this.firebaseImage,
    this.cameraPreview,
    required this.height,
    required this.width,
  })  : assert((firebaseImage != null || cameraPreview != null) &&
            !(firebaseImage != null && cameraPreview != null)),
        super(key: key);

  final double height;
  final double width;
  final CachedFirebaseImage? firebaseImage;
  final Widget? cameraPreview;
  final String desc;
  final bool inStock;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GlassContainer(
        height: height,
        width: width,
        content: Column(
          children: [
            Flexible(
              flex: 3,
              child: Center(
                child: Text(
                  desc,
                  style: globals.productHeaderTextStyle(context),
                ),
              ),
            ),
            Flexible(
                flex: 30,
                child: SizedBox(
                    width: width * 0.95, child: firebaseImage ?? cameraPreview)),
            const Spacer(flex: 3),
            Flexible(
              flex: 3,
              child: SizedBox(
                width: width * 0.95,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const Text("Stock: "),
                        inStock
                            ? Icon(
                                Icons.check_box,
                                color: Colors.green.shade700,
                              )
                            : Icon(
                                Icons.close,
                                color: Colors.red.shade900,
                              )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}

class GlassContainer extends StatelessWidget {
  const GlassContainer({
    Key? key,
    required this.content,
    required this.width,
    required this.height,
  }) : super(key: key);
  final Widget content;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 25,
                  spreadRadius: -5),
            ],
            gradient: const LinearGradient(
                colors: [Colors.white60, Colors.white10],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(width: 2, color: Colors.white30)),
        child: content);
  }
}

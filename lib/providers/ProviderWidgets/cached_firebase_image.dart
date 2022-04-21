import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:potagenieux/globals.dart' as globals;

class CachedFirebaseImage extends StatelessWidget {
  const CachedFirebaseImage(
      {required this.name,
      required this.boxFit,
      required this.locationFunction,
      this.height,
      Key? key})
      : super(key: key);
  final String name;
  final BoxFit boxFit;
  final double? height;
  final String Function(String) locationFunction;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      key: ValueKey(name),
      future:
          FirebaseStorage.instance.ref(locationFunction(name)).getDownloadURL(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState != ConnectionState.waiting) {
          return Image(
            fit: BoxFit.cover,
            height: height,
            image: CachedNetworkImageProvider(
              snapshot.data.toString(),
            ),
          );
        } else {
          return LoadingJumpingLine.circle(
            backgroundColor: globals.menuColor,
            borderColor: Colors.grey,
          );
        }
      },
    );
  }
}

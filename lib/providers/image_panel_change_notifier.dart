import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

import '../globals.dart' as globals;

class ImagePanelChangeNotifier extends ChangeNotifier {
  late int _selectedIndex;

  late final List<FutureBuilder<dynamic>> _images = [
    ...globals.imagesNamesMap.values.map((name) => FutureBuilder<dynamic>(
          key: ValueKey(name),
          future: FirebaseStorage.instance
              .ref(name.getAssetImage())
              .getDownloadURL(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState != ConnectionState.waiting) {
              return Image(
                fit: BoxFit.cover,
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
        ))
  ];
  final List<FutureBuilder<dynamic>> _miniatures = [
    ...globals.imagesNamesMap.values.map((name) => FutureBuilder<dynamic>(
          key: ValueKey(name),
          future: FirebaseStorage.instance
              .ref(name.getAssetMiniImage())
              .getDownloadURL(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState != ConnectionState.waiting) {
              return Image(
                fit: BoxFit.fill,
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
        ))
  ];

  ImagePanelChangeNotifier.fromIndex(int index) {
    _selectedIndex = index;
  }
  Widget get selectedImage => _images[_selectedIndex];
  int get selected => _selectedIndex;

  set selectedIndex(int index) {
    if (index == _selectedIndex) return;
    _selectedIndex = index;
    notifyListeners();
  }

  miniature(int index) => _miniatures[index];
}

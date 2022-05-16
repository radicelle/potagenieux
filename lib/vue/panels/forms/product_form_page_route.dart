import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ProductFormPageRoute extends StatelessWidget {
  const ProductFormPageRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute<void>(
            builder: (BuildContext _) => const AddProductForm(),
            settings: settings);
      },
    );
  }
}

class AddProductForm extends StatefulWidget {
  const AddProductForm({
    Key? key,
  }) : super(key: key);

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    var cameraList = availableCameras();
    cameraList
        .then((list) => {
              _controller = CameraController(
                list.first,
                ResolutionPreset.medium,
              )
            })
        .whenComplete(
            () => _initializeControllerFuture = _controller.initialize());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        PlatformElevatedButton(
            child: const Text("Shoot"),
            onPressed: () async {
              var image = await _controller.takePicture();
              setState(() {
                _imageFile = File(image.path);
              });
            }),
        const Spacer(),
        _imageFile != null
            ? Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black)),
                child: kIsWeb
                    ? Image.network(_imageFile!.path)
                    : Image.file(File(_imageFile!.path)),
              )
            : const FlutterLogo(),
        const Spacer()
      ],
    );
  }
}

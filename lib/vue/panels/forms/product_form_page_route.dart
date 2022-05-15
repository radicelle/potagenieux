import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

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
  late CameraController? _controller;
  late Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    var cameraList = availableCameras();
    cameraList.then((list) => {
          _controller = CameraController(
            list.first,
            ResolutionPreset.medium,
          )
        });
    //if (_controller == null) _controller = CameraController(, resolutionPreset);
    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller?.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Column();
  }
}

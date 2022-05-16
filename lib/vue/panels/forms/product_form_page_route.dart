import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:potagenieux/vue/panels/listViews/product_tile.dart';

class ProductFormPageRoute extends StatelessWidget {
  const ProductFormPageRoute(this.cameras, {Key? key}) : super(key: key);
  final List<CameraDescription> cameras;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute<void>(
            builder: (BuildContext _) => AddProductForm(cameras),
            settings: settings);
      },
    );
  }
}

class AddProductForm extends StatefulWidget {
  const AddProductForm(this.cameras, {Key? key}) : super(key: key);
  final List<CameraDescription> cameras;

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
    _controller =
        CameraController(widget.cameras.first, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the Future is complete, display the preview.
          return LayoutBuilder(builder: (context, constraints) {
            var width = constraints.maxWidth / 1.1;
            var height = width / 1.25;
            return ProductTile(
              desc: "description",
              width: width,
              height: height,
              cameraPreview: CameraPreview(_controller),
              inStock: true,
            );
          });
        } else {
          // Otherwise, display a loading indicator.
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

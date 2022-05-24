import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:potagenieux/vue/panels/forms/widgets/cam_preview_condensed.dart';
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
  var _zoom = 1.0;
  late var _camera;
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _camera = widget.cameras.first;
    _controller = CameraController(_camera, ResolutionPreset.max);

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
          return Scaffold(
            body: LayoutBuilder(builder: (context, constraints) {
              var width = constraints.maxWidth / 1.1;
              var height = width / 1.25;
              return Column(
                children: [
                  ProductTile(
                    desc: "description",
                    width: width,
                    height: height,
                    cameraPreview: CamPreviewCondensed(
                        width: width,
                        height: height,
                        preview: _controller.buildPreview(),
                        aspectRatio: _controller.value.aspectRatio),
                    inStock: true,
                  ),
                  PlatformSlider(
                    value: _zoom,
                    min: 1.0,
                    max: 4.0,
                    onChanged: (value) => {
                      setState(
                        () {
                          _zoom = value;
                          _controller.setZoomLevel(_zoom);
                        },
                      )
                    },
                  ),
                  Row(
                    children: [
                      ...widget.cameras.map((e) => Flexible(
                          flex: 1,
                          child: ElevatedButton(
                            onPressed: () => {
                              setState(
                                () {
                                  _camera = e;
                                  //_controller = CameraController(e, ResolutionPreset.max);
                                },
                              )
                            },
                            child: Column(children: [
                              const Icon(Icons.camera),
                              Text(e.name)
                            ]),
                          )))
                    ],
                  )
                ],
              );
            }),
          );
        } else {
          // Otherwise, display a loading indicator.
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

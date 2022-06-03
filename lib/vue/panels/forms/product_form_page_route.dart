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

  Future<void> onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = _controller;
    // Instantiating the camera controller
    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    // Dispose the previous controller
    await previousCameraController.dispose();

    // Replace with the new controller
    if (mounted) {
      setState(() {
        _controller = cameraController;
      });
    }

    // Update UI if controller updated
    cameraController.addListener(() {
      if (mounted) setState(() {});
    });

    // Initialize controller
    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      print('Error initializing camera: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        var width = constraints.maxWidth / 1.1;
        var height = width / 1.25;
        return Column(
          children: [
            Spacer(
              flex: 1,
            ),
            Flexible(
              flex: 6,
              child: ProductTile(
                desc: "description",
                width: width,
                height: height,
                cameraPreview: FutureBuilder(
                    future: _initializeControllerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return CamPreviewCondensed(
                            width: width,
                            height: height,
                            preview: CameraPreview(_controller),
                            aspectRatio: _controller.value.aspectRatio);
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
                inStock: true,
              ),
            ),
            Flexible(
              flex: 1,
              child: PlatformSlider(
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
            ),
            Row(
              children: [
                ...widget.cameras.map((e) => Flexible(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _initializeControllerFuture = onNewCameraSelected(e);
                        });
                      },
                      child: Column(
                          children: [const Icon(Icons.camera), Text(e.name)]),
                    )))
              ],
            )
          ],
        );
      }),
    );
  }
}

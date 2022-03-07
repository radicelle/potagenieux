import 'package:flutter/material.dart';
import 'package:flutter/src/gestures/events.dart';
import 'package:provider/provider.dart';

import 'globals.dart' as globals;
import 'main_image_change_notifier.dart';

class HoverSelectableImage extends StatefulWidget {
  const HoverSelectableImage(this.index, {Key? key}) : super(key: key);
  final int index;
  @override
  _HoverSelectableImageState createState() => _HoverSelectableImageState();
}

class _HoverSelectableImageState extends State<HoverSelectableImage>
    with SingleTickerProviderStateMixin {
  late double _globalOpacity;
  @override
  void initState() {
    _globalOpacity = globals.defaultOpacity;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainImageChangeNotifier>(
      builder: (_, imgCons, __) {
        var isSelected = imgCons.selected == widget.index;
        return DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(
                color:
                    isSelected ? Colors.white : Colors.black.withOpacity(0.5),
                width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            shape: BoxShape.rectangle,
          ),
          child: GestureDetector(
            onTap: () => imgCons.setImage(widget.index),
            child: MouseRegion(
              onEnter: _enlight,
              onExit: _darken,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 100),
                opacity: _globalOpacity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: miniImages[widget.index],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _enlight(PointerEnterEvent event) {
    setState(() {
      _globalOpacity = 1;
    });
  }

  void _darken(PointerExitEvent event) {
    setState(() {
      _globalOpacity = globals.defaultOpacity;
    });
  }

  static const imagesNamesMap = {
    0: "MSV1",
    1: "MSV2",
    2: "MSV3",
    3: "MSV4",
    4: "MSV5",
    5: "MSV6",
    6: "MSV7",
    7: "MSV8"
  };

  static final miniImages = [
    ...imagesNamesMap.keys.map((imageIndex) => Padding(
          padding: const EdgeInsets.all(20.0),
          child: HoverSelectableImage(imageIndex),
        ))
  ];
}

import 'package:flutter/material.dart';
import 'package:flutter/src/gestures/events.dart';
import 'package:provider/provider.dart';

import '../../globals.dart' as globals;
import '../../providers/main_image_change_notifier.dart';

class HoverSelectableImage extends StatefulWidget {
  const HoverSelectableImage({required this.index, Key? key}) : super(key: key);
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
        return Padding(
          padding: const EdgeInsets.only(right: 10.0, left: 10.0, bottom: 10),
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(
                  color:
                      isSelected ? Colors.white : Colors.black.withOpacity(1),
                  width: 3),
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              shape: BoxShape.rectangle,
            ),
            child: GestureDetector(
              onTap: () => imgCons.selectedIndex = widget.index,
              child: MouseRegion(
                onEnter: _enlight,
                onExit: _darken,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 100),
                  opacity: _globalOpacity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: imgCons.miniature(widget.index),
                  ),
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
}

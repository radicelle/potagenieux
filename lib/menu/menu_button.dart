import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../globals.dart' as globals;

class MenuButton extends StatefulWidget {
  final String text;
  final double height;
  final double width;

  const MenuButton({
    required this.text,
    required this.height,
    required this.width,
    Key? key,
  }) : super(key: key);

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  late double itemOpacity;

  @override
  void initState() {
    itemOpacity = globals.defaultOpacity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: _tapMenuItem,
      child: MouseRegion(
        onEnter: _enterMenuItem,
        onExit: _exitMenuItem,
        child: Opacity(
          opacity: itemOpacity,
          child: SizedBox(
            height: widget.height,
            width: widget.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_right,
                  color: globals.menuColor,
                ),
                Text(
                  widget.text,
                  style: globals.menuTextStyle(context),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _tapMenuItem() {
    setState(() {
      itemOpacity = 1;
    });
  }

  void _enterMenuItem(PointerEnterEvent event) {
    setState(() {
      itemOpacity = 1;
    });
  }

  void _exitMenuItem(PointerExitEvent event) {
    setState(() {
      itemOpacity = globals.defaultOpacity;
    });
  }
}

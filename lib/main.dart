import 'package:flutter/material.dart';
import 'package:flutter/src/gestures/events.dart';
import 'package:potagenieux/main_image_change_notifier.dart';
import 'package:provider/provider.dart';

import 'globals.dart' as globals;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      title: 'Potagenieux',
      builder: (context, _) => const MyHomePage(),
      color: Colors.white70,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var panelHeight = MediaQuery.of(context).size.height;
    var rightContainerHeight = panelHeight * 5 / 6;
    var panelWidth = MediaQuery.of(context).size.width;
    var rightContainerWidth = panelWidth * 4 / 5;
    var menuWidth = panelWidth - rightContainerWidth;
    const menuPadding = 1.0;
    var finalMenuWidth = menuWidth - menuPadding;
    var miniImagesHeight = rightContainerHeight / 4;
    return Stack(
      children: [
        Positioned(
          child: Container(
            color: const Color(0xff7b8c3b),
            width: finalMenuWidth,
            height: panelHeight,
          ),
          top: 0,
          left: 0,
        ),
        Positioned(
          child: SizedBox(
            width: menuWidth,
            height: panelHeight - rightContainerHeight,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Potagenieux",
                style: globals.headerTextStyle(context),
              ),
            ),
          ),
          top: 0,
          left: 0,
        ),
        Positioned(
          child: Column(
            children: [
              MenuButton(
                height: panelHeight / 10,
                width: finalMenuWidth,
                text: "HOME",
              ),
              MenuButton(
                height: panelHeight / 10,
                width: finalMenuWidth,
                text: "PRODUITS",
              ),
              MenuButton(
                height: panelHeight / 10,
                text: "FORMATIONS",
                width: finalMenuWidth,
              ),
              MenuButton(
                height: panelHeight / 10,
                text: "CONTACT",
                width: finalMenuWidth,
              ),
            ],
          ),
          left: 0,
          top: panelHeight / 3,
        ),
        Positioned(
          top: 0,
          right: 0,
          left: menuWidth,
          bottom: panelHeight - rightContainerHeight,
          child: ListView(
            children: [
              ChangeNotifierProvider(
                create: (_) => MainImageChangeNotifier.fromIndex(0),
                child: Stack(children: [
                  Positioned(
                    child: Consumer<MainImageChangeNotifier>(
                      builder: (_, imgCons, __) {
                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 100),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) =>
                                  FadeTransition(
                            opacity: animation,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: SizedBox(
                                  width: rightContainerWidth,
                                  height: rightContainerHeight,
                                  child: child),
                            ),
                          ),
                          child: imgCons.image,
                        );
                      },
                    ),
                  ),
                  Positioned(
                      top: rightContainerHeight - miniImagesHeight,
                      right: 0,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxHeight: miniImagesHeight,
                            minWidth: rightContainerWidth),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [/*...globals.miniImages*/],
                        ),
                      ))
                ]),
              ),
              Container(
                width: rightContainerWidth,
                height: rightContainerHeight,
              )
            ],
            itemExtent: rightContainerHeight,
          ),
        ),
      ],
    );
  }
}

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

import 'package:flutter/material.dart';

import 'home_list_view.dart';
import 'menu/menu_background.dart';
import 'menu/menu_header.dart';
import 'menu/menu_items.dart';

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
    var panelWidth = MediaQuery.of(context).size.width;
    var menuWidth = 250.0;
    var rightContainerWidth = panelWidth - menuWidth;
    const menuPadding = 1.0;
    var finalMenuWidth = menuWidth - menuPadding;
    var rightContainerHeight = panelHeight * 5 / 6;
    var miniImagesHeight = rightContainerHeight / 8;
    return Stack(
      children: [
        Positioned(
          child: MenuBackground(
              finalMenuWidth: finalMenuWidth, panelHeight: panelHeight),
          top: 0,
          left: 0,
        ),
        Positioned(
          child: MenuHeader(
              menuWidth: menuWidth,
              panelHeight: panelHeight,
              rightContainerHeight: rightContainerHeight),
          top: 0,
          left: 0,
        ),
        Positioned(
          child: MenuItems(
              panelHeight: panelHeight, finalMenuWidth: finalMenuWidth),
          left: 0,
          top: panelHeight / 3,
        ),
        Positioned(
          top: 0,
          right: 0,
          left: menuWidth,
          bottom: panelHeight - rightContainerHeight,
          child: HomeListView(
              width: rightContainerWidth,
              height: rightContainerHeight,
              miniImagesHeight: miniImagesHeight),
        ),
      ],
    );
  }
}

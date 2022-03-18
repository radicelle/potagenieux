import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:potagenieux/providers/login_provider.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'globals.dart' as globals;
import 'vue/menu/login/fire_loggin.dart';
import 'vue/menu/menu_items.dart';
import 'vue/panels/home/home_list_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAuth.instance.signInAnonymously();
  if (kDebugMode) {
    FirebaseFunctions.instance.useFunctionsEmulator('localhost', 5000);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Potagenieux',
        builder: (context, _) => Navigator(
              onGenerateRoute: (_) => MaterialPageRoute(builder: (context) {
                return Scaffold(
                    backgroundColor: const Color(globals.menuBackgroundColor),
                    appBar: AppBar(
                      backgroundColor: Colors.white70,
                      toolbarHeight: globals.appBarHeight,
                      title: const Text(
                        'Potagenieux',
                        style: TextStyle(
                            color: Color(globals.menuBackgroundColor)),
                      ),
                    ),
                    body: const MyHomePage());
              }),
            ),
        theme: ThemeData(
            buttonTheme: Theme.of(context).buttonTheme.copyWith(
                  highlightColor: globals.materialMenuBackgroundColor,
                ),
            primarySwatch: globals.materialMenuBackgroundColor,
            textTheme: globals.bodyTextTheme(context),
            visualDensity: VisualDensity.adaptivePlatformDensity));
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
    return SafeArea(
      child: ChangeNotifierProvider(
        create: (BuildContext context) => LoginProvider(),
        child: Consumer<LoginProvider>(builder: (_, loginProvider, __) {
          var panelHeight = MediaQuery.of(context).size.height;
          var panelWidth = MediaQuery.of(context).size.width;
          var menuWidth = loginProvider.menuWidth;
          var rightContainerWidth = panelWidth - menuWidth;
          const menuPadding = 1.0;
          var finalMenuWidth = menuWidth - menuPadding;
          var rightContainerHeight = panelHeight * 5 / 6;
          //var headerHeight = panelHeight / 7;
          var miniImagesHeight = rightContainerHeight / 8;
          var menuItemStart = loginProvider.menuItemsStart(panelHeight);
          return Stack(
            children: [
              Positioned(
                child: FireLogin(
                  width: menuWidth,
                  height: menuItemStart, // - headerHeight,
                ),
                top: 10, //headerHeight,
              ),
              Positioned(
                child: MenuItems(
                    panelHeight: panelHeight, finalMenuWidth: finalMenuWidth),
                left: 0,
                top: menuItemStart,
              ),
              Positioned(
                top: 0,
                right: 0,
                left: menuWidth,
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: HomeListView(
                      width: rightContainerWidth,
                      height: rightContainerHeight,
                      miniImagesHeight: miniImagesHeight),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

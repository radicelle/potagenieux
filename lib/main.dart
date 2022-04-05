import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:potagenieux/providers/image_panel_change_notifier.dart';
import 'package:potagenieux/providers/login_provider.dart';
import 'package:potagenieux/vue/panels/home/feedback_section.dart';
import 'package:potagenieux/vue/panels/home/home_list_view_texts.dart';
import 'package:potagenieux/vue/panels/home/image_switcher.dart';
import 'package:potagenieux/vue/panels/home/info_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import 'firebase_options.dart';
import 'globals.dart' as globals;

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
    return PlatformApp(
      material: (_, __) => MaterialAppData(
          theme: ThemeData(
              buttonTheme: Theme.of(context).buttonTheme.copyWith(
                    highlightColor: globals.materialMenuBackgroundColor,
                  ),
              primarySwatch: globals.materialMenuBackgroundColor,
              textTheme: globals.bodyTextTheme(context),
              visualDensity: VisualDensity.adaptivePlatformDensity)),
      cupertino: (_, __) => CupertinoAppData(
          theme:
              const CupertinoThemeData(primaryColor: globals.backgroundColor)),
      title: 'Potagenieux',
      home: PlatformScaffold(
          backgroundColor: const Color(globals.menuBackgroundColor),
          appBar: PlatformAppBar(
            title: PlatformText(
              'Potagenieux',
              style: const TextStyle(color: Color(globals.menuBackgroundColor)),
            ),
          ),
          body: const MyHomePage()),
      debugShowCheckedModeBanner: false,
      builder: (context, widget) {
        return ResponsiveWrapper.builder(
          ClampingScrollWrapper.builder(context, widget!),
          maxWidth: 1800,
          minWidth: 480,
          backgroundColor: globals.backgroundColor,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(350, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(600,
                name: globals.largeMobile),
            const ResponsiveBreakpoint.resize(800, name: TABLET),
            const ResponsiveBreakpoint.autoScale(1000,
                name: globals.smallDesktop),
            const ResponsiveBreakpoint.resize(1700, name: DESKTOP),
          ],
        );
      },
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
  late AnimationController _sheetController;

  @override
  void initState() {
    super.initState();
    _sheetController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ChangeNotifierProvider(
        create: (BuildContext context) => ImagePanelChangeNotifier.fromIndex(0),
        child: ChangeNotifierProvider(
          create: (BuildContext context) => LoginProvider(),
          child: Consumer<LoginProvider>(builder: (_, loginProvider, __) {
            var itemExtent = 0.8 * MediaQuery.of(context).size.height;
            return ListView(
              itemExtent: itemExtent,
              children: [
                const ImageSwitcher(),
                HomeListViewTexts(height: itemExtent),
                FeedbackSection(height: itemExtent),
                InfoBottomSheet(
                    sheetController: _sheetController,
                    height: MediaQuery.of(context).size.height / 20)
              ],
            );
          }),
        ),
      ),
    );
  }
}

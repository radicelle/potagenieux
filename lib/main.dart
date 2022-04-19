import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:potagenieux/providers/gdpr_provider.dart';
import 'package:potagenieux/providers/image_panel_change_notifier.dart';
import 'package:potagenieux/providers/login_provider.dart';
import 'package:potagenieux/vue/menu/login/fire_loggin.dart';
import 'package:potagenieux/vue/panels/home/home_list_view.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

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
          maxWidth: 1920,
          minWidth: 480,
          backgroundColor: globals.backgroundColor,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(350, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(600,
                name: globals.largeMobile),
            const ResponsiveBreakpoint.resize(800, name: TABLET),
            const ResponsiveBreakpoint.resize(1250, name: globals.smallDesktop),
            const ResponsiveBreakpoint.autoScale(1700, name: DESKTOP),
          ],
        );
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) => ImagePanelChangeNotifier.fromIndex(0)),
          ChangeNotifierProvider(create: (_) => LoginProvider()),
          ChangeNotifierProvider(create: (_) => GDPRProvider()),
        ],
        child: Consumer<LoginProvider>(builder: (_, loginProvider, __) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ResponsiveVisibility(
                visible: ResponsiveWrapper.of(context)
                    .isLargerThan(globals.largeMobile),
                child: Flexible(
                  flex: loginProvider.needsLargeMenu() ? 4 : 2,
                  child: LayoutBuilder(builder: (context, constraints) {
                    return SizedBox(
                        width: constraints.maxWidth,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const FireLogin(),
                        ));
                  }),
                ),
              ),
              const Flexible(
                flex: 10,
                child: HomeListView(),
              ),
            ],
          );
        }),
      ),
    );
  }
}

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:potagenieux/menu_items.dart';
import 'package:potagenieux/products_list_view.dart';
import 'package:potagenieux/providers/gdpr_provider.dart';
import 'package:potagenieux/providers/illuminable.dart';
import 'package:potagenieux/providers/image_panel_change_notifier.dart';
import 'package:potagenieux/providers/login_provider.dart';
import 'package:potagenieux/providers/menu_item_provider.dart';
import 'package:potagenieux/providers/products_provider.dart';
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
  FirebaseAuth.instance.signInAnonymously();
  if (kDebugMode) {
    FirebaseFunctions.instance.useFunctionsEmulator('localhost', 5000);
  }
  runApp(const Potagenieux());
}

class Potagenieux extends StatelessWidget {
  const Potagenieux({Key? key}) : super(key: key);

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
      home: ChangeNotifierProvider(
        create: (_) => LoginProvider(),
        child: Consumer<LoginProvider>(builder: (context, loginProvider, __) {
          return Scaffold(
            drawer: globals.displayDrawer(context)
                ? const NavigationDrawer()
                : null,
            backgroundColor: const Color(globals.menuBackgroundColor),
            appBar: AppBar(
              title: PlatformText(
                'Potagenieux',
                style:
                    const TextStyle(color: Color(globals.menuBackgroundColor)),
              ),
            ),
            body: const MyHomePage(),
          );
        }),
      ),
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

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        backgroundColor: const Color(globals.menuBackgroundColor),
        child: LayoutBuilder(builder: (context, constraints) {
          return Column(
            children: [
              Flexible(
                flex: 1,
                child: DrawerHeader(
                  child: Text(
                    "Menu",
                    style: globals.menuTextStyle(context),
                  ),
                ),
              ),
              const Flexible(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: FireLogin(),
                  ))
            ],
          );
        }),
      );
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
          ChangeNotifierProvider(create: (_) => GDPRProvider()),
          ChangeNotifierProvider(create: (_) => Illuminable()),
          ChangeNotifierProvider(create: (_) => MenuItemProvider()),
          ChangeNotifierProvider(create: (_) => ProductsProvider()),
        ],
        child: Consumer<LoginProvider>(builder: (_, loginProvider, __) {
          return Consumer<MenuItemProvider>(builder: (_, menuItemProvider, __) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ResponsiveVisibility(
                  visible: globals.displayMenu(context),
                  child: Flexible(
                    flex: loginProvider.needsLargeMenu() ? 4 : 3,
                    child: MenuItems(itemsProvider: menuItemProvider),
                  ),
                ),
                if (menuItemProvider.selectedItem == ShadingItem.home)
                  const Flexible(
                    flex: 10,
                    child: HomeListView(),
                  )
                else if (menuItemProvider.selectedItem == ShadingItem.products)
                  Consumer<ProductsProvider>(builder: (_, productProvider, __) {
                    return Flexible(
                      flex: 10,
                      child:
                          ProductsListView(productsProvider: productProvider),
                    );
                  }),
              ],
            );
          });
        }),
      ),
    );
  }
}

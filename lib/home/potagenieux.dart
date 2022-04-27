import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:potagenieux/globals.dart' as globals;
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_value.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

import '../blog_list_view.dart';
import '../custom_nav_bar.dart';
import '../products_list_view.dart';
import '../providers/article_provider.dart';
import '../providers/gdpr_provider.dart';
import '../providers/illuminable.dart';
import '../providers/image_panel_change_notifier.dart';
import '../providers/login_provider.dart';
import '../providers/menu_item_provider.dart';
import '../providers/news_provider.dart';
import '../providers/products_provider.dart';
import '../vue/menu/login/fire_login.dart';
import '../vue/menu/menu_info.dart';
import '../vue/menu/menu_items.dart';
import '../vue/menu/news_list_view.dart';
import '../vue/panels/home/home_list_view.dart';

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
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LoginProvider()),
          ChangeNotifierProvider(create: (_) => MenuItemProvider()),
        ],
        child: Consumer<LoginProvider>(builder: (context, loginProvider, __) {
          return Scaffold(
            bottomNavigationBar:
                globals.displayDrawer(context) ? const CustomNavBar() : null,
            drawer: globals.displayDrawer(context)
                ? const NavigationDrawer()
                : null,
            backgroundColor: const Color(globals.menuBackgroundHexa),
            appBar: AppBar(
              title: PlatformText(
                'Potagenieux',
                style:
                    const TextStyle(color: Color(globals.menuBackgroundHexa)),
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
        backgroundColor: const Color(globals.menuBackgroundHexa),
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
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: FireLogin(),
                ),
              ),
              const Flexible(flex: 3, child: MenuInfo())
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
          ChangeNotifierProvider(create: (_) => ProductsProvider()),
          ChangeNotifierProvider(create: (_) => NewsProvider()),
          ChangeNotifierProvider(create: (_) => ArticleProvider()),
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
                  const Flexible(flex: 10, child: HomeListView())
                else if (menuItemProvider.selectedItem == ShadingItem.products)
                  const Flexible(flex: 10, child: ProductsListView())
                else if (menuItemProvider.selectedItem == ShadingItem.news)
                  const Flexible(flex: 10, child: NewsListView())
                else if (menuItemProvider.selectedItem == ShadingItem.blog)
                  const Flexible(flex: 10, child: BlogListView())
              ],
            );
          });
        }),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ProductFormPageRoute extends StatefulWidget {
  const ProductFormPageRoute({Key? key}) : super(key: key);

  @override
  _ProductFormPageRouteState createState() => _ProductFormPageRouteState();
}

class _ProductFormPageRouteState extends State<ProductFormPageRoute> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        WidgetBuilder builder = (BuildContext _) => Container(
              color: Colors.red,
              height: 500,
              width: 500,
            );

        return MaterialPageRoute<void>(builder: builder, settings: settings);
      },
    );
  }
}

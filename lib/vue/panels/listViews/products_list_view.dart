import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:potagenieux/providers/products_provider.dart';
import 'package:potagenieux/vue/panels/listViews/product_tile.dart';
import 'package:provider/provider.dart';

import '../../../globals.dart' as globals;

class ProductsListView extends StatelessWidget {
  const ProductsListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductsProvider>(builder: (_, productsProvider, __) {
      return LayoutBuilder(builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Stack(
            children: [
              Positioned(
                child: ListView.separated(
                  separatorBuilder: (context, index) => const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Divider(),
                  ),
                  itemCount: productsProvider.nbProducts,
                  itemBuilder: (buildContext, index) {
                    var glassEffectContainerWidth = constraints.maxWidth /
                        (globals.displayMenu(context)
                            ? constraints.maxWidth / constraints.maxHeight
                            : 1.1);
                    var glassEffectContainerHeight =
                        glassEffectContainerWidth / 1.25;
                    return ProductTile(
                        inStock: globals.productsList[index].inStock,
                        desc: globals.productsList[index].desc,
                        firebaseImage: productsProvider.productImage(index),
                        height: glassEffectContainerHeight,
                        width: glassEffectContainerWidth);
                  },
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: PlatformElevatedButton(
                    onPressed: () => Navigator.of(context)
                        .pushNamed(globals.productFormRoute),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white70,
                      size: 40,
                    ),
                    material: (_, __) => MaterialElevatedButtonData(
                        style: ButtonStyle(
                            shape:
                                MaterialStateProperty.all(const CircleBorder()),
                            backgroundColor: MaterialStateProperty.all(
                                globals.backgroundColor))),
                  ),
                ),
              )
            ],
          ),
        );
      });
    });
  }
}

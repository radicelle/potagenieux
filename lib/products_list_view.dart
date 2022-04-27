import 'package:flutter/material.dart';
import 'package:potagenieux/providers/products_provider.dart';
import 'package:provider/provider.dart';

import 'globals.dart' as globals;

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
          child: ListView.separated(
            separatorBuilder: (context, index) => const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(),
            ),
            itemCount: productsProvider.nbProducts,
            itemBuilder: (buildContext, index) {
              var glassEffectContainerWidth = constraints.maxWidth /
                  (globals.displayMenu(context) ? 1.8 : 1.1);
              return Center(
                child: GlassContainer(
                  height: constraints.maxHeight / 1.25,
                  width: glassEffectContainerWidth,
                  content: Column(
                    children: [
                      const Spacer(
                        flex: 1,
                      ),
                      Flexible(
                          flex: 10,
                          child: SizedBox(
                              width: glassEffectContainerWidth * 0.95,
                              child: productsProvider.productImage(index))),
                      Flexible(
                        flex: 3,
                        child: SizedBox(
                          width: glassEffectContainerWidth * 0.95,
                          child: Row(
                            children: [
                              Text(
                                globals.productsList[index].desc,
                                style: globals.bodyTextStyle(context),
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  const Text("Stock: "),
                                  globals.productsList[index].inStock
                                      ? Icon(
                                          Icons.check_box,
                                          color: Colors.green.shade700,
                                        )
                                      : Icon(
                                          Icons.close,
                                          color: Colors.red.shade900,
                                        )
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      });
    });
  }
}

class GlassContainer extends StatelessWidget {
  const GlassContainer({
    Key? key,
    required this.content,
    required this.width,
    required this.height,
  }) : super(key: key);
  final Widget content;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 25,
                  spreadRadius: -5),
            ],
            gradient: const LinearGradient(
                colors: [Colors.white60, Colors.white10],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(width: 2, color: Colors.white30)),
        child: content);
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:potagenieux/providers/products_provider.dart';

import 'globals.dart' as globals;

class ProductsListView extends StatelessWidget {
  const ProductsListView({
    required this.productsProvider,
    Key? key,
  }) : super(key: key);

  final ProductsProvider productsProvider;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return ListView.builder(
        itemExtent: constraints.maxHeight / 2,
        itemCount: productsProvider.nbProducts,
        itemBuilder: (buildContext, index) => Center(
          child: SizedBox(
            width:
                constraints.maxWidth / (globals.displayMenu(context) ? 2 : 1.1),
            child: Column(
              children: [
                Flexible(
                    flex: 3,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: productsProvider.productImage(index))),
                Flexible(
                  flex: 1,
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
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

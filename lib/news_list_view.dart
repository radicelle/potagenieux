import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:potagenieux/providers/news_provider.dart';

import 'globals.dart' as globals;

class NewsListView extends StatelessWidget {
  const NewsListView({
    required this.newsProvider,
    Key? key,
  }) : super(key: key);

  final NewsProvider newsProvider;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return ListView.builder(
        itemExtent: constraints.maxHeight / 2,
        itemCount: newsProvider.nbNews,
        itemBuilder: (buildContext, index) => SizedBox(
          width:
              constraints.maxWidth / (globals.displayMenu(context) ? 2 : 1.1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: SizedBox(
                      width: constraints.maxWidth /
                          (globals.displayDrawer(context) ? 3 : 6),
                      child: newsProvider.newsImage(index))),
              const Spacer(flex: 1),
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: SizedBox(),
                    ),
                    Text(
                      "${DateFormat.yMMMd('fr_FR').format(globals.newsList[index].date)} :",
                      maxLines: 6,
                      style: globals.newsHeaderTextStyle(context),
                    ),
                    Text(
                      globals.newsList[index].desc,
                      maxLines: 6,
                      style: globals.bodyTextStyle(context),
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}

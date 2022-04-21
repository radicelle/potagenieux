import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:potagenieux/providers/article_provider.dart';

import 'globals.dart' as globals;

class BlogListView extends StatelessWidget {
  const BlogListView({
    required this.articleProvider,
    Key? key,
  }) : super(key: key);

  final ArticleProvider articleProvider;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return ListView.builder(
        itemExtent: constraints.maxHeight *
            (globals.displayDrawer(context) ? 0.9 : 1.2),
        itemCount: articleProvider.nbArticles,
        itemBuilder: (buildContext, index) => Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          globals.blogList[index].title,
                          style: globals.newsHeaderTextStyle(context),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          DateFormat.yMMMd('fr_FR')
                              .format(globals.blogList[index].date),
                          maxLines: 6,
                          style: globals.newsHeaderTextStyle(context),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),
                ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Center(
                        child: ConstrainedBox(
                            constraints: BoxConstraints(
                                maxHeight: constraints.maxHeight * 0.8),
                            child: articleProvider.articleImage(index)))),
                const Expanded(
                  child: SizedBox(),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    globals.blogList[index].desc,
                    maxLines: 10,
                    style: globals.bodyTextStyle(context),
                  ),
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                Divider(
                  color: globals.menuColor,
                  thickness: 3,
                  indent: constraints.maxWidth / 10,
                  endIndent: constraints.maxWidth / 10,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:potagenieux/providers/article_provider.dart';
import 'package:provider/provider.dart';

import '../../../globals.dart' as globals;

class BlogListView extends StatelessWidget {
  const BlogListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleProvider>(builder: (_, articleProvider, __) {
      return LayoutBuilder(builder: (_, constraints) {
        var size = MediaQuery.of(context).size;
        var pixelRatio = size.height / size.width;
        return ListView.builder(
          itemExtent: constraints.maxHeight * (pixelRatio < 1.20 ? 0.8 : 0.9),
          itemCount: articleProvider.nbArticles,
          itemBuilder: (buildContext, index) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                child: ConstrainedBox(
                    constraints:
                        BoxConstraints(maxHeight: constraints.maxHeight * 0.4),
                    child: articleProvider.articleImage(index)),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: constraints.maxHeight / 20,
                    bottom: constraints.maxHeight / 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    globals.blogList[index].desc,
                    maxLines: 10,
                    style: globals.bodyTextStyle(context),
                  ),
                ),
              ),
              Divider(
                color: globals.menuColor,
                thickness: 3,
                indent: constraints.maxWidth / 10,
                endIndent: constraints.maxWidth / 10,
              ),
            ],
          ),
        );
      });
    });
  }
}

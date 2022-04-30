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
        var articles = globals.blogList.map(
          (article) => [
            Padding(
              padding: EdgeInsets.only(
                  left: constraints.maxWidth / 10,
                  right: constraints.maxWidth / 10,
                  top: constraints.maxHeight / 10,
                  bottom: constraints.maxHeight / 20),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      article.title,
                      style: globals.newsHeaderTextStyle(context),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      DateFormat.yMMMd('fr_FR').format(article.date),
                      maxLines: 6,
                      style: globals.newsHeaderTextStyle(context),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: constraints.maxWidth / 10,
                  right: constraints.maxWidth / 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: ConstrainedBox(
                    constraints:
                        BoxConstraints(maxHeight: constraints.maxHeight * 0.4),
                    child: articleProvider.articleImage(article.name)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: constraints.maxWidth / 10,
                  right: constraints.maxWidth / 10,
                  top: constraints.maxHeight / 10,
                  bottom: constraints.maxHeight / 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  article.desc,
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
        );

        return SizedBox(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [...articles.flatten()],
            ),
          ),
        );
      });
    });
  }
}

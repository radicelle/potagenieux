import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

class FutureTermsMarkdown extends StatelessWidget {
  const FutureTermsMarkdown({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: FutureBuilder(
          future: DefaultAssetBundle.of(context).loadString("terms/TERMS.md"),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              var horizontalPadding = 0.1 * constraints.maxWidth;
              var verticalPadding = 0.1 * constraints.maxHeight;
              return Markdown(
                  padding: EdgeInsets.only(
                      left: horizontalPadding,
                      right: horizontalPadding,
                      top: verticalPadding,
                      bottom: verticalPadding),
                  data: snapshot.data ?? "",
                  styleSheet: MarkdownStyleSheet(
                      h1Align: WrapAlignment.center,
                      h2Padding:
                          EdgeInsets.only(top: constraints.maxHeight / 15),
                      textAlign: WrapAlignment.spaceBetween,
                      textScaleFactor: 1.2),
                  extensionSet: md.ExtensionSet(
                    md.ExtensionSet.gitHubFlavored.blockSyntaxes,
                    [
                      md.EmojiSyntax(),
                      ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes
                    ],
                  ));
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      );
    });
  }
}

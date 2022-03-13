import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/login_provider.dart';
import 'connection_button.dart';
import 'email_text_field.dart';

class FireLogin extends StatefulWidget {
  const FireLogin({required this.width, required this.height, Key? key})
      : super(key: key);

  final double width;
  final double height;

  @override
  _FireLoginState createState() => _FireLoginState();
}

class _FireLoginState extends State<FireLogin> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: widget.width,
        maxHeight: widget.height,
      ),
      child: Consumer<LoginProvider>(builder: (_, loginProvider, __) {
        return MouseRegion(
          onEnter: (event) => loginProvider.illuminate(event, Item.connection),
          onExit: (event) => loginProvider.shade(event, Item.connection),
          child: AnimatedSwitcher(
            layoutBuilder: fadeOverLayoutBuilder,
            duration: const Duration(milliseconds: 600),
            child: (() {
              if (loginProvider.state == LoginState.disconnected) {
                return ConnectionButton(
                  loginProvider: loginProvider,
                  width: widget.width,
                  height: widget.height,
                );
              } else if (loginProvider.state == LoginState.email) {
                return EmailTextField(
                  loginProvider: loginProvider,
                  callback: (email) => loginProvider.verifyEmail(email,
                      (e) => _showErrorDialog(context, 'Invalid email', e)),
                  width: widget.width,
                  height: widget.height,
                );
              } else if (loginProvider.state == LoginState.register) {
                return Container(
                  color: Colors.red,
                );
              }
            }()),
          ),
        );
      }),
    );
  }

  static Widget fadeOverLayoutBuilder(
      Widget? currentChild, List<Widget> previousChildren) {
    return Stack(
      children: <Widget>[
        ...previousChildren.map((w) => Positioned(
              child: w,
              top: 0,
              left: 0,
            )),
        if (currentChild != null) currentChild,
      ],
    );
  }

  void _showErrorDialog(BuildContext context, String title, Exception e) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(fontSize: 24),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  '${(e as dynamic).message}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.deepPurple),
              ),
            ),
          ],
        );
      },
    );
  }
}

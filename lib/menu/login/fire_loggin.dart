import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/login_provider.dart';
import 'connection_button.dart';

class FireLogin extends StatefulWidget {
  const FireLogin({required this.width, required this.height, Key? key})
      : super(key: key);

  final double width;
  final double height;

  @override
  _FireLoginState createState() => _FireLoginState();
}

class _FireLoginState extends State<FireLogin>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: widget.width,
        maxHeight: widget.height,
      ),
      child: ChangeNotifierProvider(
        create: (BuildContext context) => LoginProvider(),
        child: Consumer<LoginProvider>(builder: (_, loginProvider, __) {
          return MouseRegion(
            onEnter: (event) =>
                loginProvider.illuminate(event, Item.connection),
            onExit: (event) => loginProvider.shade(event, Item.connection),
            child: GestureDetector(
              onTap: () => loginProvider.state = LoginState.logging,
              child: ConnectionButton(
                loginProvider: loginProvider,
              ),
            ),
          );
        }),
      ),
    );
  }
}

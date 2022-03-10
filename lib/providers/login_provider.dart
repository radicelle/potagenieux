import 'package:flutter/cupertino.dart';
import 'package:potagenieux/globals.dart' as globals;
import 'package:potagenieux/providers/enlightable.dart';

class LoginProvider extends ChangeNotifier implements Illuminable<Item> {
  ///map of possible states
  late Map<Item, double> _opacities;
  late LoginState state;

  LoginProvider() {
    _opacities = {for (var i in Item.values) i: globals.defaultOpacity};
    state = LoginState.disconnected;
  }

  double opacity(Item item) => _opacities[item]!;

  @override
  void illuminate(event, Item? item) {
    _opacities[item!] = 1;
    notifyListeners();
  }

  @override
  void shade(event, Item? item) {
    _opacities[item!] = globals.defaultOpacity;
    notifyListeners();
  }
}

/// Items that can be illuminated by hoover
enum Item { connection, connect }

/// Possible states when login
enum LoginState { disconnected, connecting, logging, registering }

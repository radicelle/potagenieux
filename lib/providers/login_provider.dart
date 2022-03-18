import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:potagenieux/globals.dart' as globals;
import 'package:potagenieux/providers/enlightable.dart';

class LoginProvider extends ChangeNotifier implements Illuminable<Item> {
  ///map of possible states
  late Map<Item, double> _opacities;
  late LoginState _state;
  String? _email;

  LoginProvider() {
    init();
    _opacities = {for (var i in Item.values) i: globals.defaultOpacity};
    _state = LoginState.disconnected;
  }

  double get menuWidth {
    if (_state == LoginState.disconnected || _state == LoginState.connected) {
      return 200;
    } else {
      return 500;
    }
  }

  double menuItemsStart(double panelHeight) {
    if (_state == LoginState.register) {
      return panelHeight / 3;
    } else {
      return panelHeight / 5;
    }
  }

  double opacity(Item item) => _opacities[item]!;
  LoginState get state => _state;
  String? get email => _email;

  set state(LoginState state) {
    _state = state;
    notifyListeners();
  }

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

  Future<void> init() async {
    await Firebase.initializeApp();
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user == null || user.isAnonymous == false) {
        _state = LoginState.connected;
      } else {
        _state = LoginState.disconnected;
      }
      notifyListeners();
    });
  }

  void startLoginFlow() {
    _state = LoginState.email;
    notifyListeners();
  }

  Future<void> verifyEmail(
    String email,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    try {
      var methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (methods.contains('password')) {
        _state = LoginState.password;
      } else {
        _state = LoginState.register;
      }
      _email = email;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void cancelRegistration() {
    _state = LoginState.disconnected;
    notifyListeners();
  }

  Future<void> registerAccount(
      String email,
      String lastname,
      String firstname,
      String password,
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user!.updateDisplayName("$firstname $lastname");
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  returnToEmail() {
    _state = LoginState.email;
    notifyListeners();
  }
}

/// Items that can be illuminated by hoover
enum Item { connection, connect }

/// Possible states when login
enum LoginState {
  disconnected,
  connected,
  email,
  password,
  connecting,
  register
}

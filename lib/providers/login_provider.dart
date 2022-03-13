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
    if (_state == LoginState.disconnected ||
        _state == LoginState.disconnected) {
      return 300;
    } else {
      return 500;
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
      if (user != null) {
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
      print(methods);
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
      String displayName,
      String password,
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user!.updateDisplayName(displayName);
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:potagenieux/providers/illuminable.dart';

class LoginProvider extends Illuminable {
  ///map of possible states
  late LoginState _state;
  String? _email;

  LoginProvider() {
    init();
    _state = LoginState.disconnected;
  }

  double get menuWidth {
    if (_state == LoginState.disconnected || _state == LoginState.connected) {
      return 200;
    } else {
      return 500;
    }
  }

  LoginState get state => _state;
  String? get email => _email;

  set state(LoginState state) {
    _state = state;
    notifyListeners();
  }

  Future<void> init() async {
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

  bool isConnected() => _state == LoginState.connected;

  bool needsLargeMenu() {
    return _state == LoginState.email ||
        _state == LoginState.password ||
        _state == LoginState.register;
  }
}

/// Possible states when login
enum LoginState {
  disconnected,
  connected,
  email,
  password,
  connecting,
  register
}

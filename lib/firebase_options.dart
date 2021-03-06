// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyChrC3jddhYjoqRLpXUcgdlooI3DlAZBRE',
    appId: '1:917904956605:web:ffd769069713120d13abd4',
    messagingSenderId: '917904956605',
    projectId: 'potagenieux',
    authDomain: 'potagenieux.firebaseapp.com',
    storageBucket: 'potagenieux.appspot.com',
    measurementId: 'G-QNCVGC9HX3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCKUVbWFkk90qPzmBV8f1tHgzbbsTH0Gi8',
    appId: '1:917904956605:android:cada83b9e54be80d13abd4',
    messagingSenderId: '917904956605',
    projectId: 'potagenieux',
    storageBucket: 'potagenieux.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDy0HjP7fiGPzPpKQs78WxJWIeBOsEwDV4',
    appId: '1:917904956605:ios:5d1f9736802878ce13abd4',
    messagingSenderId: '917904956605',
    projectId: 'potagenieux',
    storageBucket: 'potagenieux.appspot.com',
    iosClientId: '917904956605-dhjpls1kob0v6auuq7shnetsea2st28m.apps.googleusercontent.com',
    iosBundleId: 'fr.potagenieux.app',
  );
}

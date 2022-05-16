import 'package:camera/camera.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'firebase_options.dart';
import 'home/potagenieux.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initializeDateFormatting('fr_FR', null);

  FirebaseAuth.instance.signInAnonymously();
  if (kDebugMode) {
    FirebaseFunctions.instance.useFunctionsEmulator('localhost', 5000);
  }
  runApp(Potagenieux(cameras));
}

// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBbCZWwDHocs8ndj_VL4_sRR-vm4eVpR6A',
    appId: '1:491062115443:web:e6210734fc20658ea3be06',
    messagingSenderId: '491062115443',
    projectId: 'flutterbackend-ce236',
    authDomain: 'flutterbackend-ce236.firebaseapp.com',
    storageBucket: 'flutterbackend-ce236.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCfrFoZ6FKdw6VbyrI-2jHvWKchL6umExE',
    appId: '1:491062115443:android:612e19e702345bbfa3be06',
    messagingSenderId: '491062115443',
    projectId: 'flutterbackend-ce236',
    storageBucket: 'flutterbackend-ce236.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCW8vVcl4tBuwxCzI5rmAgjklNsMcZOEeM',
    appId: '1:491062115443:ios:bacc188399550fd5a3be06',
    messagingSenderId: '491062115443',
    projectId: 'flutterbackend-ce236',
    storageBucket: 'flutterbackend-ce236.firebasestorage.app',
    iosBundleId: 'com.example.firebaseapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCW8vVcl4tBuwxCzI5rmAgjklNsMcZOEeM',
    appId: '1:491062115443:ios:bacc188399550fd5a3be06',
    messagingSenderId: '491062115443',
    projectId: 'flutterbackend-ce236',
    storageBucket: 'flutterbackend-ce236.firebasestorage.app',
    iosBundleId: 'com.example.firebaseapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBbCZWwDHocs8ndj_VL4_sRR-vm4eVpR6A',
    appId: '1:491062115443:web:556634ec02699485a3be06',
    messagingSenderId: '491062115443',
    projectId: 'flutterbackend-ce236',
    authDomain: 'flutterbackend-ce236.firebaseapp.com',
    storageBucket: 'flutterbackend-ce236.firebasestorage.app',
  );
}

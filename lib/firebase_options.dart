// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBxlHO-Y8Q6eidOyHUMVUgu06SiQKeuVcg',
    appId: '1:1045101896672:web:72dd6f7c99732357d40185',
    messagingSenderId: '1045101896672',
    projectId: 'gforce-42b39',
    authDomain: 'gforce-42b39.firebaseapp.com',
    storageBucket: 'gforce-42b39.appspot.com',
    databaseURL: 'https://gforce-42b39-default-rtdb.firebaseio.com/',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB-oxqK6V5F0dTbUgwi5niAjs63CjT9s64',
    appId: '1:1045101896672:android:966b973d6a887fe3d40185',
    messagingSenderId: '1045101896672',
    projectId: 'gforce-42b39',
    storageBucket: 'gforce-42b39.appspot.com',
    databaseURL: 'https://gforce-42b39-default-rtdb.firebaseio.com/',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA2NKgunAKriYgzkj62OoEanoDL8Den-6g',
    appId: '1:1045101896672:ios:7081eafb5a808a57d40185',
    messagingSenderId: '1045101896672',
    projectId: 'gforce-42b39',
    storageBucket: 'gforce-42b39.appspot.com',
    iosBundleId: 'com.example.flutterGforce',
    databaseURL: 'https://gforce-42b39-default-rtdb.firebaseio.com/',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA2NKgunAKriYgzkj62OoEanoDL8Den-6g',
    appId: '1:1045101896672:ios:b4717c36514e0360d40185',
    messagingSenderId: '1045101896672',
    projectId: 'gforce-42b39',
    storageBucket: 'gforce-42b39.appspot.com',
    iosBundleId: 'com.example.flutterGforce.RunnerTests',
    databaseURL: 'https://gforce-42b39-default-rtdb.firebaseio.com/',
  );
}

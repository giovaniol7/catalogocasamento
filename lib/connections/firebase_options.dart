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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCJjll4bN95VXQybkbW-n3JmNPbdmdXkZQ',
    appId: '1:122204245827:web:fd589e0a7eca71a8d1e9f6',
    messagingSenderId: '122204245827',
    projectId: 'catalogocasamento-488a4',
    authDomain: 'catalogocasamento-488a4.firebaseapp.com',
    storageBucket: 'catalogocasamento-488a4.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCeydznDgD1dgoggEs9rGYsBWNApbyO8vU',
    appId: '1:122204245827:android:f619155905e28c88d1e9f6',
    messagingSenderId: '122204245827',
    projectId: 'catalogocasamento-488a4',
    storageBucket: 'catalogocasamento-488a4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAQ7W-UepKWN_4FXjC2wedVDJJgLfB71fo',
    appId: '1:122204245827:ios:36f59129c3c3abe9d1e9f6',
    messagingSenderId: '122204245827',
    projectId: 'catalogocasamento-488a4',
    storageBucket: 'catalogocasamento-488a4.appspot.com',
    iosBundleId: 'com.example.catalogocasamento',
  );
}

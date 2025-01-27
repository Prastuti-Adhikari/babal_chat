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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCgaDYEugBfXp1rTiw-aj6X8HqhvNtUjtQ',
    appId: '1:422208191330:web:f3b11d95e0e99139f70a3b',
    messagingSenderId: '422208191330',
    projectId: 'babal-chat-app-1',
    authDomain: 'babal-chat-app-1.firebaseapp.com',
    storageBucket: 'babal-chat-app-1.appspot.com',
    measurementId: 'G-8K5PVQBDSL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAwkG4sXuPYIwbPWnyn2WqtXpt27QGUv0s',
    appId: '1:422208191330:android:dc906870cd20b605f70a3b',
    messagingSenderId: '422208191330',
    projectId: 'babal-chat-app-1',
    storageBucket: 'babal-chat-app-1.appspot.com',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCgaDYEugBfXp1rTiw-aj6X8HqhvNtUjtQ',
    appId: '1:422208191330:web:a635333bf2283b3af70a3b',
    messagingSenderId: '422208191330',
    projectId: 'babal-chat-app-1',
    authDomain: 'babal-chat-app-1.firebaseapp.com',
    storageBucket: 'babal-chat-app-1.appspot.com',
    measurementId: 'G-EQT0VY95NY',
  );
}

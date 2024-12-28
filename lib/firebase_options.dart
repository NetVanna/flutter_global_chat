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
    apiKey: 'AIzaSyDbDDHDdoTk9R5poTc-Zbe7LqvHnjAD-jg',
    appId: '1:264749666038:web:9364e5da7c17afb1eb26d7',
    messagingSenderId: '264749666038',
    projectId: 'global-chat-acf8f',
    authDomain: 'global-chat-acf8f.firebaseapp.com',
    storageBucket: 'global-chat-acf8f.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCsA8rIHFr3PUJUHoDQwgnWC15kLizzb20',
    appId: '1:264749666038:android:7a45c3a91c1a5443eb26d7',
    messagingSenderId: '264749666038',
    projectId: 'global-chat-acf8f',
    storageBucket: 'global-chat-acf8f.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDV0fveMZQWbsPK6NaSG5z9W2UMEpQE0sQ',
    appId: '1:264749666038:ios:0c4dc168f1e73808eb26d7',
    messagingSenderId: '264749666038',
    projectId: 'global-chat-acf8f',
    storageBucket: 'global-chat-acf8f.firebasestorage.app',
    iosBundleId: 'com.example.globalChat',
  );
}
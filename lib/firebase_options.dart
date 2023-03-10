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
    apiKey: 'AIzaSyAe6BTNwcPQNtQGbyQRwaQ-bsjvX0tUzh8',
    appId: '1:153605106340:web:459bade92f7086d4be1431',
    messagingSenderId: '153605106340',
    projectId: 'user-authentication-c0d69',
    authDomain: 'user-authentication-c0d69.firebaseapp.com',
    storageBucket: 'user-authentication-c0d69.appspot.com',
    measurementId: 'G-259R7VW1FE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDNlvjUoiQwuP3N_QS1WzNPtH2RYxk2srk',
    appId: '1:153605106340:android:05bf1a24efbdacb5be1431',
    messagingSenderId: '153605106340',
    projectId: 'user-authentication-c0d69',
    storageBucket: 'user-authentication-c0d69.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB8af1s8b0_nM99mVANR90a5LtNWp13Ju4',
    appId: '1:153605106340:ios:655e09dbdec7e7adbe1431',
    messagingSenderId: '153605106340',
    projectId: 'user-authentication-c0d69',
    storageBucket: 'user-authentication-c0d69.appspot.com',
    iosClientId: '153605106340-jjrfv0gjfekf8qulccsdm2iio4287are.apps.googleusercontent.com',
    iosBundleId: 'com.example.userAuth',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB8af1s8b0_nM99mVANR90a5LtNWp13Ju4',
    appId: '1:153605106340:ios:655e09dbdec7e7adbe1431',
    messagingSenderId: '153605106340',
    projectId: 'user-authentication-c0d69',
    storageBucket: 'user-authentication-c0d69.appspot.com',
    iosClientId: '153605106340-jjrfv0gjfekf8qulccsdm2iio4287are.apps.googleusercontent.com',
    iosBundleId: 'com.example.userAuth',
  );
}

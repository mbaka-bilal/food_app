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
    apiKey: 'AIzaSyAcjR3I0YH1MMFnVB69ubigufrava8yL_0',
    appId: '1:535191963502:web:aad6ce0189af7f1d4aa37f',
    messagingSenderId: '535191963502',
    projectId: 'foodapp-1b762',
    authDomain: 'foodapp-1b762.firebaseapp.com',
    storageBucket: 'foodapp-1b762.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAXVLIkxtbCosFThux1JffDh63k0bviLys',
    appId: '1:535191963502:android:1607411736e8be714aa37f',
    messagingSenderId: '535191963502',
    projectId: 'foodapp-1b762',
    storageBucket: 'foodapp-1b762.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBD02EcABXofnGvYVSdcPy_yR7_kIQSbr4',
    appId: '1:535191963502:ios:b452902adf44b06a4aa37f',
    messagingSenderId: '535191963502',
    projectId: 'foodapp-1b762',
    storageBucket: 'foodapp-1b762.appspot.com',
    iosClientId: '535191963502-t49dmn69va7cdfl0j16b18ei7dqnsqpp.apps.googleusercontent.com',
    iosBundleId: 'com.example.foodApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBD02EcABXofnGvYVSdcPy_yR7_kIQSbr4',
    appId: '1:535191963502:ios:b452902adf44b06a4aa37f',
    messagingSenderId: '535191963502',
    projectId: 'foodapp-1b762',
    storageBucket: 'foodapp-1b762.appspot.com',
    iosClientId: '535191963502-t49dmn69va7cdfl0j16b18ei7dqnsqpp.apps.googleusercontent.com',
    iosBundleId: 'com.example.foodApp',
  );
}

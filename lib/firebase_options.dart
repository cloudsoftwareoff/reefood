
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyAAbN06J6wcRcbb_YVf1uTiJplrt9EPxlY',
    appId: '1:837297773076:web:e8f79fcff725ac64eb2501',
    messagingSenderId: '837297773076',
    projectId: 'reefoodtn',
    authDomain: 'reefoodtn.firebaseapp.com',
    storageBucket: 'reefoodtn.appspot.com',
    measurementId: 'G-MRR0N07DRV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDl4RQDZ_84be52L5BHeoskdffcaFE6z1Y',
    appId: '1:837297773076:android:cd7fb254e2388bf0eb2501',
    messagingSenderId: '837297773076',
    projectId: 'reefoodtn',
    storageBucket: 'reefoodtn.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAi7uS4DlnRpWOjVWS2c6iP7AZ7KfUHX10',
    appId: '1:837297773076:ios:a91f23776dba213feb2501',
    messagingSenderId: '837297773076',
    projectId: 'reefoodtn',
    storageBucket: 'reefoodtn.appspot.com',
    iosBundleId: 'com.example.reefood',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAi7uS4DlnRpWOjVWS2c6iP7AZ7KfUHX10',
    appId: '1:837297773076:ios:1fd6ff42fb95efceeb2501',
    messagingSenderId: '837297773076',
    projectId: 'reefoodtn',
    storageBucket: 'reefoodtn.appspot.com',
    iosBundleId: 'com.example.reefood.RunnerTests',
  );
}

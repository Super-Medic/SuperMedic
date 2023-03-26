import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDY1yYgwyMv_wU7P7Pq9BPwHD4kxrFQWoI',
    appId: '1:585309393841:android:2940a96afa932465df6390', //완료
    messagingSenderId: '585309393841', //완료
    projectId: 'supermedic-56c64', //완료
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC4XdjP_4_NwqZlgD8_hYwvpSxUNzKlVt4',
    appId: '1:585309393841:ios:65ccefaef460b313df6390', //완료
    messagingSenderId: '585309393841', //완료
    projectId: 'supermedic-56c64', //완료
    androidClientId:
        '406099696497-17qn06u8a0dc717u8ul7s49ampk13lul.apps.googleusercontent.com',
    iosClientId: //완료
        '585309393841-630881ql99k5djna2ivlic6krg0coole.apps.googleusercontent.com',
    iosBundleId: 'com.superMedic', //완료
  );
}

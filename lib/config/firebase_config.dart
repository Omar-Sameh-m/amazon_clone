// Firebase Configuration

import 'package:firebase_core/firebase_core.dart';

class FirebaseConfig {
  static Future<FirebaseApp> initializeFirebase() async {
    return await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'YOUR_API_KEY',
        appId: 'YOUR_APP_ID',
        messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
        projectId: 'YOUR_PROJECT_ID',
      ),
    );
  }
}
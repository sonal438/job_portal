import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:job/welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyCXaODzf-AXUk0M0Chgxu2xOWzLBvgkQlc",
        authDomain: "job-project-web.firebaseapp.com",
        projectId: "job-project-web",
        storageBucket: "job-project-web.firebasestorage.app",
        messagingSenderId: "356752462572",
        appId: "1:356752462572:web:32ddf1df756d82c618cbc9",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Job Portal',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const WelcomePage(), // ✅ App starts here
    );
  }
}

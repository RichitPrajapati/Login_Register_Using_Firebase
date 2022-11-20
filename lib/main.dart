import 'package:login_register_using_firebase/Splash_Screen.dart';
import 'package:login_register_using_firebase/Login_Page.dart';
import 'package:login_register_using_firebase/Home_Page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'splash_screen',
      routes: {
        'splash_screen': (context) => const SplashScreen(),
        'login_screen': (context) => const LoginScreen(),
        'home_page': (context) => const HomePage(),
      },
    ),
  );
}

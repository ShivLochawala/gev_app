import 'package:flutter/material.dart';
import 'package:gev_app/views/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Govardhan Eco Village - GEV',
      home: SplashScreen(),
      theme: ThemeData(
        primaryColor: Color(0xffFFCF70),
        accentColor: Color(0xff8b5d2e),
      ),
    );
  }
  
}
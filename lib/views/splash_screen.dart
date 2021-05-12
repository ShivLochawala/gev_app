import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gev_app/services/helper_function.dart';
import 'package:gev_app/views/home_screen.dart';
import 'package:gev_app/views/signin_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool userIsLoggedIn = false;
  HelperFuctions helperFuctions = new HelperFuctions();

  @override
  void initState() {
    super.initState();
    setState(() {
      getLoggedInState();  
    });
    Timer(
      Duration(seconds: 2),
      ()=> Navigator.pushReplacement(context, MaterialPageRoute(
        //builder: (context) => HomeScreen()
          builder: (context) => (userIsLoggedIn != null && userIsLoggedIn != false)? /**/ HomeScreen()/* */ : SignInScreen(),
        )
      )
    );
  }
  getLoggedInState() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedValue = prefs.getBool('ISLOGGEDIN');
    print("Splash Logged In Value: "+isLoggedValue.toString());
    setState(() {
      userIsLoggedIn = isLoggedValue;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Image.asset("assets/images/Logo.png",width: 500, height: 500,),
        ),
      ),
      backgroundColor: Color(0xffFFCF70),
    );
  }
}
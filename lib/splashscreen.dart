import 'dart:async';

import 'package:codeslueth/homescreen.dart';
import 'package:codeslueth/signup.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen>{

  String email = "";

  @override
  void initState(){
    super.initState();
    getStatus().whenComplete(() async{
      Timer(const Duration(seconds: 3), ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> (email == "" ? const SignUp() : const HomeScreen()))));
    });
  }

  @override
  Widget build(BuildContext context){

    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset("assets/animations/splashanimation.json", height: 200, width: 200),
                  Text("CodeSleuth", style: GoogleFonts.playfairDisplay(fontSize: 22, fontWeight: FontWeight.bold),),
                  Container(
                    width: screenWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Track Your Logical Progress", style: GoogleFonts.barlow(fontSize: 18, fontWeight: FontWeight.normal),)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future getStatus() async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var obtainedEmail = sharedPreferences.getString('email');

    if(obtainedEmail != null){
      setState(() {
        email = obtainedEmail;
      });
    }
  }
}
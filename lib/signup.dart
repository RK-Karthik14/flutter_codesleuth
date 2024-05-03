import 'package:codeslueth/customtoast.dart';
import 'package:codeslueth/homescreen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  bool isSignUp = true;
  bool _obscureText = true;

  TextEditingController _signupName = TextEditingController();
  TextEditingController _signupEmail = TextEditingController();
  TextEditingController _signupPassword = TextEditingController();
  TextEditingController _loginEmail = TextEditingController();
  TextEditingController _loginPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {

    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          // Background image and overlay
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/signupbg.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Container(
                padding: EdgeInsets.only(top: 90, left: 20),
                color: Color(0xFF3b5999).withOpacity(.85),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Welcome to, ",
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 25,
                          color: Colors.yellowAccent,
                        ),
                        children: [
                          TextSpan(
                            text: "CodeSleuth",
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 25,
                              color: Colors.yellowAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Signup to Continue",
                      style: TextStyle(letterSpacing: 1, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Login/Signup toggle
          Positioned(
            top: 200,
            child: Container(
              padding: EdgeInsets.all(20),
              height: 380,
              width: MediaQuery.of(context).size.width - 40,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildTab("LOGIN", !isSignUp),
                      buildTab("SIGNUP", isSignUp),
                    ],
                  ),
                  isSignUp ? buildSignupSection(isDarkMode ? Colors.black : Colors.white) : buildLoginSection(isDarkMode ? Colors.black : Colors.white),
                ],
              ),
            ),
          ),
          // Login Button
          Positioned(
            top: 535,
              right: 0,
              left: 0,
              child: Center(
                child: Container(
                  height: 90,
                  width: 90,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.black : Colors.white,
                    borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                            color: isDarkMode ? Colors.white.withOpacity(.3) : Colors.black.withOpacity(.3),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 1)
                        ),
                      ]
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors:  [Colors.lightBlueAccent, Colors.blueAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: isDarkMode ? Colors.white.withOpacity(.3) : Colors.black.withOpacity(.3),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 1)
                        ),
                      ]
                    ),
                    child: IconButton(
                      icon: Icon(Icons.arrow_forward, color: Colors.white,),
                      onPressed: (){
                        isSignUp ? register() : login_enter();
                      },
                    )
                  ),
                ),
              ),
          ),
        ],
      ),
    );
  }

  Widget buildTab(String label, bool isActive) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSignUp = label == "SIGNUP"; // Toggle isSignUp based on label
        });
      },
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isActive ? Colors.blue : Colors.grey,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 3),
            height: 2,
            width: 55,
            color: isActive ? Colors.blue : Colors.transparent,
          ),
        ],
      ),
    );
  }

  Widget buildTextFormField(String labelText, String hintText, IconData prefixIcon, TextEditingController controller, {bool isEmail = true}){
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            filled: true,
            fillColor: Theme.of(context).inputDecorationTheme.fillColor,
            enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
            focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
            prefixIcon: Icon(
              prefixIcon,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          validator: (value){
            if(isEmail){
              if(value != null && !EmailValidator.validate(value)){
                return "Please Enter valid Email Address";
              }
              else{
                return null;
              }
            }else{
              return null;
            }
          },
        ),
      ),
    );
  }

  Widget buildTextFormField_Password(String labelText, String hintText, IconData prefixIcon, TextEditingController controller){

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: TextFormField(
          obscureText: _obscureText,
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            filled: true,
            fillColor: Theme.of(context).inputDecorationTheme.fillColor,
            enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
            focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
            prefixIcon: Icon(
              prefixIcon,
              color: Theme.of(context).iconTheme.color,
            ),
            suffixIcon: IconButton(
              icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
              onPressed: (){
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
          ),
          validator: (value){
            if(value == null || value.length < 7){
              return "Min Characters 7";
            }else{
              return null;
            }
          },
        ),
      ),
    );
  }

  Container buildSignupSection(Color color){
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Column(
              children: [
                SizedBox(
                  child: Form(
                    child: buildTextFormField("Username", "Enter Username", Icons.person_2_outlined, _signupName, isEmail: false),
                  ),
                ),
                SizedBox(
                  child: Form(
                    child: buildTextFormField("Email", "Enter Email", Icons.email_outlined, _signupEmail),
                  ),
                ),
                SizedBox(
                  child: Form(
                    child: buildTextFormField_Password("Password", "Enter Password", Icons.password_outlined, _signupPassword),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildLoginSection(Color color){
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Column(
              children: [
                SizedBox(
                  child: Form(
                    child: buildTextFormField("Email", "Enter Email", Icons.email_outlined, _loginEmail),
                  ),
                ),
                SizedBox(
                  child: Form(
                    child: buildTextFormField_Password("Password", "Enter Password", Icons.password_outlined, _loginPassword),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void register() async {
    String username = _signupName.text.trim();
    String email = _signupEmail.text.trim();
    String password = _signupPassword.text.trim();

    if (username.isEmpty || email.isEmpty || password.length < 7){
      customtoast("Please fill the details", context);
      return;
    }

    try{
      bool userExists = await validation(email);
      if(userExists){
        customtoast("User Exists", context);
      }
      else{
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        await FirebaseFirestore.instance.collection("users").doc(email).set({
          'username': username,
          'emial': email,
          'password': password,
        });
        customtoast("Registered Successfully", context);
        setState(() {
          isSignUp = false;
        });
      }
    }
    catch(e){
      print(e);
      customtoast("Email Already in use", context);
    }
  }

  void login_enter() async{
    String email = _loginEmail.text.trim();
    String password = _loginPassword.text.trim();

    if(email.isEmpty || password.isEmpty){
      customtoast("Please Enter valid Details", context);
    }
    else{
      try{
        bool emailExists = await validation(email);
        if(!emailExists){
          customtoast("User not found", context);
        }
        else{
          UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
          customtoast("Success", context);
          final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setString('email', email);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
        }
      }
      catch(e){
        print(e);
        customtoast("Invalid email or password", context);
      }
    }
  }

  Future<bool> validation(String email) async{
    try{
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection("users").doc(email).get();
      return snapshot.exists;
    }
    catch(e){
      print(e);
      return false;
    }
  }
}

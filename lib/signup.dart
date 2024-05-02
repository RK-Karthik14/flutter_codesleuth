import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  bool isSignUp = true;

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
                    child: Icon(Icons.arrow_forward, color: Colors.white),
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

  Widget buildTextFormField(String labelText, String hintText, IconData prefixIcon){
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
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
                    child: buildTextFormField("Username", "Enter Username", Icons.person_2_outlined),
                  ),
                ),
                SizedBox(
                  child: Form(
                    child: buildTextFormField("Email", "Enter Email", Icons.email_outlined),
                  ),
                ),
                SizedBox(
                  child: Form(
                    child: buildTextFormField("Password", "Enter Password", Icons.password_outlined),
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
                    child: buildTextFormField("Email", "Enter Email", Icons.email_outlined),
                  ),
                ),
                SizedBox(
                  child: Form(
                    child: buildTextFormField("Password", "Enter Password", Icons.password_outlined),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void register() async {}
}

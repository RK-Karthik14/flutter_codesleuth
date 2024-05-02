import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUp extends StatefulWidget{
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUp();
}

class _SignUp extends State<SignUp>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Account"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10,),
                Image.asset("assets/images/logo.png", height: 100, width: 100,),
                const SizedBox(height: 30,),
                Container(
                  width: 300,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 145,
                        child: Form(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'First Name',
                              labelStyle: TextStyle(color: Theme.of(context).inputDecorationTheme.labelStyle?.color),
                              hintText: 'First Name',
                              prefixIcon: Icon(
                                  Icons.person_2_outlined,
                                  color: Theme.of(context).iconTheme.color,
                              ),
                              filled: true,
                              fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                              enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
                              focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
                              border: Theme.of(context).inputDecorationTheme.border,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      SizedBox(
                        width: 145,
                        child: Form(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Last Name',
                              labelStyle: TextStyle(color: Theme.of(context).inputDecorationTheme.labelStyle?.color),
                              hintText: 'Last Name',
                              prefixIcon: Icon(
                                Icons.person_2_outlined,
                                color: Theme.of(context).iconTheme.color,
                              ),
                              filled: true,
                              fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                              enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
                              focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
                              border: Theme.of(context).inputDecorationTheme.border,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  width: 300,
                  child: Form(
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Hackerrank',
                          labelStyle: TextStyle(
                            color: Theme.of(context).inputDecorationTheme.labelStyle?.color,
                          ),
                          hintText: 'Enter hackerrank handle',
                          filled: true,
                          fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                          enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
                          focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
                          border: Theme.of(context).inputDecorationTheme.border
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  width: 300,
                  child: Form(
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Hackerearth',
                          labelStyle: TextStyle(
                            color: Theme.of(context).inputDecorationTheme.labelStyle?.color,
                          ),
                          hintText: 'Enter Hackerearth handle',
                          filled: true,
                          fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                          enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
                          focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
                          border: Theme.of(context).inputDecorationTheme.border
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  width: 300,
                  child: Form(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Codechef',
                        labelStyle: TextStyle(
                          color: Theme.of(context).inputDecorationTheme.labelStyle?.color,
                        ),
                        hintText: 'Enter Codechef Handle',
                        filled: true,
                        fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                        enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
                        focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
                        border: Theme.of(context).inputDecorationTheme.border
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  width: 300,
                  child: Form(
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Leetcode',
                          labelStyle: TextStyle(
                            color: Theme.of(context).inputDecorationTheme.labelStyle?.color,
                          ),
                          hintText: 'Enter Leetcode Handle',
                          filled: true,
                          fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                          enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
                          focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
                          border: Theme.of(context).inputDecorationTheme.border
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: (){},
                  child: Text('Signup', style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(300, 50),
                    backgroundColor: Colors.blue,
                    elevation: 1,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
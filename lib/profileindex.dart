import 'package:codeslueth/customtoast.dart';
import 'package:codeslueth/homescreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class profileIndex extends StatefulWidget{

  const profileIndex({Key? key}) : super(key: key);

  @override
  State<profileIndex> createState() => _profileIndex();
}

class _profileIndex extends State<profileIndex>{

  TextEditingController _codeChefController = TextEditingController();
  TextEditingController _codeforcesController = TextEditingController();
  TextEditingController _leetCodeController = TextEditingController();

  @override
  void initState(){
    super.initState();
    _loadHandles();
  }

  @override
  Widget build(BuildContext context){

    double screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200,
            height: 200,
            child: Image.asset("assets/images/logowithname.png"),
          ),
          buildTextFormField("Codechef", "Enter Codechef Handle", _codeChefController, screenWidth),
          buildTextFormField("Codeforces", "Enter Codeforces Handle", _codeforcesController, screenWidth),
          buildTextFormField("Leetcode", "Enter Leetcode Handle", _leetCodeController, screenWidth),
          Container(
            child: OutlinedButton(
              onPressed: (){_saveDetails(_codeChefController.text.trim(), _codeforcesController.text.trim(), _leetCodeController.text.trim());},
              child: Text('Save Details', style: TextStyle(color: Colors.white),),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextFormField(String labelText, String hintText, TextEditingController controller, double screenWidth){
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Form(
        child: Container(
          width: screenWidth - 30,
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: labelText,
              hintText: hintText,
              filled: true,
              fillColor: Theme.of(context).inputDecorationTheme.fillColor,
              enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
              focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
            ),
          ),
        ),
      ),
    );
  }

  void _saveDetails(String codeChefHandle, String codeForceHandle, String leetCodeHandle) async{

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('codeChefHandle', codeChefHandle);
    await sharedPreferences.setString('codeForcesHandle', codeForceHandle);
    await sharedPreferences.setString('leetCodeHandle', leetCodeHandle);

    customtoast("Handles Updated Successfully", context);
  }

  Future<void> _loadHandles() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _codeChefController.text = sharedPreferences.getString('codeChefHandle') ?? '';
      _codeforcesController.text = sharedPreferences.getString('codeForcesHandle') ?? '';
      _leetCodeController.text = sharedPreferences.getString('leetCodeHandle') ?? '';
    });
  }
}
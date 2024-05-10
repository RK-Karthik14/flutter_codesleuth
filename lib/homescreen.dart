import 'package:codeslueth/emotionface.dart';
import 'package:codeslueth/profileindex.dart';
import 'package:codeslueth/splashscreen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreen();

  static _HomeScreen? of(BuildContext context) => context.findAncestorStateOfType<_HomeScreen>();
}

class _HomeScreen extends State<HomeScreen>{

  int _page = 1;
  String cpName = '';
  String imageName = '';
  bool _isLoading = false;
  bool _showPlatformInfo = false;

  String _codeChefName = '';
  String _codeChefCurrentRating = '';
  String _codeChefHighestRating = '';
  String _codeChefGlobalRank = '';
  String _codeChefCountryRank = '';
  String _codeChefStars = '';
  String _codeChefImage = "assets/images/codechef.png";
  String _codeChefLastContest = '';

  String _leetCodeName = '';
  String _leetCodeTotalSolved = '';
  String _leetCodeTotalProbs = '';
  String _leetCodeEasySolved = '';
  String _leetCodeHardSolved = '';
  String _leetCodeMediumSolved = '';
  String _leetCodeRanking = '';
  String _leetCodeAcceptanceRate = '';
  String leetCodeImage = "assets/images/leetcode.png";

  String _codeForcesName = '';
  String _codeForcesCurrRating = '';
  String _codeForcesMaxRating = '';
  String _codeForcesLastVisit = '';
  String codeforcesImage = "assets/images/codeforces.png";
  String _codeForcesProbs = '';
  String _codeForcesProbsLastMonth = '';



  List<String> codeChefDetails = [];

  @override
  void initState(){
    super.initState();
    _retrieveInfo();
  }

  @override
  Widget build(BuildContext context){

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    

    return Scaffold(
      backgroundColor: Color(0xFF121A94),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        index: _page,
        buttonBackgroundColor: Colors.blueAccent,
        color: Colors.black54,
        animationDuration: const Duration(milliseconds: 500),
        items: const <Widget>[
          Icon(Icons.person_2_outlined, color: Colors.white, size: 25,),
          Icon(Icons.home, color: Colors.white, size: 25,),
        ],
        onTap: (index){
          setState(() {
            _page = index;
          });
        },
      ),
      body: SafeArea(
        child: _buildContent(_page, screenHeight, screenWidth),
      ),
    );
  }

  Widget _buildContent(int page, double screenHeight, double screenWidth){
    switch(page){
      case 0:
        return profileIndex();

      case 1:
        return homeIndex(screenHeight, screenWidth);

      default:
        return Container();
    }
  }

  Widget homeIndex(double screenHeight, double screenWidth){
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Text("Hi, Programmer!", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
                      Text(getFormattedDate(), style: TextStyle(color: Colors.blue[200], fontWeight: FontWeight.normal, fontSize: 15),)
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'How do you feel?',
                    style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  IconButton(onPressed: (){_logout();}, icon: Icon(Icons.logout_outlined, color: Colors.white,))
                ],
              ),
              SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      EmotionFace(emotion: '😊',),
                      SizedBox(height: 8,),
                      Text('Good', style: TextStyle(color: Colors.white),)
                    ],
                  ),
                  Column(
                    children: [
                      EmotionFace(emotion: '😅',),
                      SizedBox(height: 8,),
                      Text('Confused', style: TextStyle(color: Colors.white),)
                    ],
                  ),
                  Column(
                    children: [
                      EmotionFace(emotion: '😒',),
                      SizedBox(height: 8,),
                      Text('Annoyed', style: TextStyle(color: Colors.white),)
                    ],
                  ),
                  Column(
                    children: [
                      EmotionFace(emotion: '🥱',),
                      SizedBox(height: 8,),
                      Text('Sleepy', style: TextStyle(color: Colors.white),)
                    ],
                  ),

                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 10,),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(15),
            height: screenHeight,
            width: screenWidth,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(45), topLeft: Radius.circular(45)),
                color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: _showPlatformInfo ? platformInfo(cpName, screenWidth, imageName) : codingPlatforms(screenWidth)
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPlatformSpecific(String platform){
    switch(platform){
      case "CodeChef":
        return codeChefInfoDetails();
      case "LeetCode":
        return leetCodeInfoDetails();
      case "Codeforces":
        return codeForcesInfoDetails();
      default:
        return Container();
    }
  }

  Container codingPlatforms(double screenWidth){
    return Container(
      child: Column(
        children: [
          Text('Analysis', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                    onTap: (){
                      setState(() {
                        _showPlatformInfo = true;
                        cpName = 'CodeChef';
                        imageName = _codeChefImage;
                      });
                    },
                    child: platformContainer(screenWidth, _codeChefImage, res: _codeChefCurrentRating)),
                InkWell(
                    onTap: (){
                      setState(() {
                        _showPlatformInfo = true;
                        cpName = "LeetCode";
                        imageName = leetCodeImage;
                      });
                    },
                    child: platformContainer(screenWidth, leetCodeImage, res: _leetCodeRanking, resName: 'Rank: ')),
              ],
            ),
          ),
          const SizedBox(height: 10,),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    setState(() {
                      _showPlatformInfo = true;
                      cpName = "Codeforces";
                      imageName = codeforcesImage;
                    });
                  },
                    child: platformContainer(screenWidth, codeforcesImage, res: _codeForcesCurrRating)),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Container platformContainer(double screenWidth, String image, {String res = '0xxx', String resName = 'Rating:'}){
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.2), spreadRadius: 5, blurRadius: 7, offset: Offset(0, 3))
        ]
      ),
      height: 200,
      width: (screenWidth / 2) - 40,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
              height: 80,
              child: Image.asset(image)
          ),
          SizedBox(height: 10,),
          Text(
            '$resName $res',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView platformInfo(String platformName, double screenWidth, String image){
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: (){setState(() {
                  _showPlatformInfo = false;
                });}, icon: Icon(Icons.arrow_back)),
                Text(platformName, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
              ],
            ),
            Container(
              width: screenWidth - 50,
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildPlatformSpecific(platformName),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: 30,),
                      Container(
                        width: 120,
                          height: 120,
                          child: Image.asset(image)
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded codeChefInfoDetails(){
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                Text("Handle: ", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                Text(_codeChefName, style: TextStyle(color: Colors.black, fontSize: 18),),
              ],
            ),
            Row(
              children: [
                Text("Rating (P): ", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                Text(_codeChefCurrentRating, style: TextStyle(color: Colors.black, fontSize: 18),),
              ],
            ),
            Row(
              children: [
                Text("Rating (H): ", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                Text(_codeChefHighestRating, style: TextStyle(color: Colors.black, fontSize: 18),),
              ],
            ),
            Row(
              children: [
                Text("Stars: ", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                Text(_codeChefStars, style: TextStyle(color: Colors.black, fontSize: 18),),
              ],
            ),
            Row(
              children: [
                Text("Rank (G): ", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                Text(_codeChefGlobalRank, style: TextStyle(color: Colors.black, fontSize: 18),),
              ],
            ),
            Row(
              children: [
                Text("Rank (L): ", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                Text(_codeChefCountryRank, style: TextStyle(color: Colors.black, fontSize: 18),),
              ],
            ),
            Column(
              children: [
                Text("Last COntest: ", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                Text(_codeChefLastContest, style: TextStyle(color: Colors.black, fontSize: 18),),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Expanded leetCodeInfoDetails(){
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Column(
              children: [
                Text("Handle: ", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                Text(_leetCodeName, style: TextStyle(color: Colors.black, fontSize: 18),),
              ],
            ),
            Row(
              children: [
                Text("Total Probs: ", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                Text(_leetCodeTotalProbs, style: TextStyle(color: Colors.black, fontSize: 18),),
              ],
            ),
            Row(
              children: [
                Text("Solved Probs: ", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                Text(_leetCodeTotalSolved, style: TextStyle(color: Colors.black, fontSize: 18),),
              ],
            ),
            Row(
              children: [
                Text("Rank: ", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                Text(_leetCodeRanking, style: TextStyle(color: Colors.black, fontSize: 18),),
              ],
            ),
            Row(
              children: [
                Text("Easy Probs: ", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                Text(_leetCodeEasySolved, style: TextStyle(color: Colors.black, fontSize: 18),),
              ],
            ),
            Row(
              children: [
                Text("Medium Probs: ", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                Text(_leetCodeMediumSolved, style: TextStyle(color: Colors.black, fontSize: 18),),
              ],
            ),
            Row(
              children: [
                Text("Hard Probs: ", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                Text(_leetCodeHardSolved, style: TextStyle(color: Colors.black, fontSize: 18),),
              ],
            ),
            Row(
              children: [
                Text("Rate: ", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                Text(_leetCodeAcceptanceRate, style: TextStyle(color: Colors.black, fontSize: 18),),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Expanded codeForcesInfoDetails(){
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                Text("Handle: ", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                Text(_codeForcesName, style: TextStyle(color: Colors.black, fontSize: 18),),
              ],
            ),
            Row(
              children: [
                Text("Rating (C): ", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                Text(_codeForcesCurrRating, style: TextStyle(color: Colors.black, fontSize: 18),),
              ],
            ),
            Row(
              children: [
                Text("Rating (M): ", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                Text(_codeForcesMaxRating, style: TextStyle(color: Colors.black, fontSize: 18),),
              ],
            ),
            Row(
              children: [
                Text("Probs (S): ", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                Text(_codeForcesProbs, style: TextStyle(color: Colors.black, fontSize: 18),),
              ],
            ),
            Row(
              children: [
                Text("Probs (LM): ", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                Text(_codeForcesProbsLastMonth, style: TextStyle(color: Colors.black, fontSize: 18),),
              ],
            ),
            Column(
              children: [
                Text("Last Visit: ", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                Text(_codeForcesLastVisit, style: TextStyle(color: Colors.black, fontSize: 18),),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String getFormattedDate(){
    DateTime now = DateTime.now();
    return DateFormat('dd, EEE, yyyy').format(now);
  }

  String extractNumericPart(String input) {
    // Remove all non-numeric characters from the input string
    String numericPart = input.replaceAll(RegExp(r'[^0-9]'), '');
    return numericPart;
  }

  Future<void> _fetchCodeChefInfo(String handle) async{
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(
          Uri.parse('https://codechef-api-one.vercel.app/$handle'));

      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body);
        setState(() {
          _codeChefCurrentRating = userData['currentRating'].toString();
          _codeChefHighestRating = userData['highestRating'].toString();
          _codeChefGlobalRank = userData['globalRank'].toString();
          _codeChefCountryRank = userData['countryRank'].toString();
          _codeChefStars = userData['stars'].toString();
          _codeChefLastContest = userData['lastContest'].toString();
          _isLoading = false;
        });
      }
      else {
        setState(() {
          _isLoading = false;
        });
        throw Exception('Failed to load user Data');
      }
    }
    catch(e){
      setState(() {
        _isLoading = false;
      });
      print(e);
    }
  }

  Future<void> _fetchLeetCodeInfo(String handle) async{
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(
          Uri.parse('https://leetcode-stats-api.herokuapp.com/$handle'));

      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body);
        setState(() {
          _leetCodeTotalSolved = userData['totalSolved'].toString();
          _leetCodeTotalProbs = userData['totalQuestions'].toString();
          _leetCodeEasySolved = userData['easySolved'].toString();
          _leetCodeMediumSolved = userData['mediumSolved'].toString();
          _leetCodeHardSolved = userData['hardSolved'].toString();
          _leetCodeAcceptanceRate = userData['acceptanceRate'].toString();
          _leetCodeRanking = userData['ranking'].toString();
          _isLoading = false;
        });
      }
      else {
        setState(() {
          _isLoading = false;
        });
        throw Exception('Failed to load user Data');
      }
    }
    catch(e){
      setState(() {
        _isLoading = false;
      });
      print(e);
    }
  }

  Future<void> _fetchCodeforcesInfo(String handle) async{
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(
          Uri.parse('https://codeforces-api-zeta.vercel.app/$handle'));

      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body);
        setState(() {
          _codeForcesCurrRating = userData['curr_rating'].toString();
          _codeForcesMaxRating = userData['max_rating'].toString();
          _codeForcesLastVisit = userData['last_visit'].toString();
          _codeForcesProbs = extractNumericPart(userData['tot_probs'].toString());
          _codeForcesProbsLastMonth = extractNumericPart(userData['probs_last_month'].toString());
          _isLoading = false;
        });
      }
      else {
        setState(() {
          _isLoading = false;
        });
        throw Exception('Failed to load user Data');
      }
    }
    catch(e){
      setState(() {
        _isLoading = false;
      });
      print(e);
    }
  }

  Future<bool?> _showLogoutConfirmationDialog() async{
    return await showDialog<bool>(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: const Text('Confirm Logout'),
            content: const Text('Are you sure you want to log out?'),
            actions: <Widget>[
              TextButton(onPressed: (){Navigator.of(context).pop(false);}, child: const Text('Cancel')),
              TextButton(onPressed: (){Navigator.of(context).pop(true);}, child: const Text('Logout'))
            ],
          );
        }
    );
  }

  void _retrieveInfo() async{

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      _codeChefName = sharedPreferences.getString('codeChefHandle') ?? '';
      _codeForcesName = sharedPreferences.getString('codeForcesHandle') ?? '';
      _leetCodeName = sharedPreferences.getString('leetCodeHandle') ?? '';

      if(_codeChefName.isNotEmpty){
        _fetchCodeChefInfo(_codeChefName);
      }

      if(_codeForcesName.isNotEmpty){
        _fetchCodeforcesInfo(_codeForcesName);
      }

      if(_leetCodeName.isNotEmpty){
        _fetchLeetCodeInfo(_leetCodeName);
      }
    });
  }

  void _logout() async{
    bool? confirmLogout = await _showLogoutConfirmationDialog();

    if(confirmLogout ?? false){
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.clear();
      Get.off(
        const SplashScreen(),
        transition: Transition.fade,
        duration: const Duration(seconds: 1),
      );
    }
  }

}
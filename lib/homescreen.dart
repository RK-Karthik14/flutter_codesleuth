import 'package:codeslueth/emotionface.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen>{

  int _page = 1;
  String _codechefrating = '';
  String _leetCodeRaking = '';
  bool _isLoading = false;

  @override
  void initState(){
    super.initState();
    _fetchCodeChefInfo();
    _fetchLeetCodeInfo();
  }

  @override
  Widget build(BuildContext context){

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFF21118a),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        index: _page,
        buttonBackgroundColor: Colors.blueAccent,
        color: Colors.black54,
        animationDuration: const Duration(milliseconds: 500),
        items: const <Widget>[
          Icon(Icons.person_2_outlined, color: Colors.white, size: 25,),
          Icon(Icons.home, color: Colors.white, size: 25,),
          Icon(Icons.schedule_outlined, color: Colors.white, size: 25,)
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
        return Container(alignment: Alignment.center, child: Text('Hello'),);

      case 1:
        return homeIndex(screenHeight, screenWidth);

      case 2:
        return Container(alignment: Alignment.center, child: Text('Hello'),);
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
              Container(

                decoration: BoxDecoration(color: Colors.blue[300], borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), spreadRadius: 5, blurRadius: 7, offset: Offset(0, 3),)]),
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.white,),
                    Text('Search', style: TextStyle(color: Colors.white),)
                  ],
                ),
              ),
              const SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'How do you feel?',
                    style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.more_horiz, color: Colors.white,)
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
                color: Colors.white
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text('Analysis', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        platformContainer(screenWidth, 'codechef.png', res: _codechefrating),
                        platformContainer(screenWidth, 'hackerearth.png'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        platformContainer(screenWidth, 'leetcode.png', res: _leetCodeRaking),
                        platformContainer(screenWidth, 'hackerrank.png'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Container platformContainer(double screenWidth, String image, {String res = 'Under Construction'}){
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
              child: Image.asset('assets/images/'+image)
          ),
          SizedBox(height: 10,),
          Text(
            'Rating: $res',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  String getFormattedDate(){
    DateTime now = DateTime.now();
    return DateFormat('dd, EEE, yyyy').format(now);
  }

  Future<void> _fetchCodeChefInfo() async{
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(
          Uri.parse('https://codechef-api.vercel.app/karthik_rk'));

      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body);
        setState(() {
          _codechefrating = userData['currentRating'].toString();
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

  Future<void> _fetchLeetCodeInfo() async{
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(
          Uri.parse('https://leetcode-stats-api.herokuapp.com/rk_karthik14'));

      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body);
        setState(() {
          _leetCodeRaking = userData['ranking'].toString();
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
}
import 'package:codeslueth/emotionface.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';


class HomeScreen extends StatefulWidget{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen>{

  int _page = 1;

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
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          height: 200,
                          width: (screenWidth / 2) - 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          height: 200,
                          width: (screenWidth / 2) - 20,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          height: 200,
                          width: (screenWidth / 2) - 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          height: 200,
                          width: (screenWidth / 2) - 20,
                        ),
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

  String getFormattedDate(){
    DateTime now = DateTime.now();
    return DateFormat('dd, EEE, yyyy').format(now);
  }


}
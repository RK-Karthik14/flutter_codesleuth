import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmotionFace extends StatelessWidget{

  final String emotion;
  const EmotionFace({Key? key, required this.emotion}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(12),
      child: Center(child: Text(emotion, style: TextStyle(fontSize: 28),)),
    );
  }
}
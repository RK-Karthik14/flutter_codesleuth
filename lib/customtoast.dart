import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

void customtoast(String message, BuildContext context, {Color backgroundColor = Colors.white}){
  showToast(
      message,
      textStyle: const TextStyle(
        fontSize: 18,
        wordSpacing: 0.1,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      textPadding: EdgeInsets.all(23),
    fullWidth: true,
    toastHorizontalMargin: 25,
    borderRadius: BorderRadius.circular(15),
    backgroundColor: backgroundColor,
    position: StyledToastPosition.top,
    animation: StyledToastAnimation.fade,
    duration: const Duration(seconds: 3),
    context: context
  );
}
import 'dart:convert';
import 'dart:math';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

extension String2Color on String{
  Color toColor(){
    var hexStr = replaceAll("#", "");
    return Color(int.parse(hexStr, radix: 16)).withAlpha(255);
  }
}

extension StringBase64 on String{
  String base64()=>const Utf8Decoder().convert(base64Decode(this));
}

extension RandomList on List{
  random()=> this[Random().nextInt(length)];
}

String getTodayTime(){
  var dateTime = DateTime.now();
  return "${dateTime.year}-${dateTime.month}-${dateTime.day}";
}

double getPro(currentPro,totalPro){
  try{
    var d = currentPro/totalPro;
    if(d>=1.0){
      return 1.0;
    }else if(d<0.0){
      return 0.0;
    }else{
      return d;
    }
  }catch(e){
    return 0.0;
  }
}


showToast(String text){
  if(text.isEmpty){
    return;
  }
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black45,
      textColor: Colors.white,
      fontSize: 16
  );
}

extension Str2Dou on String{
  double toDou(){
    try{
      return double.parse(this);
    }catch(e){
      return 0.0;
    }
  }
}

double addTwoNums(dynamic num1,dynamic num2){
  try{
    return (Decimal.parse("$num1")+Decimal.parse("$num2")).toDouble();
  }catch(e){
    return 0.0;
  }
}

double mulTwoNums(dynamic num1,dynamic num2){
  try{
    return (Decimal.parse("$num1")*Decimal.parse("$num2")).toDouble();
  }catch(e){
    return 0.0;
  }
}

//加密：“data”：原始字符串；“code”：需求文档标题前的项目编号
String encrypt(String data, int code) {
  final dataBytes = utf8.encode(data);
  List<int> xorList = [];
  for (int i = 0; i < dataBytes.length; i++) {
    xorList.add(dataBytes[i] ^ code);
  }
  return base64.encode(xorList);
}

//解密：“data”：加密字符串；“code”：需求文档标题前的项目编号
String decrypt(String data, int code) {
  final decode = base64.decode(data);
  final decode2 = decode.toList();
  List<int> xorList = [];
  for (int i = 0; i < decode2.length; i++) {
    xorList.add(decode2[i] ^ code);
  }
  return utf8.decode(xorList);
}


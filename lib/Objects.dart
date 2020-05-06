import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';



class DataTresh{
  List<ElementItem> items;
  DataTresh(List<ElementItem> items){
    this.items  = items;
  }
}

class Order{

List<int> ids;
String adress = "";
String num ="";
String name="";
String Promo="";
String comment = "Не введен.";
String date = "";
String time ="";
Order();

String getAdress(){
  return this.adress;
}
String getNum(){
  return this.num;
}
String getName(){
  return this.name;
}
String getPromo(){
  return this.Promo;
}
String getComment(){
  return this.comment;
}

  void initId(){
  ids =[1];

  ids.clear();
}

  void addId(int id){
  ids.add(id);
  }

  void addAdress(String adress) {
    this.adress = adress;
  }

  void addNum(String num) {
  this.num = num;
}

  void addName(String name) {
  this.name = name;
}

  void addPromo(String promo) {
  this.Promo = promo;
}

  void addComment(String comment) {
  this.comment = comment;
}

}

class itemOrder{
  List<int> ids;
  String adress = "";
  String num ="";
  String name="";
  String Promo="";
  String comment = "Не введен.";
  String date = "";
  String time ="";
  int Status = 0;




  itemOrder();
}



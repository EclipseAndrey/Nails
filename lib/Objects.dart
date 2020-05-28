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

List<String> UrlImage_c = [
  'http://eclipsedevelop.ru/images/c-1.png',
  'http://eclipsedevelop.ru/images/c-2.png',
  'http://eclipsedevelop.ru/images/c-3.png',
  'http://eclipsedevelop.ru/images/c-4.png',
  'http://eclipsedevelop.ru/images/c-5.png',
  'http://eclipsedevelop.ru/images/c-6.png',
  'http://eclipsedevelop.ru/images/c-7.png',
];

List<String> Header = [
  "Комплексы",
  "Маникюр",
  "Покрытия",
  "Педикюр",
  "Дизайн",
  "СПА Уход",
  "Брови",
];

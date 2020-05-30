import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'package:http/http.dart' as http;



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

class Like {
  String token;
  var response;
  int count;


  Like(String token){
    this.token = token;
  }


  List<int> likeIds = [];

  Future<bool> Likes ()async {
    Future<bool> res() async {
      await http.get(
          'http://eclipsedevelop.ru/api.php/getlikes?token=$token').then((
          value) {
        if (value.statusCode == 200) {
          this.response = jsonDecode(value.body);
          return true;
        } else {
          return false;
        }
      });
    }
    print('http://eclipsedevelop.ru/api.php/getlikes?token=$token');


    if (await res()) {
      if (this.response == 200) {
        count = response['count'];
        likeIds = response['likes'];
        return true;
      } else if (this.response == 202) {
        return false;
      } else if (this.response == 203) {
        return false;
      }
      else {
        return false;
      }
    }else return false;
  }

  List<int> getLikes (){
    return likeIds;
  }

  Future<bool> addLikes (int id) async{
    Future<bool> res() async {
      await http.get(
          'http://eclipsedevelop.ru/api.php/addlikes?token=$token&id=$id').then((
          value) {
        if (value.statusCode == 200) {
          return true;
        } else {
          return false;
        }
      });
    }
    print('http://eclipsedevelop.ru/api.php/addlikes?token=$token&id=$id');
    if(await res()){
      return true;
    }
    else
      {
        return false;
      }
  }

  Future<bool> deleteLikes (int id) async{
    Future<bool> res() async {
      await http.get(
          'http://eclipsedevelop.ru/api.php/deletelikes?token=$token&id=$id').then((
          value) {
        if (value.statusCode == 200) {
          return true;
        } else {
          return false;
        }
      });
    }
    print('http://eclipsedevelop.ru/api.php/deletelikes?token=$token&id=$id');
    if(await res()){
      return true;
    }
    else
    {
      return false;
    }
  }

  bool checkLike(int id){
    bool point = false;
    for(int i = 0; i < likeIds.length; i ++){
      if(likeIds[i] == id){
        point = true;
      }
    }
    return point;
  }

}

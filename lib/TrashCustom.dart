import 'dart:convert';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutterapp32/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'EmptyTrash.dart';
import 'Objects.dart';
import 'home.dart';
import 'style.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'dart:async';
import 'package:flutter_rounded_date_picker/src/material_rounded_date_picker_style.dart';
import 'package:flutter_rounded_date_picker/src/material_rounded_year_picker_style.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:core';
import 'dart:async';
import 'main.dart';
import 'package:http/http.dart' as http;


class TrashCustom extends StatefulWidget {
  @override
  _TrashCustomState createState() => _TrashCustomState();
}

class _TrashCustomState extends State<TrashCustom> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child:Image.asset('assets/images/backround.png',
            fit: BoxFit.fill,),
        ),


        ContentTrash(),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20 ,),
            child: Divider(
              thickness: 0.4,
              endIndent: 0,
              indent: 0,
              height: 1,

              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }


  Widget ContentTrash(){

    Widget Prise(ElementItem itemForSales){
      if(itemForSales.sale>0){
        return Row(

          children: <Widget>[
            Text("${itemForSales.price} руб.", style: TextStyle(color: Colors.white, fontSize: 16, decoration: TextDecoration.lineThrough,),),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text("${itemForSales.price - itemForSales.sale} руб.", style: TextStyle(color: Colors.pinkAccent, fontSize: 16),),


            ),
          ],
        );
      }else{
        return Row(

          children: <Widget>[
            Text("${itemForSales.price} руб.", style: TextStyle(color: Colors.white, fontSize: 16, ),),
          ],
        );
      }
    }

    List<int> populations = [];

    for(int i = 0; i < 7; i++){
      for(int j = 0; j < ItemCount(i).count; j++) {
        if(elementInfo(i, j).population){
          populations.add((i+1)*100+j+1);
        }
      }}

    int count = populations.length;
    int ColumnOne;
    int ColumnTwo;

    if (count % 2 > 0) {
      ColumnOne = count ~/ 2 + 1;
      ColumnTwo = count ~/ 2;
    } else {
      ColumnOne = count ~/ 2;
      ColumnTwo = count ~/ 2;
    }
    List<ElementItem> SearchResult=[];


    for(int i = 0; i < populations.length;i++){
      SearchResult.add(elementInfo(populations[i]~/100-1, populations[i]%100-1));
    }


    if(ObjectTrash.getTrash().length > 0){
      List<dynamic> spisok = ObjectTrash.getTrash();
      var size = MediaQuery.of(context).size;

      List<ElementItem> elemts = [];
      for(int i = 0; i < ObjectTrash.getTrash().length; i++){
        elemts.add(elementInfo(int.parse(ObjectTrash.getTrash()[i])~/100-1, int.parse(ObjectTrash.getTrash()[i])%100-1));
      }
      Widget Prise(ElementItem itemForSales){
        if(itemForSales.sale>0){
          return Row(

            children: <Widget>[
              Text("${itemForSales.price} руб.", style: TextStyle(color: Colors.white, fontSize: 16, decoration: TextDecoration.lineThrough,),),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text("${itemForSales.price - itemForSales.sale} руб.", style: TextStyle(color: Colors.pinkAccent, fontSize: 16),),


              ),
            ],
          );
        }else{
          return Row(

            children: <Widget>[
              Text("${itemForSales.price} руб.", style: TextStyle(color: Colors.white, fontSize: 16, ),),
            ],
          );
        }
      }


      return Column(
        children: [
          Container(
            height: 73,
            child: Column(
              children: [
                Text("Корзина",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 44,
                      fontFamily: "MPLUS",
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w300),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 48.0, right: 48),
                  child: Divider(
                    height: 1,
                    color: Colors.white60,

                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: List.generate(ObjectTrash.getTrash().length, (index) {
                    return ClipRRect(
                      child: Card(
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(

                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(width: 1, color:Colors.white ),
                          ),

//                color: Color(0xff8A1FFF),
                          child: Container(
                            color: Colors.transparent,
                            width: size.width * 0.95,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image(
                                          image: images[int.parse(spisok[index])~/100-1][int.parse(spisok[index])%100-1].image,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 14.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(elemts[index].head, style: TextStyle(fontSize: 18, color: Colors.white),),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 12.0),
                                              child: Text(elemts[index].tx, style: TextStyle(fontSize: 14, color: Colors.white60),),
                                            ),
                                          ],
                                        ),

                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top:18.0),
                                              child: Prise(elemts[index]),
                                            ),
                                          ],
                                        ),


                                      ],
                                    ),
                                  ),),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 14.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(bottom:10.0),
                                          child: TrashButton(elementInfo(int.parse(spisok[index])~/100-1,int.parse(spisok[index])%100-1)),
                                        ),

                                      ],
                                    ),
                                  ),),
                              ],
                            ),
                          )),
                    );
                  }),
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            color: Color.fromRGBO(34, 15, 45, 1),
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 4, left: 30, right: 30),
              child: FlatButton(
                onPressed: (){

                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    side: BorderSide(color: Colors.white)),
                color: Colors.transparent,
                textColor: Colors.pinkAccent,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30, top: 8, bottom: 8),
                  child: Text("Оформить заказ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: "MPLUS",
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
        ],
      );

    }else{








      return SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text("В корзине пусто",
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 44,
                      fontFamily: "MPLUS",
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w300),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.50,
                  child: AspectRatio(
                    aspectRatio: 1/1,
                    child: Opacity(
                      opacity: 0.5,
                      child: Image.asset('assets/images/telega80.png',
                        fit: BoxFit.fill,),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                            "Вам может понравиться",
                            style: TextStyle(color: Colors.white, fontSize: 35,),
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[

                          Column(
                            children:
                            List.generate(ColumnOne, (index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 18.0),
                                child: Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.44,
                                  child: Stack(
                                    children: <Widget>[

                                      Column(
                                        children: <Widget>[
                                          AspectRatio(
                                            aspectRatio: 9 / 12,
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.circular(15),
                                                child: Image.network(
                                                    SearchResult[index*2]
                                                      .picture, fit: BoxFit.fill,)),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                child: Expanded(
                                                  flex: 7,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding: const EdgeInsets.only(
                                                            left: 16.0, top: 4, right: 2),
                                                        child: FittedBox(
                                                          fit: BoxFit.contain,
                                                          child: Text(SearchResult[index*2]
                                                              .head, style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 16),),
                                                        ),
                                                      ),
                                                      Padding(
                                                          padding: const EdgeInsets.only(
                                                              left: 16.0),
                                                          child: Prise(SearchResult[index*2])
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(right: 8.0),
                                                  child: Icon(Icons.add_shopping_cart,
                                                    color: Colors.white,),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      Positioned(
                                        top: 10,
                                        right: 10,
                                        child: LikeButton(elementInfo(populations[index*2]~/100-1, populations[index*2]%100-1)),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                          Column(
                            children:
                            List.generate(ColumnTwo, (index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 18.0),
                                child: Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.44,
                                  child: Stack(
                                    children: <Widget>[

                                      Column(
                                        children: <Widget>[
                                          AspectRatio(
                                            aspectRatio: 9 / 12,
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.circular(15),
                                                child: Image.network(
                                                  SearchResult[index*2+1]
                                                      .picture, fit: BoxFit.fill,)),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                child: Expanded(
                                                  flex: 7,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding: const EdgeInsets.only(
                                                            left: 16.0, top: 4, right: 2),
                                                        child: FittedBox(
                                                          fit: BoxFit.contain,
                                                          child: Text(SearchResult[index*2+1]
                                                              .head, style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 16),),
                                                        ),
                                                      ),
                                                      Padding(
                                                          padding: const EdgeInsets.only(
                                                              left: 16.0),
                                                          child: Prise(SearchResult[index*2+1])
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(right: 8.0),
                                                  child: Icon(Icons.add_shopping_cart,
                                                    color: Colors.white,),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      Positioned(
                                        top: 10,
                                        right: 10,
                                        child: LikeButton(elementInfo(populations[index*2+1]~/100-1, populations[index*2+1]%100-1)),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),

                    ],
                  ),
                )
              ],
            ),
          ),
        ),




      );
    }





  }

























}

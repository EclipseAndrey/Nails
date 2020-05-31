import 'dart:convert';
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


    if(TrashSave.length > 0){

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
                                  child: Column(
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
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 16.0, top: 4),
                                                  child: Text(SearchResult[index*2]
                                                      .head, style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),),
                                                ),
                                                Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 16.0),
                                                    child: Prise(SearchResult[index*2])
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 8.0),
                                            child: Icon(Icons.add_shopping_cart,
                                              color: Colors.white,),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:
                            List.generate(ColumnTwo, (index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 18.0),
                                child: Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.44,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      AspectRatio(
                                        aspectRatio: 9 / 12,
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.circular(15),
                                            child: Image.network(SearchResult[index*2+1]
                                                .picture, fit: BoxFit.fill,)),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 16.0, top: 4),
                                                  child: Text(SearchResult[index*2+1]
                                                      .head, style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),),
                                                ),
                                                Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 16.0),
                                                    child: Prise(SearchResult[index*2+1])
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 8.0),
                                            child: Icon(Icons.add_shopping_cart,
                                              color: Colors.white,),
                                          )
                                        ],
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
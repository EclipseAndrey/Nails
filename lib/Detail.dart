import 'dart:ui';

import 'package:flutter/material.dart';
import 'FadeAnimation.dart';
import 'home.dart';
import 'home.dart';
import 'home.dart';
import 'home.dart';
import 'home.dart';

class Detail extends StatefulWidget {
  ElementItem _elementItem;
  Detail(ElementItem elementItem){
    _elementItem = elementItem;
  }
  @override
  _DetailState createState() => _DetailState(_elementItem);
}

class _DetailState extends State<Detail> {
  ElementItem elementItem;
  _DetailState(ElementItem elementItem){
    this.elementItem = elementItem;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor:  Color.fromRGBO(34, 15, 51, 1),
      body: Column(
        children: <Widget>[
          Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Container(
                height: 200,
                alignment: Alignment.topLeft,
                //width: double.infinity,
                decoration: BoxDecoration(
                image: DecorationImage(
                  image: Image.network(elementItem.picture, fit: BoxFit.contain,).image, fit: BoxFit.fill),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                  child: Padding(
                      padding: const EdgeInsets.only(top: 9.0, left: 2.0, bottom: 5),
                      child: IconButton(
                        color: Colors.white,
                        iconSize: 28,
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context, '/MyOrders');
                        },
                      )
                  ),
                ),
              ),
              Positioned(
                top: 50,
                left: 120,
                right: 120,
                child: Hero(
                  tag: elementItem.id,
                  child: Container(
                    height: 210,
                    width: 170,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          blurRadius: 25.0, // soften the shadow
                          spreadRadius: 5.0, //extend the shadow
                          offset: Offset(
                            -3.0, // Move to right 10  horizontally
                            0.0, // Move to bottom 10 Vertically
                          ),
                        )
                      ],
                      image: DecorationImage(
                          image: Image.network(
                            elementItem.picture,
                            fit: BoxFit.contain,
                          ).image,
                          fit: BoxFit.fill),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15.0),
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 80,),
          Container(
            color:  Color.fromRGBO(34, 15, 51, 1),
            child: Column(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(elementItem.head, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),),
                    Text(elementItem.price.toString() + "₽", style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.white),),
                  ],
                ),
                SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    FlatButton(
                      onPressed: (){

                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          side: BorderSide(color: Colors.white)),
                      color: Colors.transparent,
                      textColor: Colors.pinkAccent,
                      child: Text("В корзину",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: "MPLUS",
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    FlatButton(
                      onPressed: (){

                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          side: BorderSide(color: Colors.white)),
                      color: Colors.transparent,
                      textColor: Colors.pinkAccent,
                      child: Text("В избранное",
                        style: TextStyle(
                            color: Colors.pinkAccent,
                            fontSize: 16,
                            fontFamily: "MPLUS",
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Text("Таким образом новая модель организационной деятельности способствует подготовки и реализации форм развития. "
                      "Повседневная практика показывает, что консультация с широким активом позволяет выполнять важРазнообразный и богатый "
                      "опыт рамки и место обучения кадров способствует подготовки и реализации форм развития. Идейные соображения высшего "
                      "кадров, соответствует насущным потребностям.", style: TextStyle(fontSize: 16, color: Colors.white),),
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}


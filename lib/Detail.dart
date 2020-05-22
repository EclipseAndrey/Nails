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
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            width: double.infinity,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(255, 164, 116, .5),
                    spreadRadius: 3,
                    blurRadius:10,
                    offset: Offset(-2, 3), // changes position of shadow
                  ),
                ],
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    colors: [
                      Color.fromRGBO(255, 116, 81, 0.8),
                      Color.fromRGBO(255, 116, 81, 0.7),
                      Color.fromRGBO(255, 116, 81, 0.7)
                    ]
                )
            ),
            child: Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 2.0, bottom: 5),
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
          Hero(
            tag: elementItem.id,
            child: Container(
              height: 100,
              width: 400,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: Image.network(
                      elementItem.picture,
                      fit: BoxFit.fill,
                    ).image,
                    fit: BoxFit.fill),
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5.0),
                  bottomRight: Radius.circular(5.0),
                ),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.only(left: 10, top: 30),
              child: Text(
              'В частности, понимание сути ресурсосберегающих технологий прекрасно подходит для реализации поставленных обществом задач. '
                  'Базовые сценарии поведения пользователей подвергнуты целой'
                  ' серии независимых исследований.',
                style: TextStyle(fontSize: 18, color: Colors.black54,),
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: FadeAnimation(0.6, Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(255, 116, 81, 0.8)
                    ),
                    child: Center(
                      child: Text("Добавить в корзину", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
                    ),
                  ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutterapp32/FadeAnimation.dart';
import 'MyOrders.dart';
import 'home.dart';
import 'package:http/http.dart' as http;
import 'main.dart';


class OrderDetail extends StatefulWidget {
  ElementItemOrder _elementItem;
  OrderDetail(ElementItemOrder elementItem){
    _elementItem = elementItem;
  }
  @override
  _OrderDetailState createState() => _OrderDetailState(_elementItem);
}

class _OrderDetailState extends State<OrderDetail> {
  ElementItemOrder elementItem;
  _OrderDetailState(ElementItemOrder elementItem){
    this.elementItem = elementItem;
  }

  Widget orders50(List<dynamic> id, int index) {
      return Padding(
        padding: const EdgeInsets.only(left: 10.0, bottom: 10, right: 30),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  height: 60,
                  width: 60,
                  child: CircleAvatar(
                    backgroundImage:  NetworkImage(elementInfo((id[index] ~/ 100), id[index] % 100).picture),
                  )
              ),
              Text(
                elementInfo((id[index] ~/ 100), id[index] % 100).head,
                style: TextStyle(color: Colors.black, decoration: TextDecoration.none, fontSize: 16),
              ),
              Text(elementInfo((id[index] ~/ 100), id[index] % 100).price.toString() + " ₽",
                style: TextStyle(color: Colors.black, decoration: TextDecoration.none, fontSize: 18),
              )
            ],
          ),
        ),
      );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 55,
              child: Stack(
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
                  ),
                  Padding(
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
                  Center(
                    child: Text("Информация записи", style: TextStyle(color: Colors.white, fontSize: 18),),
                  ),
                ],
              ),
            ),
            FadeAnimation(0.8, Container(
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 35.0, left: 20.0),
                      child: Text("В ваш заказ входит:", style: TextStyle(fontWeight: FontWeight.w400,
                          fontSize: 21, color: Colors.black),),
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: elementItem.ids.length,
                      itemBuilder: (BuildContext context, int index){
                        return orders50(elementItem.ids, index);
                  })
                ],
              ),
            )),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: FadeAnimation(0.8, GestureDetector(
                    onTap: (){
                      String id = elementItem.id;
                      http.get("http://eclipsedevelop.ru/api.php/cbsetstatus?token=$token&id=$id&status=2");
                      print("http://eclipsedevelop.ru/api.php/cbsetstatus?token=$token&id=$id&status=2");
                      Navigator.pop(context, '/MyOrders');
                    },
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromRGBO(255, 116, 81, 0.8)
                      ),
                      child: Center(
                        child: Text("Отменить запись", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),),
                      ),
                    ),
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}


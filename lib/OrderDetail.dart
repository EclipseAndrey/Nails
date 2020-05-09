import 'package:flutter/material.dart';
import 'MyOrders.dart';


class OrderDetail extends StatefulWidget {
  ElementItemOrder _elementItem;
  OrderDetail(ElementItemOrder elementItem){
    _elementItem = elementItem;
  }
  @override
  _OrderDetailState createState() => _OrderDetailState(_elementItem);
}

class _OrderDetailState extends State<OrderDetail> {
  String kartinka = 'https://p16.muscdn.com/img/musically-maliva-obj/1650991040036870~c5_720x720.jpeg';
  ElementItemOrder elementItem;
  _OrderDetailState(ElementItemOrder elementItem){
    this.elementItem = elementItem;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Color.fromRGBO(62, 71, 87, 1),
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/MyOrders');
          },
        ),
        backgroundColor: Color.fromRGBO(255, 230, 229, 1),
        title: Text(elementItem.time, style: TextStyle(color: Color.fromRGBO(62, 71, 87, 1)),),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Hero(
                transitionOnUserGestures: true,
                tag: elementItem.id,
                child: Material(
                  color: Colors.transparent,
                  child: Image.network(kartinka, fit: BoxFit.fill,
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  color: Colors.white70,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 10),
                    child: Text(
                      'В частности, понимание сути ресурсосберегающих технологий прекрасно подходит для реализации поставленных обществом задач. '
                          'Базовые сценарии поведения пользователей подвергнуты целой'
                          ' серии независимых исследований.', style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}


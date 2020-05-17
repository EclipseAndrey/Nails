import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterapp32/home.dart';
import 'package:intl/intl.dart';
import 'dart:core';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'OrderDetail.dart';
import 'main.dart';

class MyOrders extends StatefulWidget {

  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  String i = token;

  @override
  Future<void> initState()  {
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color.fromRGBO(225, 200, 199, 10),
        elevation: 0.0,
        title: Text("Мои заказы"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
      ),
      body: odresList(token, context),
    );
  }
}

String days(int d) {
  if (d % 10 == 1 && d > 20 || d == 1) {
    return ("Через " + d.toString() + ' день');
  }
  if (d % 10 > 1 && d % 10 < 5 && (d < 10 || d > 20)) return ("Через $d дня");
  if ((d < 21 && d > 4) || (d % 10 > 4 && d % 10 < 10) || d % 10 == 0)
    return ("Через " + d.toString() + " дней");
}

String hours(int d) {
  if (d % 10 == 1 && d > 20 || d == 1) {
    return ("Через " + d.toString() + ' час');
  }
  if (d % 10 > 1 && d % 10 < 5 && (d < 10 || d > 20)) return ("Через $d часа");
  if ((d < 21 && d > 4) || (d % 10 > 4 && d % 10 < 10) || d % 10 == 0)
    return ("Через " + d.toString() + " часов");
}

String minutes(int d) {
  if (d % 10 == 1 && d > 20 || d == 1) {
    return ("Через " + d.toString() + ' минуту');
  }
  if (d % 10 > 1 && d % 10 < 5 && (d < 10 || d > 20))
    return ("Через $d минуты");
  if ((d < 21 && d > 4) || (d % 10 > 4 && d % 10 < 10) || d % 10 == 0)
    return ("Через " + d.toString() + " минут");
}

Widget orders50(List<dynamic> id) {
  //ограничение по символам
  int symbols = 50;
  //размер шрифта
  double symbilssize = 11;

  switch (id.length) {
    case 1:
      {
        return Text(
          elementInfo((id[0] ~/ 100), id[0] % 100).head,
          style:
          TextStyle(decoration: TextDecoration.none, fontSize: symbilssize),
        );
      }
      break;
    case 2:
      {
        if (elementInfo((id[0] ~/ 100), id[0] % 100).head.length +
            elementInfo((id[1] ~/ 100), id[1] % 100).head.length >
            symbols) {
          return Text(
            elementInfo((id[0] ~/ 100), id[0] % 100).head + '...',
            style: TextStyle(
                decoration: TextDecoration.none, fontSize: symbilssize),
          );
        } else {
          return Text(
            elementInfo((id[0] ~/ 100), id[0] % 100).head +
                ', ' +
                elementInfo((id[1] ~/ 100), id[1] % 100).head,
            style: TextStyle(
                decoration: TextDecoration.none, fontSize: symbilssize),
          );
        }
      }
      break;
    default:
      {
        if (elementInfo((id[0] ~/ 100), id[0] % 100).head.length +
            elementInfo((id[1] ~/ 100), id[1] % 100).head.length >
            symbols) {
          return Text(
            elementInfo((id[0] ~/ 100), id[0] % 100).head + '...',
            style: TextStyle(
                decoration: TextDecoration.none, fontSize: symbilssize),
          );
        } else {
          return Text(
            elementInfo((id[0] ~/ 100), id[0] % 100).head +
                ', ' +
                elementInfo((id[1] ~/ 100), id[1] % 100).head +
                '...',
            style: TextStyle(
                decoration: TextDecoration.none, fontSize: symbilssize),
          );
        }
      }
      break;
  }
}

Widget StatusOrder(int _Status, BuildContext context) {
  switch (_Status) {
    case 0:
      {
        return Container(
          child: Row(
            children: <Widget>[
              Container(
                width: 3.0,
                height: 3.0,
                decoration: new BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
              ),
              Text(
                'Ожидание',
                style: TextStyle(
                    color: Colors.orange, decoration: TextDecoration.none),
              )
            ],
          ),
        );
      }
      break;
    case 1:
      {
        return Container(
          child: Row(
            children: <Widget>[
              Container(
                width: 3.0,
                height: 3.0,
                decoration: new BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
              Text(
                'Подтвержден',
                style: TextStyle(
                    color: Colors.green, decoration: TextDecoration.none),
              )
            ],
          ),
        );
      }
      break;
    case 2:
      {
        return Container(
          child: Row(
            children: <Widget>[
              Container(
                width: 3.0,
                height: 3.0,
                decoration: new BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
              Text(
                'Отменен',
                style: TextStyle(
                    color: Colors.red, decoration: TextDecoration.none),
              )
            ],
          ),
        );
      }
      break;
    case 4:
      {
        return Container(
          child: Row(
            children: <Widget>[
              Container(
                width: 3.0,
                height: 3.0,
                decoration: new BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
              Text(
                'Завершен',
                style: TextStyle(
                    color: Colors.blue, decoration: TextDecoration.none),
              )
            ],
          ),
        );
      }
      break;
    default:
      {
        return SizedBox();
      }
  }
}

Widget def(String date, String time) {
  var dateorder = date;
  var timeorder = time;

  String defferent = "none";

  var now = new DateTime.now();

  var intlorder = new DateFormat("dd.MM.yyyy HH:mm", "en_US")
      .parse(dateorder + " " + timeorder);
  var different = intlorder.difference(now);
  if (different.inDays > 30) {
    //>month
    print("Больше месяца");
    defferent = "Больше месяца";
  } else {
    if (different.inDays >= 1) {
      //>0 days < month

      if (different.inDays == 1) {
        //1 day
        defferent = ("Завтра");
      } else {
        defferent = days(different.inDays).toString();
      }
    } else {
      // < 1 day

      if (different.inHours > 0) {
        // > 0 hour
        defferent = hours(different.inHours).toString();
      } else {
        defferent = minutes(different.inMinutes).toString();
      }
    }
  }

  print("Now " + new DateFormat("dd-MM-yyyy HH:mm:ss").format(now));
  print("Order " + new DateFormat("dd-MM-yyyy HH:mm:ss").format(intlorder));
  //_counter = dateorder.day.toString() ;

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      child: Text(
        defferent,
        style: TextStyle(
            fontStyle: FontStyle.italic,
            color: Color.fromRGBO(32, 232, 14, 100),
            decoration: TextDecoration.none),
      ),
    ),
  );
}

Widget bigDay(String date, String time) {
  String _month(String month) {
    switch (month) {
      case "1":
        return "января";
        break;
      case "2":
        return "февраля";
        break;
      case "3":
        return "марта";
        break;
      case "4":
        return "апреля";
        break;
      case "5":
        return "мая";
        break;
      case "6":
        return "июня";
        break;
      case "7":
        return "июля";
        break;
      case "8":
        return "августа";
        break;
      case "9":
        return "сентября";
        break;
      case "10":
        return "октября";
        break;
      case "11":
        return "ноября";
        break;
      case "12":
        return "декабря";
        break;
    }
  }

  var dateorder = date;
  var timeorder = time;

  String defferent = "none";

  var now = new DateTime.now();

  var intlorder = new DateFormat("dd.MM.yyyy HH:mm", "en_US")
      .parse(dateorder + " " + timeorder);
  var different = intlorder.difference(now);
  String tx;
  if (intlorder.day - now.day > 0) {
    tx = intlorder.day.toString() + " " + _month(intlorder.month.toString());
  } else {
    tx = time;
  }
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      tx,
      style: TextStyle(
        fontSize: 28,
        decoration: TextDecoration.none,
      ),
    ),
  );
}


Widget odresList(String token, BuildContext context)  {
  print(response2.toString());


  if (response2['count'] > 0) {
    return Container(

      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [
              Color.fromRGBO(255, 240, 239, 1),
              Color.fromRGBO(255, 240, 239, 1),

            ],
//              stops: [0.45,0.5],
          )),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top:4.0),
          child: Column(children:List.generate(response2['count'], (index) {
            ElementItemOrder itemOrder = ElementItemOrder(index, response2['orders'][index]['order']['date'], response2['orders'][index]['order']['time'],
                response2['orders'][index]['ids'], int.parse(response2['orders'][index]['order']['status']));
            print("JOPA " + itemOrder.id.toString());
            return ElementOrder(itemOrder, context);
          })
            ,),
        ),
      ),
    );
  } else {
    return SizedBox();
  }


}
class ElementItemOrder{
  int id;
  String date;
  String time;
  List<dynamic> ids;
  int status;

  ElementItemOrder(int id, String date, String time, List<dynamic> ids, int status){
    this.id = id;
    this.date = date;
    this.time = time;
    this.ids = ids;
    this.status = status;
  }
}

Widget ElementOrder(ElementItemOrder item, BuildContext context) {
  print("Дата контейнера "+item.date+" Время "+item.time);
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OrderDetail(item)));
    },
    child: Padding(
      padding: const EdgeInsets.all(6.0),
      child: Hero(
        tag: item.id,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomRight,
              colors: [
                Color.fromRGBO(255, 250, 245, 1),
                Color.fromRGBO(255, 250, 250, 1),
              ],
//              stops: [0.45,0.5],
            ),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.transparent.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          width: MediaQuery.of(context).size.width-12,
          height: 80,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(

                    width: (MediaQuery.of(context).size.width-12)*2/3,
                    child: Row(
                      children: <Widget>[
                        bigDay(item.date, item.time),
                        def(item.date, item.time),


                      ],
                    ),

                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width-12)*1/3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: StatusOrder(item?.status, context),
                        ),

                      ],
                    ),
                  ),
                ],
              ),

              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: orders50(item?.ids),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

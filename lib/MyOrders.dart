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

  switch (id.length) {
    case 1:
      {
        return Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 3),
          child: ConstrainedBox(
            child: Text(
              elementInfo((id[0] ~/ 100), id[0] % 100).head,
              style: TextStyle(color: Colors.black87, decoration: TextDecoration.none, fontSize: 13),
            ), constraints: BoxConstraints(
              maxWidth: 150,
              maxHeight: 40
          ),
          ),
        );
      }
      break;
    case 2:
      {
        if (elementInfo((id[0] ~/ 100), id[0] % 100).head.length +
            elementInfo((id[1] ~/ 100), id[1] % 100).head.length >
            symbols) {
          return Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 3),
            child: ConstrainedBox(
              child: Text(
                elementInfo((id[0] ~/ 100), id[0] % 100).head + '...',
                style: TextStyle(color: Colors.black87, decoration: TextDecoration.none, fontSize: 13),
              ), constraints: BoxConstraints(
                maxWidth: 150,
                maxHeight: 40
            ),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 3),
            child: ConstrainedBox(
              child: Text(
                elementInfo((id[0] ~/ 100), id[0] % 100).head +
                    ', ' +
                    elementInfo((id[1] ~/ 100), id[1] % 100).head,
                style: TextStyle( color: Colors.black87, decoration: TextDecoration.none, fontSize: 13),
              ), constraints: BoxConstraints(
                  maxWidth: 150,
                  maxHeight: 40
            ),
            ),
          );
        }
      }
      break;
    default:
      {
        if (elementInfo((id[0] ~/ 100), id[0] % 100).head.length +
            elementInfo((id[1] ~/ 100), id[1] % 100).head.length >
            symbols) {
          return ConstrainedBox(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 3),
              child: Text(
                elementInfo((id[0] ~/ 100), id[0] % 100).head + '...',
                style: TextStyle( color: Colors.black87, decoration: TextDecoration.none, fontSize: 13),
              ),
            ), constraints: BoxConstraints(
              maxWidth: 150,
              maxHeight: 40
          ),
          );
        } else {
          return ConstrainedBox(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 3),
              child: Text(
                elementInfo((id[0] ~/ 100), id[0] % 100).head +
                    ', ' +
                    elementInfo((id[1] ~/ 100), id[1] % 100).head +
                    '...',
                style: TextStyle( color: Colors.black87, decoration: TextDecoration.none, fontSize: 13),
              ),
            ), constraints: BoxConstraints(
              maxWidth: 150,
              maxHeight: 40
          ),
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
          child: Text(
            'Ожидает',
            style: TextStyle(
                color: Colors.black, decoration: TextDecoration.none, fontSize: 22,fontWeight: FontWeight.w500),
          ),
        );
      }
      break;
    case 1:
      {
        return Container(
          child: Text(
            'Подтвержден',
            style: TextStyle(
                color: Colors.black, decoration: TextDecoration.none, fontSize: 22,fontWeight: FontWeight.w500),
          ),
        );
      }
      break;
    case 2:
      {
        return Container(
          child: Text(
            'Отменен',
            style: TextStyle(
                color: Colors.black, decoration: TextDecoration.none, fontSize: 22,fontWeight: FontWeight.w500),
          ),
        );
      }
      break;
    case 4:
      {
        return Container(
          child: Text(
            'Завершен',
            style: TextStyle(
                color: Colors.black, decoration: TextDecoration.none, fontSize: 22,fontWeight: FontWeight.w500),
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

Widget def(String date, String time, String id, ElementItemOrder item) {
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
  if(different.inMinutes <= 0){
    http.get("http://eclipsedevelop.ru/api.php/cbsetstatus?token=$token&id=$id&status=4");
    print("http://eclipsedevelop.ru/api.php/cbsetstatus?token=$token&id=$id&status=4");
    return SizedBox();
  } else{
    return Container(
      child: Text(
        defferent,
        style: TextStyle(
            fontSize: 17,
            color: Colors.black87,
            decoration: TextDecoration.none),
      ),
    );
  }

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
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top:20.0),
          child: Column(children:List.generate(response2['count'], (index) {
            ElementItemOrder itemOrder = ElementItemOrder(response2['orders'][index]['order']['id'], response2['orders'][index]['order']['date'], response2['orders'][index]['order']['time'],
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
  String id;
  String date;
  String time;
  List<dynamic> ids;
  int status;

  ElementItemOrder(String id, String date, String time, List<dynamic> ids, int status){
    this.id = id;
    this.date = date;
    this.time = time;
    this.ids = ids;
    this.status = status;
  }
}

Widget ElementOrder(ElementItemOrder item, BuildContext context) {
  print("Дата контейнера "+item.date+" Время "+item.time);
  return Padding(
    padding: const EdgeInsets.all(6.0),
    child: Hero(
      tag: item.id,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white70,
          border: Border.all(width: 2, color: Color.fromRGBO(255, 164, 116, 1)),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(255, 164, 116, .4),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(-2, 3), // changes position of shadow
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width,
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 5),
                  child: StatusOrder(item.status, context),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 5, right: 10),
                  child: Container(
                      alignment: Alignment.centerRight,
                      child: def(item.date, item.time, item.id, item)),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 10, right: 10),
                    child: orders50(item.ids)),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrderDetail(item)));
                  },
                  child: Container(
                      margin: EdgeInsets.only(top: 8, right: 8),
                      padding: EdgeInsets.only(right: 18, left: 18),
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black87, width: 1)
                      ),
                      child: Center(
                          child: Text("Подробнее",
                            style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.normal),
                          )
                      )
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

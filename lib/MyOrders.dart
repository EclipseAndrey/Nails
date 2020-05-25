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
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset('assets/images/backround.png',
              fit: BoxFit.fill,),
          ),
          odresList(token, context),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18 ,),
              child: Divider(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),

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
  double fontSize = 13;
  //размер шрифта

  switch (id.length) {
    case 1:
      {
        return Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 3),
          child: ConstrainedBox(
            child: Text(
              elementInfo((id[0] ~/ 100), id[0] % 100).head,
              style: TextStyle(color: Colors.black87, decoration: TextDecoration.none, fontSize: fontSize),
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
                style: TextStyle(color: Colors.black87, decoration: TextDecoration.none, fontSize: fontSize),
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
                style: TextStyle( color: Colors.white70, decoration: TextDecoration.none, fontSize: fontSize),
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
                style: TextStyle( color: Colors.white70, decoration: TextDecoration.none, fontSize: 13),
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
                style: TextStyle( color: Colors.white70, decoration: TextDecoration.none, fontSize: 13),
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
                color: Color.fromRGBO(255, 255, 255, 30), decoration: TextDecoration.none, fontSize: 22,fontWeight: FontWeight.w500),
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
                color: Color.fromRGBO(255, 255, 255, 30), decoration: TextDecoration.none, fontSize: 22,fontWeight: FontWeight.w500),
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
                color: Color.fromRGBO(255, 255, 255, 30), decoration: TextDecoration.none, fontSize: 22,fontWeight: FontWeight.w500),
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
                color: Color.fromRGBO(255, 255, 255, 30), decoration: TextDecoration.none, fontSize: 22,fontWeight: FontWeight.w500),
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
String _month(String month) {
  switch (month) {
    case "1":
      return "Января";
      break;
    case "2":
      return "Февраля";
      break;
    case "3":
      return "Марта";
      break;
    case "4":
      return "Апреля";
      break;
    case "5":
      return "Мая";
      break;
    case "6":
      return "Июня";
      break;
    case "7":
      return "Июля";
      break;
    case "8":
      return "Августа";
      break;
    case "9":
      return "Сентября";
      break;
    case "10":
      return "Октября";
      break;
    case "11":
      return "Ноября";
      break;
    case "12":
      return "Декабря";
      break;
  }
}

String _dayOfWeek(int day){
  switch(day){
    case 1: return "Вс";
    case 2: return "Пн";
    case 3: return "Вт";
    case 4: return "Ср";
    case 5: return "Чт";
    case 6: return "Пт";
    case 7: return "Сб";
  }
}


Widget bigDay(String date, String time) {


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
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.only(top:10.0),
                  child: Column(children:List.generate(response2['count'], (index) {
                    ElementItemOrder itemOrder = ElementItemOrder(response2['orders'][index]['order']['id'], response2['orders'][index]['order']['date'], response2['orders'][index]['order']['time'],
                        response2['orders'][index]['ids'], int.parse(response2['orders'][index]['order']['status']));
                    print("JOPA " + itemOrder.id.toString());
                    return ElementOrder(itemOrder, context);
                  })
                    ,),
                ),
              ],
            ),
          ),
        ),
      ],
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

  var dateorder = item.date;
  var timeorder = item.time;

  var intlorder = new DateFormat("dd.MM.yyyy HH:mm", "en_US").parse(dateorder + " " + timeorder);






  return Padding(
    padding: const EdgeInsets.all(6.0),
    child: Hero(
      tag: item.id,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(width: 1, color: Color.fromRGBO(255, 255, 255, 80)),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.white10,
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(-2, 3), // changes position of shadow
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width*0.95,
        height: 85,
        child:
          Row(
            children: <Widget>[

              Container(
                height: 80,
                width: MediaQuery.of(context).size.width*0.95*0.15,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: <Widget>[
                    Text(_dayOfWeek(intlorder.weekday),style: TextStyle(color: Colors.white70), ),
                    Text(intlorder.day.toString(), style: TextStyle(color: Colors.white, fontSize: 26),),
                    Text(_month(intlorder.month.toString()),style: TextStyle(color: Colors.white, fontSize: 17), ),
                  ],
                ),
              ),
              Container(
                height: 84,
                width: MediaQuery.of(context).size.width*0.95*0.70,

                child: Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: <Widget>[

                            StatusOrder(item.status, context),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: orders50(item.ids),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                  height: 84,
                  width: MediaQuery.of(context).size.width*0.95*0.14,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16,)
                    ],
                  )),
            ],
          ),
      ),
    ),
  );
}

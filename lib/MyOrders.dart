import 'package:flutter/material.dart';
import 'package:flutterapp32/home.dart';
import 'package:intl/intl.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Мои заказы"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
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

Widget orders50(List<int> id) {
  //ограничение по сиволам
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
    case 1:
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
    case 2:
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
    case 3:
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
        defferent = days(different.inDays);
      }
    } else {
      // < 1 day

      if (different.inHours > 0) {
        // > 0 hour
        defferent = hours(different.inHours);
      } else {
        defferent = minutes(different.inMinutes);
      }
    }
  }

  print("Now " + new DateFormat("dd-MM-yyyy HH:mm:ss").format(now));
  print("Order " + new DateFormat("dd-MM-yyyy HH:mm:ss").format(intlorder));
  //_counter = dateorder.day.toString() ;

  return Container(
    child: Text(
      defferent,
      style: TextStyle(decoration: TextDecoration.none),
    ),
  );
}

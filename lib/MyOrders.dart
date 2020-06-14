import 'dart:convert';
import 'package:flutter/cupertino.dart';

import 'FadeAnimation.dart';

import 'package:flutter/material.dart';
import 'package:flutterapp32/home.dart';
import 'package:intl/intl.dart';
import 'dart:core';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'OrderDetail.dart';
import 'main.dart';
import 'BottomPage.dart';
import 'package:animated_text_kit/animated_text_kit.dart';




class MyOrders extends StatefulWidget {

  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> with TickerProviderStateMixin{
  String i = token;
  double shadowanim = 225;
  double paddinganim = 6.0;

  List<double> animPadding = [1];
  List<double> animColor = [1];
  List<double> animorders = [1];
  List<bool> animOpen = [true];

  List<AnimationController> controller;
  List<Animation<double>> anime;
  List<Tween> tw;

  @override
  Future<void> initState()  {
    super.initState();
    animColor.clear();
    animPadding.clear();
    animorders.clear();
    animOpen.clear();
    controller = [AnimationController(vsync: this, duration: Duration(seconds: 3))];

    tw = [Tween<double>(begin: 50, end: 0)];
    anime = [tw[0].animate(controller[0])];
    anime.clear();
    tw.clear();
    controller.clear();

    if (response2['count'] > 0) {

      for(int i = 0; i < response2['count']; i++){
        controller.add(AnimationController(vsync: this,duration: Duration(milliseconds: 200)));
      }

    }

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
            child: Column(
              children: [
                Container(
                  height: 73,
                  child: Column(
                    children: [
                      Text("Записи",
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

                  flex: 86,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[

                        Padding(
                          padding: const EdgeInsets.only(top:10.0),
                          child: Column(children:List.generate(response2['count'], (index) {
                            animPadding.add(6.0);
                            animColor.add(225);
                            animorders.add(40);
                            animOpen.add(false);

                            tw.add(Tween<double>(begin: 0, end: 90));

                            anime.add(tw[index]
                                .animate(controller[index]));

                            controller[index].addListener(() {
                              setState((){});
                            });

                            ElementItemOrder itemOrder = ElementItemOrder(response2['orders'][index]['order']['id'], response2['orders'][index]['order']['date'], response2['orders'][index]['order']['time'],
                                response2['orders'][index]['ids'], int.parse(response2['orders'][index]['order']['status']));
                            print("JOPA " + itemOrder.id.toString());
                            return ElementOrder(itemOrder, context,index, anime[index],controller[index],controller);
                          })
                            ,),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else {

      return Column(
        children: [
          Container(
            height: 73,
            child: Column(
              children: [
                Text("Записи",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 44,
                      fontFamily: "MPLUS",
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w300),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 58.0, right: 58),
                  child: Divider(
                    height: 1,
                    color: Colors.white60,
                  ),
                ),
              ],
            ),
          ),

          Text("Тут будет информация",
            style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontFamily: "MPLUS",
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w300),
          ),
          Text("о ваших записях :)",
            style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontFamily: "MPLUS",
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w300),
          ),
        ],
      );
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


  Widget buttonState(ElementItemOrder item){

    String buttonText;
    if (item.status == 0 || item.status == 1){
      buttonText = "Отменить запись";
    }
    if (item.status == 2 || item.status == 4 || item.status == 5){
      buttonText = "Удалить запись";
    }
    String id = item.id;
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0, top: 8),
    child: FlatButton(
        onPressed: (){
          if (buttonText == "Удалить запись"){
            showGeneralDialog(
                barrierColor: Colors.white.withOpacity(0.3),
                transitionBuilder: (context, a1, a2, widget) {
                  final curvedValue = Curves.easeInOutBack.transform(a1.value) -   1.0;
                  return Transform(
                    transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
                    child: Opacity(
                      opacity: a1.value,
                      child: CupertinoAlertDialog(
                        title: Text("Подтвердите"),
                        content: Text("Убрать из корзины эту услугу?"),
                        actions: [
                          CupertinoDialogAction(child: Text("Да", style: TextStyle(color: Colors.deepPurple),),onPressed: ()async{

                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return Dialog(

                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white38,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(25),
                                          topRight: Radius.circular(25),
                                          bottomLeft: Radius.circular(25),
                                          bottomRight: Radius.circular(25)
                                      ),

                                    ),
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width * 2 / 3,
                                    height: 80,
                                    child: Center(
                                      child: new CircularProgressIndicator(),
                                    ),
                                  ),

                                );
                              },
                            );
                            await http.get("http://eclipsedevelop.ru/api.php/cbdeleteorder?token=$token&id=$id");
                            print("http://eclipsedevelop.ru/api.php/cbdeleteorder?token=$token&id=$id");





                            Navigator.of(context).pop(context);
                            Navigator.of(context).pop(context);
                            Future<http.Response> res() async {
                              return await http
                                  .get('http://eclipsedevelop.ru/api.php/cbmyorders?token=$token');
                            }
                            print('http://eclipsedevelop.ru/api.php/cbmyorders?token=$token');

                            await res().then((value) {
                              if (value.statusCode == 200) {
                                response2 = jsonDecode(value.body);
                                print(response2);
                              }
                            });
                            setState(() {});

                            Scaffold.of(context).showSnackBar(SnackBar(content: Text("Запись удалена")));




                          },),
                          CupertinoDialogAction(child: Text("Нет", style: TextStyle(color: Colors.deepPurple),),onPressed: (){
                            Navigator.of(context).pop(context);
                          },)
                        ],
                      ),
                    ),
                  );
                },
                transitionDuration: Duration(milliseconds: 200),
                barrierDismissible: true,
                barrierLabel: '',
                context: context,
                pageBuilder: (context, animation1, animation2) {});

          } else{


            showGeneralDialog(
                barrierColor: Colors.white.withOpacity(0.3),
                transitionBuilder: (context, a1, a2, widget) {
                  final curvedValue = Curves.easeInOutBack.transform(a1.value) -   1.0;
                  return Transform(
                    transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
                    child: Opacity(
                      opacity: a1.value,
                      child: CupertinoAlertDialog(
                        title: Text("Подтвердите"),
                        content: Text("Отменить запись?"),
                        actions: [
                          CupertinoDialogAction(child: Text("Да", style: TextStyle(color: Colors.deepPurple),),onPressed: ()async{

                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return Dialog(

                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white38,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(25),
                                          topRight: Radius.circular(25),
                                          bottomLeft: Radius.circular(25),
                                          bottomRight: Radius.circular(25)
                                      ),

                                    ),
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width * 2 / 3,
                                    height: 80,
                                    child: Center(
                                      child: new CircularProgressIndicator(),
                                    ),
                                  ),

                                );
                              },
                            );
                            await http.get("http://eclipsedevelop.ru/api.php/cbcancelorder?token=$token&id=$id");
                            print("http://eclipsedevelop.ru/api.php/cbcancelorder?token=$token&id=$id");
                            Navigator.of(context).pop(context);
                            Navigator.of(context).pop(context);

                            Future<http.Response> res() async {
                              return await http
                                  .get('http://eclipsedevelop.ru/api.php/cbmyorders?token=$token');
                            }
                            print('http://eclipsedevelop.ru/api.php/cbmyorders?token=$token');

                            await res().then((value) {
                              if (value.statusCode == 200) {
                                response2 = jsonDecode(value.body);
                                print(response2);
                              }
                            });
                            setState(() {});


                            Scaffold.of(context).showSnackBar(SnackBar(content: Text("Запись отиенена")));




                          },),
                          CupertinoDialogAction(child: Text("Нет", style: TextStyle(color: Colors.deepPurple),),onPressed: (){
                            Navigator.of(context).pop(context);
                          },)
                        ],
                      ),
                    ),
                  );
                },
                transitionDuration: Duration(milliseconds: 200),
                barrierDismissible: true,
                barrierLabel: '',
                context: context,
                pageBuilder: (context, animation1, animation2) {});

          }

        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            side: BorderSide(color: Colors.white)),
        color: Colors.transparent,
        textColor: Colors.pinkAccent,
        child: Padding(
          padding: const EdgeInsets.only(left: 3.0, right: 3, top: 3, bottom: 3),
          child: Text(buttonText,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: "MPLUS",
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
  );
  }

  Widget ElementOrder(ElementItemOrder item, BuildContext context, int index, Animation<double> anime, AnimationController controller, List<AnimationController> contollerL) {
    print("Дата контейнера "+item.date+" Время "+item.time);




    var dateorder = item.date;
    var timeorder = item.time;

    var intlorder = new DateFormat("dd.MM.yyyy HH:mm", "en_US").parse(dateorder + " " + timeorder);







    return AnimatedPadding(


      duration: Duration(milliseconds: 200),
      padding:  EdgeInsets.only(left: 6.0, right: 6.0, top: animPadding[index],bottom: animPadding[index]),

      child: Hero(
        tag: item.id,
        child: GestureDetector(
          onTap: (){
            print("OPEN STATUS ${animOpen[index]}");
            print("Open lenght ${animOpen.length}");

            if(animOpen[index] == false){
              for(int i = 0; i < contollerL.length; i++){
                animOpen[i]=false;
                contollerL[i].reverse();
                animorders[i] = 40;
              }
              animOpen[index] = true;
              controller.forward();
              animorders[index] = 500;
            }
            else{
              animOpen[index] = !animOpen[index];
              controller.reverse();
              animorders[index] = 40;
            }
            print("OPEN STATUS ${animOpen[index]}");
            setState(() {


            });
          },

          onTapDown: (TapDownDetails details){

            setState(() {
              animPadding[index] = 12.0;
              animColor[index] = 210;
            });
          },
          onTapUp: (TapUpDetails details){
          setState(() {
            animColor[index] = 225;
            animPadding[index] = 6.0;
          });
        },
          onTapCancel: (){
            setState(() {
              animColor[index] = 225;
              animPadding[index] = 6.0;
            });
          },

          child: AnimatedContainer(

            duration: Duration(milliseconds: 500),

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
                  color: Color.fromRGBO(255, 255, 255, animColor[index]),
                  spreadRadius: 0,
                  blurRadius: 0,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width*0.95,
//            height: 85,
            child:
            Stack(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: <Widget>[

                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
//                  height: 80,
                        width: MediaQuery.of(context).size.width*0.95*0.23,

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: <Widget>[
                            Text(_dayOfWeek(intlorder.weekday),style: TextStyle(color: Colors.white70), ),
                            Text(intlorder.day.toString(), style: TextStyle(color: Colors.white, fontSize: 26),),
                            ConstrainedBox(
                                constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width*0.95*0.05, ),
                                child: Text(_month(intlorder.month.toString()),style: TextStyle(color: Colors.white, fontSize: 17), )),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
     //               height: 84,
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[

                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: StatusOrder(item.status, context),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0, top: 4.0),
                              child: orders50(item.ids, animOpen[index], index),
                            ),
                            animOpen[index]?buttonState(item):SizedBox(),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 35.0, bottom: 35, right: 20),
                        child: Transform.rotate(
                            angle: anime.value * 3.14 / 180,

                            child: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16,)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }



  Widget orders50(List<dynamic> id, bool selected, int index) {
    //ограничение по символам
    int symbols = 50;
    double fontSize = 13;
    int dura = 400;
    //размер шрифта
    Widget select (String txo, String txc){
      List<String> ltxc = [txc];
      List<String> ltxo = [txo];
      if(selected){
        return FadeAnimatedTextKit(
          duration: Duration(milliseconds: 2500),
          isRepeatingAnimation: false,
            text:ltxo, textStyle: TextStyle(color: Colors.white70,
            decoration: TextDecoration.none,
            fontSize: fontSize));
      }else{
        return  FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(txc,
            style:  TextStyle(color: Colors.white70,
                decoration: TextDecoration.none,
                fontSize: fontSize),
          ),
        );
      }
    }
    if(!selected || selected){
      switch (id.length) {
        case 1:
          {
            String txo = "" ;
            for(int i = 0; i < id.length; i++){
              print(id[i]);
              txo +=elementInfo((id[i] ~/ 100-1), id[i] % 100-1).head + "\n";
            }
            String txc = elementInfo((id[0] ~/ 100-1), id[0] % 100-1).head;


            return Padding(
              padding: const EdgeInsets.only(left: 0.0, bottom: 0),
              child: AnimatedContainer(
                duration: Duration(milliseconds: dura),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: select(txo, txc)
                ), constraints: BoxConstraints(
                  maxWidth: 150,
                  maxHeight: animorders[index]
              ),
              ),
            );
          }
          break;
        case 2:
          {
            String txo = "" ;
            for(int i = 0; i < id.length; i++){
              txo +=elementInfo((id[i] ~/ 100-1), id[i] % 100-1).head + "\n";
            }
            String txc = elementInfo((id[0] ~/ 100-1), id[0] % 100-1).head + '...';
            String txc2 =elementInfo((id[0] ~/ 100-1), id[0] % 100-1).head +
                ', \n' +
                elementInfo((id[1] ~/ 100-1), id[1] % 100-1).head;

            if (elementInfo((id[0] ~/ 100-1), id[0] % 100-1).head.length +
                elementInfo((id[1] ~/ 100-1), id[1] % 100-1).head.length >
                symbols) {
              return Padding(
                padding: const EdgeInsets.only(left: 0.0, bottom: 0),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: dura),
                  child: select(txo, txc),
                  constraints: BoxConstraints(
                    maxWidth: 150,
                    maxHeight: animorders[index]
                ),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.only(left: 0.0, bottom: 0),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: dura),
                  child: select(txo, txc),
                  constraints: BoxConstraints(
                    maxWidth: 150,
                    maxHeight: animorders[index]
                ),
                ),
              );
            }
          }
          break;
        default:
          {
            String txo = "" ;
            for(int i = 0; i < id.length; i++){
              txo +=elementInfo((id[i] ~/ 100-1), id[i] % 100-1).head + "\n";
              print ("Category ${id[i] ~/ 100-1} element ${id[i] % 100-1}");
            }
            String txc = elementInfo((id[0] ~/ 100-1), id[0] % 100-1).head + '...';
            String txc2 = elementInfo((id[0] ~/ 100-1), id[0] % 100-1).head +
                ',\n ' +
                elementInfo((id[1] ~/ 100), id[1] % 100).head +
                '...';

            if (elementInfo((id[0] ~/ 100-1), id[0] % 100-1).head.length +
                elementInfo((id[1] ~/ 100-1), id[1] % 100-1).head.length >
                symbols) {
              return AnimatedContainer(
                duration: Duration(milliseconds: dura),
                child: Padding(
                  padding: const EdgeInsets.only(left: 0.0, bottom: 0),
                  child: select(txo, txc2)
                ), constraints: BoxConstraints(
                  maxWidth: 150,
//                  maxHeight: animorders[index]
              ),
              );
            } else {
              double sz = 30+id.length.toDouble()*11;
              return AnimatedContainer(
                duration: Duration(milliseconds: dura),
                child: Padding(
                  padding: const EdgeInsets.only(left: 0.0, bottom: 0),
                  child: select(txo, txc),
                ), constraints: BoxConstraints(
                  maxWidth: 150,
                  minWidth: 50,
                  minHeight: animOpen[index]?sz:20,
                  maxHeight: animorders[index]
              ),
              );
            }
          }
          break;
      }
    }
//    else{
//
//      String tx = "" ;
//      for(int i = 0; i < id.length; i++){
//        tx +=elementInfo((id[0] ~/ 100), id[0] % 100).head + "\n";
//      }
//      return AnimatedContainer(
//        duration: Duration(milliseconds: 10400),
//        child: Padding(
//          padding: const EdgeInsets.only(left: 0.0, bottom: 0),
//          child: Text(
//            tx,
//            style: TextStyle(color: Colors.white70,
//                decoration: TextDecoration.none,
//                fontSize: 13),
//          ),
//        ), constraints: BoxConstraints(
//        maxWidth: 150,
//        maxHeight: animorders[index],
//
//      ),
//      );
//
//
//    }
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



Widget StatusOrder(int _Status, BuildContext context) {
  switch (_Status) {
    case 0:
      {
        return Container(
          child: Text(
            'Ожидание',
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
            'Подтверждено',
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
            'Отменено',
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
            'Завершено',
            style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 30), decoration: TextDecoration.none, fontSize: 22,fontWeight: FontWeight.w500),
          ),
        );
      }
      break;
    case 5:
      {
        return Container(
          child: Text(
            'Отменено оператором',
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


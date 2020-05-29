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


class Trash extends StatefulWidget {
  List<ElementItem> items;
  Trash(List<ElementItem> items) {
    this.items = items;

  }

  @override
  State<StatefulWidget> createState() {
    return _Trash();
  }
}

class _Trash extends State<Trash> with TickerProviderStateMixin {

  List<AnimationController> controller;

  String token = 'none';
  void _ii()async{
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? 'none';
  }


  int sum = 0;

  var controller1 = new MaskedTextController(mask: '+0 000 000 00 00');

  List<ElementItem> reItems = [];

  List<ElementItem> items2 = [];
  final GlobalKey<AnimatedListState> animatedListKey = GlobalKey<AnimatedListState>();
  bool resum = false;

  List<bool> okk;
  List<double> cancel;
  bool permissionCancel = true;
  Order order = Order();
  bool reorderCall = false;

  @override
  void initState() {
    _check_summ();
    _ii();
    controller1.text = "+"+num;

    super.initState();
    order.name = "";
    order.adress = "";
    order.num = "";
    order.Promo = "";
    order.comment = "Не введен";

    controller = [
      AnimationController(vsync: this, duration: Duration(seconds: 1))
    ];

    controller.clear();
    okk = [true];
    okk.clear();
    cancel = [0.0];
    cancel.clear();

    for (int i = 0; i < items.length; i++) okk.add(true);
    for (int i = 0; i < items.length; i++) cancel.add(1);
    for (int i = 0; i < items.length; i++) {
      controller.add(AnimationController(
          vsync: this, duration: Duration(milliseconds: 100)));
    }

  }

  ok() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print(items);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Запись',
          style: TextStyle(fontSize: 22, color: Colors.black),
        ),
      ),
      body: BodyTrash(order, context),
    );
  }

  Widget BodyTrash(Order order, BuildContext context) {
    if(items.length > 0){
      items2.addAll(items);
    }
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          _OrderList(),
          _TrashIsEmpty(context),
          _reorder()
        ],
      ),
    );
  }



  Widget _OrderList(){
    if (items2.length > 0 ){
      return Column(
        children: <Widget>[
          Divider(),
          Container(
            child: AnimatedList(
              shrinkWrap: true,
              key: animatedListKey,
              initialItemCount: items2.length,
              itemBuilder: (context, index, animation){
                return _buildItem(items2[index], animation, index);
              },
            ),
          ),
          _RegistrationZakaza(context, controller1),
        ],
      );
    } else return SizedBox();
  }

  Widget _reorder(){
    if(reItems.length == 0){
      Future<http.Response> res() async {
        return await http
            .get('http://eclipsedevelop.ru/api.php/cbmyorders?token=$token');
      }
      print('http://eclipsedevelop.ru/api.php/cbmyorders?token=$token');
      var response;
      res().then((value) {
        if (value.statusCode == 200) {
          response = jsonDecode(value.body);
          print(response);
          print("Count  " + response['count'].toString());

          if (response['count'] > 0) {
            List<dynamic> ids = response['orders'][0]['ids'];
            print("Кол-во проходов цикла " + ids.length.toString());
            for (int i = 0; i < ids.length; i++) {
              print("Проход " + i.toString());
              int id = ids[i];
              var item = elementInfo((id ~/ 100), id % 100);
              if (reItems.isEmpty) {
                List<ElementItem> step = [item];
                reItems = step;
              } else {
                bool find = false;
                print('find = $find');
                if (!find) {
                  reItems.add(item);
                }
              }
              print("---------------------$items2");
            }
          }
        }
      });
    }

    if (items2.length == 0 && reorderCall == true) {
      items2.addAll(reItems);
      print("111111111111$items2");
      return Column(
        children: <Widget>[
          Divider(),
          Container(
            child: AnimatedList(
              shrinkWrap: true,
              key: animatedListKey,
              initialItemCount: items2.length,
              itemBuilder: (context, index, animation){
                return _buildItem(items2[index], animation, index);
              },
            ),
          ),
          _RegistrationZakaza(context, controller1),
        ],
      );
    }
    else
      return
      SizedBox();
  }

  Widget ImagePodbor(String image) {
    if (image == '' || image == '0') {
      return Image.asset(
        'assets/images/inst.png',
      );
    } else {
      return Image.network(image);
    }
  }

  Widget _TrashIsEmpty(BuildContext context) {
    if (items2.length == 0 && reorderCall == false)
      return Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Text(
                  'Козина пуста',
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.black,
                    fontSize: 17,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    reorderCall = true;
                  });

                },
                child: Container(
                  height: 33,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.rectangle,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  child: Center(
                    child: Text(
                      'Повторить прошлую запись',
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  child: Container(
                    height: 33,
                    width: 210,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.rectangle,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Center(
                      child: Text(
                        'Перейти к выбору услуг',
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    else
      return SizedBox();
  }

  int _check_summ() {
    sum = 0;
    if(resum == true){
      setState(() {
        for (int i = 0; i < items2.length; i++) {
          sum += (items2[i].price - items2[i].sale);
        }
      });
      resum = false;
    }
  }

  Widget _RegistrationZakaza(BuildContext context, var controller1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  'Сумма: $sum руб.',
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.black,
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, bottom: 18),
            child: Text(
              'Детали записи',
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.black87,
                fontSize: 24,
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 18.0, bottom: 18),
                child: _Date(context),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, bottom: 18),
                child: _Time(context),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, bottom: 18),
            child: _Adress(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, bottom: 18),
            child: _Number(controller1),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, bottom: 18),
            child: _Name(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, bottom: 18),
            child: _Promo(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, bottom: 18),
            child: _Comment(),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Center(child: _Prise()),
          ),

          Center(child: _buttonSend()),
        ],
      );
  }
  String datetx = "Дата";

  String _month(String month){
    switch(month){
      case "1": return "января"; break;
      case "2": return "февраля"; break;
      case "3": return "марта"; break;
      case "4": return "апреля"; break;
      case "5": return "мая"; break;
      case "6": return "июня"; break;
      case "7": return "июля"; break;
      case "8": return "августа"; break;
      case "9": return "сентября"; break;
      case "10": return "октября"; break;
      case "11": return "ноября"; break;
      case "12": return "декабря"; break;
    }
  }

  Widget _Date(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: ()async{
            DateTime selectedDate = DateTime.now();

            DateTime newDateTime = await showRoundedDatePicker(context: context,
              imageHeader: AssetImage("assets/images/town.jpg"),
              theme: ThemeData(
                primaryColor: Colors.red[400],
                accentColor:    Colors.white,
                dialogBackgroundColor:  Color.fromRGBO(255, 240, 245,5),
                textTheme: TextTheme(
                  body1: TextStyle(color: Colors.black87),
                  caption: TextStyle(color: Colors.blue),
                ),
                disabledColor: Colors.orange,
                accentTextTheme: TextTheme(
                  body2 : TextStyle(color: Colors.black87),


                ),
              ),
              styleDatePicker: MaterialRoundedDatePickerStyle(
                textStyleCurrentDayOnCalendar: TextStyle(color: Colors.pink),
              ),



            );
            if (newDateTime != null && newDateTime != selectedDate)
              setState(() {
                print(newDateTime);
                order.date = newDateTime.day.toString()+"."+newDateTime.month.toString()+"."+newDateTime.year.toString();
                datetx = newDateTime.day.toString()+" "+_month(newDateTime.month.toString());
                selectedDate = newDateTime;
              });
          },
          child: Container(
            height: 43,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.rectangle,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 94,
                  child: Center(
                    child: Text(
                      datetx,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0, left: 10),
                  child: Icon(Icons.calendar_today),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String tmtx = "Время";

  Widget _Time(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: (){

            CupertinoRoundedDurationPicker.show(
              context,
              textColor: Colors.black87,
              background: Colors.white,
              borderRadius: 16,
              initialTimerDuration: Duration(minutes: 30, hours: 12),
              initialDurationPickerMode: CupertinoTimerPickerMode.hm,
              fontFamily: "Mali",
              onDurationChanged: (newDuration) {
                //
                print(newDuration);
                order.time = newDuration.inHours.toString()+":"+'${newDuration.inMinutes.toInt()%60}'.toString();
                setState(() {
                  tmtx = newDuration.inHours.toString()+":"+'${newDuration.inMinutes.toInt()%60}'.toString();
                });

              },
            );
          },
          child: Container(
            height: 43,
            width: 110,
            decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.rectangle,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
            child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      tmtx,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0, left: 10),
                      child: Icon(Icons.access_time),
                    ),
                  ],
                )),
          ),
        ),
      ],
    );
  }

  Widget _Adress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 300,
          child: Center(
            child: TextField(
              onChanged: (text) {
                print("Adress text field: $text");
                order.adress = text;
              },
              minLines: 1,
              maxLines: 15,
              decoration: inputDecorationAdress,
            ),
          ),
        ),
      ],
    );
  }

  Widget _Number(var controller) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 205,
          child: Center(
            child: TextField(

              onChanged: (text) {
                print("Num text field: $text");
                order.num = text;
              },
              keyboardType: TextInputType.phone,
              controller: controller,
              decoration: inputDecorationNumber,
            ),
          ),
        ),
      ],
    );
  }

  Widget _Name() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 180,
          child: Center(
            child: TextField(
              onChanged: (text) {
                print("Name text field: $text");
                order.name = text;
              },
              decoration: inputDecorationNamee,
            ),
          ),
        ),
      ],
    );
  }

  Widget _Comment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 300,
          child: Center(
            child: TextField(
              onChanged: (text) {
                print("Comment text field: $text");
                order.comment = text;
              },
              minLines: 3,
              maxLines: 15,
              decoration: inputDecorationComment,
            ),
          ),
        ),
      ],
    );
  }

  Widget _Promo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 180,
          child: Center(
            child: TextField(
              onChanged: (text) {
                print("Promo text field: $text");
                order.Promo = text;
              },
              decoration: inputDecorationPromo,
            ),
          ),
        ),
      ],
    );
  }

  Widget _Prise(){
      return Text(
        'Итого: $sum руб.',
        style: TextStyle(
          decoration: TextDecoration.none,
          color: Colors.black,
          fontSize: 17,
        ),
      );



  }

  Widget _buttonSend() {
    return  Container(
      height: 43,
      width: 170,
      child: FlatButton(
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(25.0),
            side: BorderSide(color: Colors.pinkAccent)),
        color: Colors.white,

        textColor: Colors.pinkAccent,
        padding: EdgeInsets.all(8.0),
        onPressed: () {
          String check = "";
          if(order.getAdress().length > 10)
          {
            print("Adress ok");
          }
          else
          {
            check = check + "Адрес ";
          }
          if( order.getNum().length > 15)
          {
            print("Num ok");
          }
          else
          {
            check = check + "Номер ";
          }
          if( order.getName().length > 1)
          {
            print("Name ok");
          }
          else
          {
            check = check + " Имя ";
          }


          if(check != ""){
          Fluttertoast.showToast(
            msg: check+"Введены неверно",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
          } else{
            String getIds(){
              String ids = '';
              for(int i = 0; i < items2.length; i++){
                ids = ids + ","+items2[i].id.toString();
              }

              return ids;
            }
            print( 'http://eclipsedevelop.ru/api.php/cbmakeorder?token=$token&ids=${getIds()}&promo=${order.Promo}&adress=${order.adress}&comment=${order.comment}&date=${order.date}&time=${order.time}&prise=$sum');
            Future<http.Response> res() async {
              return await  http.get(
                  'http://eclipsedevelop.ru/api.php/cbmakeorder?token=$token&ids=${getIds()}&promo=${order.Promo}&adress=${order.adress}&comment=${order.comment}&date=${order.date}&time=${order.time}&prise=$sum');
            }
            res().then((value){
              if(value.statusCode == 200){
                if(jsonDecode(value.body)['response'] == '14'){
                  Fluttertoast.showToast(
                    msg: check+"Отправлено",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                  );
                }
                else{
                  Fluttertoast.showToast(
                    msg: check+"В следующий раз обязательно получится",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                  );
                }
              }
            });

            }

        },
        child: Center(
          child: Text(
            'Записаться',
            style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.pink,
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(ElementItem item, Animation animation, int index){
    int count = 0;
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
          elevation: 2,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 60,
                          width: 60,
                          child: CircleAvatar(
                            backgroundImage:  NetworkImage(item.picture),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 14.0, right: 30.0),
                          child: Text(

                            item.head, style: TextStyle(fontSize: 18),),
                        ),

                      ],
                    )
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.redAccent,),
                  onPressed: (){
                    _removeItem(index);
                  },
                )
              ],
            ),
          )
      ),
    );
  }

  void _removeItem(int i){
    ElementItem removedItem = items2.removeAt(i);
    AnimatedListRemovedItemBuilder builder = (context, animation){
      return _buildItem(removedItem, animation, i);
    };

    animatedListKey.currentState.removeItem(i, builder);
    resum = true;
    _check_summ();
    print(items2);
  }
}




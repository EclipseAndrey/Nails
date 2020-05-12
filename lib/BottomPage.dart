
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'home.dart';
import 'Contacts.dart';
import 'Trash.dart';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutterapp32/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
import 'MyOrders.dart';

class BottomPage extends StatefulWidget {
  BottomPage({Key key}) : super(key: key);
  String i = token;
  @override
  _BottomPageState createState() => _BottomPageState();
}
List<ElementItem> items;
List<int> items_counter;

class _BottomPageState extends State<BottomPage> with TickerProviderStateMixin {
//home





  //MyOrders





  //Trash
  List<AnimationController> controller;

  String token = 'none';
  void _ii()async{
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? 'none';
  }



  var controller1 = new MaskedTextController(mask: '+0 000 000 00 00');


  List<ElementItem> items2  = items;
  final GlobalKey<AnimatedListState> animatedListKey = GlobalKey<AnimatedListState>();


  List<bool> okk;
  List<double> cancel;
  bool permissionCancel = true;
  Order order = Order();

  @override
  void initState() {
    items = [ElementItem(0,'','','',0,0)];
    items.clear();
    items_counter = [1];
    items_counter.clear();

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


  //Bottom
  int _selectedIndex = 2;

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  String headerTx = 'Color Bird';


 //Phone
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
 //Bottom
  void _onItemTapped(int index) {

    // call back
    if(index == 0){
     _makePhoneCall('tel:+79307229602');
    }
    if(index == 1){
      setState(() {
        headerTx = "Записи";
        _selectedIndex = index;
      });
      Future<http.Response> res() async {
        return await http
            .get('http://eclipsedevelop.ru/api.php/cbmyorders?token=$token');
      }
      print('http://eclipsedevelop.ru/api.php/cbmyorders?token=$token');

      res().then((value) {
        if (value.statusCode == 200) {
          response2 = jsonDecode(value.body);
          print(response2);
        }
      });
    }
    if(index == 2){
      setState(() {
        headerTx = "Color Bird";
        _selectedIndex = index;
      });
    }
    if(index == 3){
      setState(() {
        headerTx = "Запись";

        _selectedIndex = index;
      });
    }
    if(index == 4){
      setState(() {
        headerTx = "Информация";

        _selectedIndex = index;
      });
    }

  }


  @override
  Widget build(BuildContext context) {





    List<Widget> _widgetOptions = <Widget>[
      Text(
        'Index 0: Home',
        style: optionStyle,
      ),
      odresList(token, context),
      Categories(context),
     BodyTrash(order,context),
      Text(
        'Index 2: School',
        style: optionStyle,
      ),
    ];





//break
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title:  Text(
          headerTx,
          style: TextStyle(
//                              color: Colors.black87,
              color: Color.fromRGBO(219, 33, 76, 1),
              fontSize: 25,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w300),
        ),
      ),
      body: Container(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),

      bottomNavigationBar: BottomNavigationBar(

          type: BottomNavigationBarType.fixed,

//          fixedColor: Color.fromRGBO(250, 208, 221, 100),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.call, color: Colors.black45,),
            title: Text('Позвонить'),

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts, color: Colors.black45,),
            title: Text('Контакты'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline, color: Colors.black45,),
            title: Text('Услуги'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket, color: Colors.black45,),
            title: Text('Детали'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.black45,),
            title: Text('Аккаунт'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }


  Widget BodyTrash(Order order, BuildContext context) {



    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Divider(),
              Container(
                height: items.length * 71.toDouble(),
//                child: Column(
//                  children:
//                      List.generate(items.length, (i) => _ElementTrash(i)),
//                ),
                child: ListTrash(),
              ),
              _RegistrationZakaza(context, controller1),
            ],
          ),
          _TrashIsEmpty(context),
        ],
      ),
    );
  }

  Widget ListTrash(){
    return AnimatedList(
      key: animatedListKey,
      initialItemCount: items.length,
      itemBuilder: (context, index, animation){
        return _buildItem(items[index], animation, index);
      },
    );
  }

  Widget _ElementTrash(int i) {
    Animation<double> remove;
    Tween tween = new Tween<double>(begin: 50, end: 0);

    remove = tween.animate(controller[i]);

    @override
    void dispose(){
      controller[i].dispose();
      super.dispose();
    }

    remove.addListener(() {
      this.setState(() {});
    });
    remove.addStatusListener((status) {
      print("Remove контроллер $i активен");
      if (status == AnimationStatus.completed && okk[i]) {
        setState(() {
          print("Значение переменных контроллера $i \n  ок = ${okk[i]} \n items = ${items[i]} \n  items_counter = ${items_counter[i]}\n cancel = ${cancel[i]}\n permiss = ${permissionCancel}");
          if(okk[i]) controller.removeAt(i);
          if(okk[i]) remove = null;
          if(okk[i]) items.removeAt(i);
          //   controller[i].dispose();

          if(okk[i]) items_counter.removeAt(i);
          if(okk[i]) okk.removeAt(i);
          if(okk[i]) cancel.removeAt(i);
          if(okk[i]) permissionCancel = true;


          okk[i] = false;


        });
      }

    });

    print('generate $i');
    return Container(
      height: remove.value,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Row(

          children: <Widget>[
            Expanded(
                flex: 10,
                child: ImagePodbor(items[i].picture)),
            Expanded(
              flex: 65,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  children: <Widget>[
                    Text(items[i].head),
                    Text('${items[i].price - items[i].sale} руб.'),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 35,
              child: Row(
                children: <Widget>[
                  Opacity(
                    opacity: cancel[i],
                    child: GestureDetector(
                        onTap:(){
                          setState(() {
                            items_counter[i]++;
                          });
                        },
                        child: Icon(Icons.add_circle)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(items_counter[i].toString()),
                  ),
                  Opacity(
                    opacity: cancel[i],
                    child: GestureDetector(
                        onTap: (){
                          if(items_counter[i] == 1){
                            setState(() {
                              if(permissionCancel)
                                cancel[i] = 0.0;
                            });
                            if(permissionCancel)
                              controller[i].forward();
                            if(permissionCancel)
                              ok();
                          }else
                            setState(() {
                              items_counter[i]--;
                            });

                        },
                        child: Icon(Icons.remove_circle)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Opacity(
                      opacity: cancel[i],
                      child: GestureDetector(
                          onTap: () {
                            if(permissionCancel) {
                              permissionCancel = false;
                              setState(() {
                                cancel[i] = 0.0;
                              });
                              controller[i].forward();
                            }
                          },
                          child: Icon(Icons.cancel, color: Colors.grey,)),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
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
    if (items.length == 0)
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

                      print("Count  "+response['count'].toString());

                      if (response['count'] > 0) {

                        List<dynamic> ids = response['orders'][0]['ids'];

                        print("Кол-во проходов цикла "+ids.length.toString());
                        for(int i = 0; i < ids.length; i++){
                          print("Проход "+i.toString());
                          int id =ids[i];
                          var item = elementInfo((id ~/ 100), id % 100);

                          if(items.isEmpty){
                            items_counter = [1];
                            List<ElementItem> step = [item];
                            items = step;
                          }else{
                            bool find = false;
                            for(int i = 0 ; i  < items.length; i++){
                              print('Добавляется элемент id${item.id} проверяется элемент id${items[i].id}');
                              if(items[i].id == item.id){
                                items_counter[i]++;
                                print('Элементов id${items[i].id} - ${items_counter[i]}');
                                find = true;
                                break;
                              }
                            }
                            print('find = $find');
                            if(!find) {
                              items.add(item);
                              items_counter.add(1);
                            }


                          }


                        }
                        setState(() {

                        });
                      }else{
                        Fluttertoast.showToast(
                          msg: "У вас пока не было записей",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                        );
                      }

                    }
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
    int sum = 0;
    for (int i = 0; i < items.length; i++) {
      sum += (items[i].price - items[i].sale)*items_counter[i];
    }
    return sum;
  }

  Widget _RegistrationZakaza(BuildContext context, var controller1) {

    if (items.length > 0)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  'Сумма: ${_check_summ()} руб.',
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
    else
      return SizedBox();
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
      'Итого: ${_check_summ()} руб.',
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
            print( 'http://eclipsedevelop.ru/api.php/cbmakeorder?token=$token&ids=${getIds()}&promo=${order.Promo}&adress=${order.adress}&comment=${order.comment}&date=${order.date}&time=${order.time}&prise=${_check_summ()}');
            Future<http.Response> res() async {
              return await  http.get(
                  'http://eclipsedevelop.ru/api.php/cbmakeorder?token=$token&ids=${getIds()}&promo=${order.Promo}&adress=${order.adress}&comment=${order.comment}&date=${order.date}&time=${order.time}&prise=${_check_summ()}');
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
              children: <Widget>[
                Container(
                    height: 60,
                    width: 60,
                    child: CircleAvatar(
                      backgroundImage:  NetworkImage(item.picture),
                    )
                ),
                Container(
                  width: MediaQuery.of(context).size.width/3*1.3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 14.0, right: 30.0),
                    child: Text(

                      item.head, style: TextStyle(fontSize: 18),),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: (){
                    count++;
                  },
                ),
                Text(count.toString()),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: (){
                    count--;
                  },
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
    ElementItem removedItem = items.removeAt(i);
    AnimatedListRemovedItemBuilder builder = (context, animation){
      return _buildItem(removedItem, animation, i);
    };

    animatedListKey.currentState.removeItem(i, builder);

  }


}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp32/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import './CustomDesign/nails_icons.dart' as custicon;

import 'FadeAnimation.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  TextEditingController namecontroller = TextEditingController();

  double blurSize = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Color.fromRGBO(34, 15, 45, 1),
                  Color.fromRGBO(34, 15, 45, 0.8),
                  Color.fromRGBO(34, 15, 45, 0.5)
                ]
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FadeAnimation(0.4, Text(ResName, style: TextStyle(color: Colors.white, fontSize: 40),)),
                      SizedBox(height: 10,),
                      FadeAnimation(0.6, Text("Добро пожаловать", style: TextStyle(color: Colors.white, fontSize: 18),)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: Icon(Icons.local_post_office, color: Colors.white,),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: FadeAnimation(
                      0.4,
                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(30),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [BoxShadow(
                                        color: Color.fromRGBO(34, 15, 45, .3),
                                        blurRadius: blurSize,
                                        offset: Offset(-2.5, 5)
                                    )]
                                ),
                                width: MediaQuery.of(context).size.width*0.84,
                                height: MediaQuery.of(context).size.width*0.20,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 12.0, left: 18),
                                          child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text("Записи", style: TextStyle(fontSize: 18),)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 13.0, right: 18),
                                          child: Icon(custicon.Nails.bookmark_empty),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0, left: 18, ),
                                      child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text("Ближайшая запись: 25 июля", style: TextStyle(fontSize: 16, color: Colors.green),)),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 18.0),
                              child: Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [BoxShadow(
                                            color: Color.fromRGBO(34, 15, 45, .3),
                                            blurRadius: blurSize,
                                            offset: Offset(-2.5, 5)
                                        )]
                                    ),
                                    width: MediaQuery.of(context).size.width*0.40,
                                    height: MediaQuery.of(context).size.width*0.20,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                         Padding(
                                           padding: const EdgeInsets.only(top: 14.0, left: 18, ),
                                           child: FittedBox(
                                               fit: BoxFit.scaleDown,
                                               child: Text("Бонусы", style: TextStyle(fontSize: 18, color: Colors.black),)),
                                         ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 14.0, left: 18, ),
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,

                                              child: Text("228", style: TextStyle(fontSize: 18, color: Colors.redAccent),)),
                                        ),

                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [BoxShadow(
                                            color: Color.fromRGBO(34, 15, 45, .3),
                                            blurRadius: blurSize,
                                            offset: Offset(-2.5, 5)
                                        )]
                                    ),
                                    width: MediaQuery.of(context).size.width*0.40,
                                    height: MediaQuery.of(context).size.width*0.20,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 14.0, left: 18,right: 12 ),
                                          child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text("История бонусов", style: TextStyle(fontSize: 18, color: Colors.black),)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 14.0, left: 18, ),
                                          child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text("0", style: TextStyle(fontSize: 18, color: Colors.black54),)),
                                        ),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 18.0),
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.of(context).pushNamed('/Addresses');
                                  },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [BoxShadow(
                                          color: Color.fromRGBO(34, 15, 45, .3),
                                          blurRadius: blurSize,
                                          offset: Offset(-2.5, 5)
                                      )]
                                  ),
                                  width: MediaQuery.of(context).size.width*0.84,
                                  height: MediaQuery.of(context).size.width*0.15,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 18.0),
                                        child: Row(
                                          children: [
                                            Icon(Icons.location_on, color: Colors.black54,),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 14.0),
                                              child: Text(
                                                "Адреса", style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18
                                              ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 18.0),
                              child: GestureDetector(
                                onTap: (){
                                  showGeneralDialog(
                                      barrierColor: Colors.black.withOpacity(0.3),
                                      transitionBuilder: (context, a1, a2, widget) {
                                        final curvedValue = Curves.easeInOutBack.transform(a1.value) -   1.0;
                                        return Transform(
                                          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
                                          child: Opacity(
                                            opacity: a1.value,
                                            child: CupertinoAlertDialog(
                                              title: Text("Редактирование"),
                                              content: Padding(
                                                padding: const EdgeInsets.only(top: 0.0),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 8.0),
                                                      child: Text("Введите новое имя"),
                                                    ),
                                                    Material(
                                                      color: Colors.transparent,
                                                      child: TextField(
                                                        decoration: InputDecoration(
                                                            hintText: "Имя"
                                                        ),
                                                      ),
                                                    )
                                                  ],

                                                ),
                                              ),
                                              actions: [
                                                CupertinoDialogAction(child: Text("Отмена", style: TextStyle(color: Colors.deepPurple),),onPressed: (){
                                                  Navigator.of(context).pop(context);
                                                },),
                                                CupertinoDialogAction(child: Text("Применить", style: TextStyle(color: Colors.deepPurple),),onPressed: (){
                                                  Navigator.of(context).pop(context);

                                                  showGeneralDialog(
                                                      barrierColor: Colors.black.withOpacity(0.3),
                                                      transitionBuilder: (context, a1, a2, widget) {
                                                        final curvedValue = Curves.easeInOutBack.transform(a1.value) -   1.0;
                                                        return Transform(
                                                          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
                                                          child: Opacity(
                                                            opacity: a1.value,
                                                            child: CupertinoAlertDialog(
                                                              title: Text("Имя изменено"),

                                                              actions: [
                                                                CupertinoDialogAction(child: Text("Ок", style: TextStyle(color: Colors.deepPurple),),onPressed: (){
                                                                  Navigator.of(context).pop(context);
                                                                },),

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
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [BoxShadow(
                                          color: Color.fromRGBO(34, 15, 45, .3),
                                          blurRadius: blurSize,
                                          offset: Offset(-2.5, 5)
                                      )]
                                  ),
                                  width: MediaQuery.of(context).size.width*0.84,
                                  height: MediaQuery.of(context).size.width*0.15,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 18.0),
                                        child: Row(
                                          children: [
                                            Icon(Icons.person, color: Colors.black54,),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 14.0),
                                              child: Text(
                                                "Изменить имя", style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18
                                              ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 18.0),
                              child: GestureDetector(
                                onTap: (){
                                  showGeneralDialog(
                                      barrierColor: Colors.black.withOpacity(0.3),
                                      transitionBuilder: (context, a1, a2, widget) {
                                        final curvedValue = Curves.easeInOutBack.transform(a1.value) -   1.0;
                                        return Transform(
                                          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
                                          child: Opacity(
                                            opacity: a1.value,
                                            child: CupertinoAlertDialog(
                                              title: Text("Бонусная программа"),
                                              content: Padding(
                                                padding: const EdgeInsets.only(top: 0.0),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 8.0),
                                                      child: Text("Вашему другу будет отправлено приглашение в приложение.\n"
                                                      "Ваш лимит : 5"),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 8.0),
                                                      child: Text("Подробнее", style: TextStyle(color: Colors.blue),),
                                                    ),
                                                    Material(
                                                      color: Colors.transparent,
                                                      child: TextField(
                                                        keyboardType: TextInputType.number,
                                                        decoration: InputDecoration(
                                                          hintText: "Номер друга"
                                                        ),
                                                      ),
                                                    )
                                                  ],

                                                ),
                                              ),
                                              actions: [
                                                CupertinoDialogAction(child: Text("Отмена", style: TextStyle(color: Colors.deepPurple),),onPressed: (){
                                                  Navigator.of(context).pop(context);
                                                },),
                                                CupertinoDialogAction(child: Text("Позвать", style: TextStyle(color: Colors.deepPurple),),onPressed: (){
                                                  Navigator.of(context).pop(context);

                                                  showGeneralDialog(
                                                      barrierColor: Colors.black.withOpacity(0.3),
                                                      transitionBuilder: (context, a1, a2, widget) {
                                                        final curvedValue = Curves.easeInOutBack.transform(a1.value) -   1.0;
                                                        return Transform(
                                                          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
                                                          child: Opacity(
                                                            opacity: a1.value,
                                                            child: CupertinoAlertDialog(
                                                              title: Text("Готово"),
                                                              content: Text("Готово"),
                                                              actions: [
                                                                CupertinoDialogAction(child: Text("Готово", style: TextStyle(color: Colors.deepPurple),),onPressed: (){
                                                                  Navigator.of(context).pop(context);
                                                                },),

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
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [BoxShadow(
                                          color: Color.fromRGBO(34, 15, 45, .3),
                                          blurRadius: blurSize,
                                          offset: Offset(-2.5, 5)
                                      )]
                                  ),
                                  width: MediaQuery.of(context).size.width*0.84,
                                  height: MediaQuery.of(context).size.width*0.15,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 18.0),
                                        child: Row(
                                          children: [
                                            Icon(Icons.person_add, color: Colors.black54,),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 14.0),
                                              child: Text(
                                                "Позвать друга", style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18
                                              ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 18.0),
                              child: GestureDetector(
                                onTap: (){
                                  showGeneralDialog(
                                      barrierColor: Colors.black.withOpacity(0.3),
                                      transitionBuilder: (context, a1, a2, widget) {
                                        final curvedValue = Curves.easeInOutBack.transform(a1.value) -   1.0;
                                        return Transform(
                                          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
                                          child: Opacity(
                                            opacity: a1.value,
                                            child: CupertinoAlertDialog(
                                              title: Text("Получить VIP-статус"),
                                              content: Text("Вы получите неограниченное количество записей м доступ к секретным промокодам"),
                                              actions: [
                                                CupertinoDialogAction(child: Text("Отмена", style: TextStyle(color: Colors.deepPurple),),onPressed: (){
                                                  Navigator.of(context).pop(context);
                                                },),
                                                CupertinoDialogAction(child: Text("Получить", style: TextStyle(color: Colors.deepPurple),),onPressed: (){
                                                  Navigator.of(context).pop(context);

                                                  showGeneralDialog(
                                                      barrierColor: Colors.black.withOpacity(0.3),
                                                      transitionBuilder: (context, a1, a2, widget) {
                                                        final curvedValue = Curves.easeInOutBack.transform(a1.value) -   1.0;
                                                        return Transform(
                                                          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
                                                          child: Opacity(
                                                            opacity: a1.value,
                                                            child: CupertinoAlertDialog(
                                                              title: Text("Получить VIP-статус"),
                                                              content: Text("Вам придет оповещение, когда вип статус будет подключен"),
                                                              actions: [
                                                                CupertinoDialogAction(child: Text("Хорошо", style: TextStyle(color: Colors.deepPurple),),onPressed: (){
                                                                  Navigator.of(context).pop(context);
                                                                },),

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
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [BoxShadow(
                                          color: Color.fromRGBO(34, 15, 45, .3),
                                          blurRadius: blurSize,
                                          offset: Offset(-2.5, 5)
                                      )]
                                  ),
                                  width: MediaQuery.of(context).size.width*0.84,
                                  height: MediaQuery.of(context).size.width*0.15,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 18.0),
                                        child: Row(
                                          children: [
                                            Icon(Icons.star_border, color: Colors.black54,),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 14.0),
                                              child: Text(
                                                "Получить VIP-статус", style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18
                                              ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 18.0),
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.of(context).pushNamed('/Helping');

                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [BoxShadow(
                                          color: Color.fromRGBO(34, 15, 45, .3),
                                          blurRadius: blurSize,
                                          offset: Offset(-2.5, 5)
                                      )]
                                  ),
                                  width: MediaQuery.of(context).size.width*0.84,
                                  height: MediaQuery.of(context).size.width*0.15,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 18.0),
                                        child: Row(
                                          children: [
                                            Icon(Icons.help_outline, color: Colors.black54,),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 14.0),
                                              child: Text(
                                                "Помощь", style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18
                                              ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),





                            SizedBox(height: 20,),
                            FadeAnimation(0.8,
                                  GestureDetector(
                                      onTap: ()async{

                                        final prefs = await SharedPreferences
                                            .getInstance();
                                        prefs.setBool('auto', false);
                                        Navigator.pushNamed(context, '/Login');


                                      },
                                      child: Text("Сменить аккаунт", style: TextStyle(fontSize: 20, color: Colors.redAccent),)
                                  )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutterapp32/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'FadeAnimation.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  TextEditingController namecontroller = TextEditingController();

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(1, Text(ResName, style: TextStyle(color: Colors.white, fontSize: 40),)),
                  SizedBox(height: 10,),
                  FadeAnimation(1.3, Text("Добро пожаловать", style: TextStyle(color: Colors.white, fontSize: 18),)),
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
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        Text("Параметры автозаполнения", style: TextStyle(color: Colors.black87, fontSize: 18),),
                        SizedBox(height: 20,),
                        FadeAnimation(1.4, Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [BoxShadow(
                                  color: Color.fromRGBO(34, 15, 45, .3),
                                  blurRadius: 20,
                                  offset: Offset(0, 10)
                              )]
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                ),
                                child: TextField(
                                  controller: namecontroller,
                                  decoration: InputDecoration(
                                      hintText: "Имя",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                        SizedBox(height: 20,),
                        FadeAnimation(1.4, Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [BoxShadow(
                                  color: Color.fromRGBO(34, 15, 45, .3),
                                  blurRadius: 20,
                                  offset: Offset(0, 10)
                              )]
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                      hintText: "Адрес",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                        SizedBox(height: 40,),
                        GestureDetector(
                          onTap: () async {

                            print('http://eclipsedevelop.ru/api.php/cbsetname?name=${namecontroller.text}&token=$token');
                            var a = await http.get(
                                'http://eclipsedevelop.ru/api.php/cbsetname?name=${namecontroller.text}&token=$token');

                            ResName = namecontroller.text;
                            await a;
                            setState(() {

                            });

                            Scaffold.of(context).showSnackBar(new SnackBar(
                              content: new Text('Успешно'),
                            ));
                            //==========================================================
                          },
                          child: FadeAnimation(1.6, Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color.fromRGBO(68, 30, 90, 0.8)
                            ),
                            child: Center(
                              child: Text("Применить", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
                            ),
                          )),
                        ),
                        SizedBox(height: 20,),
                        FadeAnimation(1.5,
                              GestureDetector(
                                  onTap: ()async{

                                    final prefs = await SharedPreferences
                                        .getInstance();
                                    prefs.setBool('auto', false);
                                    Navigator.pushNamed(context, '/Login');


                                  },
                                  child: Text("Сменить аккаунт", style: TextStyle(fontSize: 18, color: Colors.grey),)
                              )
                        ),
                      ],
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

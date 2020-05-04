import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'FadeAnimation.dart';

class CheckCode extends StatefulWidget {
  String num;
  CheckCode(this.num);
  @override
  State<StatefulWidget> createState() {
    return _CheckCodeState(this.num);
  }
}

class _CheckCodeState extends State<CheckCode> {
  String num;
  _CheckCodeState(this.num);
  TextEditingController _codecontroller = new TextEditingController();
  bool check = true;
  String title = "Проверка кода";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Color.fromRGBO(255, 182, 173, 1),
                  Color.fromRGBO(255, 182, 173, 0.8),
                  Color.fromRGBO(255, 182, 173, 0.5)
                ]
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 80,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(1, Text(title, style: TextStyle(color: Colors.white, fontSize: 40),)),
                  SizedBox(height: 10,),
                  FadeAnimation(1.3, Text("Введите код подтверждения", style: TextStyle(color: Colors.white, fontSize: 18),)),
                ],
              ),
            ),
            SizedBox(height: 20),
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
                        SizedBox(height: 60,),
                        FadeAnimation(1.4, Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [BoxShadow(
                                  color: Color.fromRGBO(225, 95, 27, .3),
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
                                child: Row(
                                  children: <Widget>[
                                    TextField(
                                      controller: _codecontroller,
                                      autofocus: true,
                                      decoration: InputDecoration(

                                          border: InputBorder.none
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                        SizedBox(height: 40,),
                        FadeAnimation(1.6, Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color.fromRGBO(255, 182, 173, 1)
                          ),
                          child: GestureDetector(
                            onTap: ()  {
                              String code = _codecontroller.text;
                              var res = http.get('http://eclipsedevelop.ru/api.php/cbcheckcode?num=$num&code=$code');
                              print(res);
                            },
                            child: Center(
                              child: Text("Подтвердить", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
                            ),
                          ),
                        )),
                        SizedBox(height: 40,),
                        FadeAnimation(1.5,
                              GestureDetector(
                                  onTap: (){
                                    String code = _codecontroller.text;
                                    var res = http.get('http://eclipsedevelop.ru/api.php/cbcheckcode?num=$num&code=$code');
                                  },
                                  child: Text("Отправить код повторно", style: TextStyle(fontSize: 18, color: Colors.grey),)
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

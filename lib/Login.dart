import 'package:flutter/material.dart';
import 'package:flutterapp32/CheckCode.dart';
import 'package:http/http.dart' as http;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'FadeAnimation.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var maskFormatter = new MaskTextInputFormatter(mask: '(###) ###-##-##', filter: { "#": RegExp(r'[0-9]') });
  TextEditingController _numcontroller = new TextEditingController();
  bool check = true;
  String title = "Вход";
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
                  FadeAnimation(1.3, Text("Добро пожаловать", style: TextStyle(color: Colors.white, fontSize: 18),)),
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
                                child: TextField(
                                  inputFormatters: [maskFormatter],
                                  autofocus: true,
                                  decoration: InputDecoration(
                                      prefix: Text('+7 '),
                                      hintText: "Номер телефона",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none
                                  ),
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
                            onTap: () async {
                              String num = maskFormatter.getUnmaskedText();
                              print(num);
                              var response = await http.get('http://eclipsedevelop.ru/api.php/cbgetcode?num=+$num');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CheckCode(num)));
                            },
                            child: Center(
                              child: Text("Далее", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
                            ),
                          ),
                        )),
                        SizedBox(height: 40,),
                        FadeAnimation(1.5,
                            (
                            check ?
                            GestureDetector(
                                onTap: (){
                                  title = "Регистрация";
                                  setState(() {
                                    check = false;
                                  });
                                },
                                child: Text("Еще нет аккаунта? Создать!", style: TextStyle(fontSize: 18, color: Colors.grey),)
                            )
                            :
                            GestureDetector(
                                onTap: (){
                                  title = "Вход";
                                  setState(() {
                                    check = true;
                                  });
                                },
                                child: Text("Уже есть аккаунт? Войти!", style: TextStyle(fontSize: 18, color: Colors.grey),)
                            )
                            ),
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

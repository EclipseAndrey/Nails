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

  Future<void> _ackAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Not in stock'),
          content: const Text('This item is no longer available'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  void _onLoading() async {
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
            width: MediaQuery.of(context).size.width*2/3,
            height: 80,
            child: Center(
              child: new CircularProgressIndicator(),
          ),
          ),

        );
      },
    );
    new  Future.delayed(new Duration(seconds: 3), () async {

      String num = maskFormatter.getUnmaskedText();
      print(num);
      var response = await http.get('http://eclipsedevelop.ru/api.php/cbgetcode?num=7$num');
      print('http://eclipsedevelop.ru/api.php/cbgetcode?num=7$num');
      Navigator.of(context).pop();

      Navigator.push(context, MaterialPageRoute(builder: (context) => CheckCode(num)));

    });
  }



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
                  Color.fromRGBO(255, 188, 173, 1),
                  Color.fromRGBO(255, 188, 173, 0.8),
                  Color.fromRGBO(255, 188, 173, 0.5)
                ]
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 60,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(1, Text(title, style: TextStyle(color: Colors.white, fontSize: 40),)),
                  SizedBox(height: 10,),
                  FadeAnimation(1.3, Text("Добро пожаловать", style: TextStyle(color: Colors.white, fontSize: 20),)),
                  SizedBox(height: 30,)
                ],
              ),
            ),
            Expanded(
              flex: 2,
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
                        SizedBox(height: 70,),
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
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [maskFormatter],
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
                        SizedBox(height: 60,),
                        GestureDetector(
                          onTap: () async {
                            _onLoading();

                          },
                          child: FadeAnimation(1.6, Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromRGBO(255, 188, 173, 1)
                            ),
                            child: Center(
                              child: Text("Далее", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
                            ),
                          )),
                        ),
                        SizedBox(height: 20,),
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
                                child: Container(
                                  height: 40,
                                  width: 230,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Color.fromRGBO(255, 188, 173, 1), width: 1)
                                  ),
                                  child: Center(child: Text("Создать аккаунт", style: TextStyle(fontSize: 18, color: Color.fromRGBO(255, 188, 173, 1), fontWeight: FontWeight.normal),)))
                            )
                            :
                            GestureDetector(
                                onTap: (){
                                  title = "Вход";
                                  setState(() {
                                    check = true;
                                  });
                                },
                                child: Container(
                                    height: 40,
                                    width: 230,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: Color.fromRGBO(255, 188, 173, 1), width: 1)
                                    ),
                                    child: Center(child: Text("Войти", style: TextStyle(fontSize: 18, color: Color.fromRGBO(255, 188, 173, 1), fontWeight: FontWeight.normal),)))
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

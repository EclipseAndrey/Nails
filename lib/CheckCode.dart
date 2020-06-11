import 'dart:convert';
import 'package:numeric_keyboard/numeric_keyboard.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'FadeAnimation.dart';
import 'SetName.dart';

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

  final FocusNode _focus1 = FocusNode();
  final FocusNode _focus2 = FocusNode();
  final FocusNode _focus3 = FocusNode();
  final FocusNode _focus4 = FocusNode();
  TextEditingController _codecontroller1 = new TextEditingController();
  TextEditingController _codecontroller2 = new TextEditingController();
  TextEditingController _codecontroller3 = new TextEditingController();
  TextEditingController _codecontroller4 = new TextEditingController();
  bool check = true;
  String title = "Проверка кода";
  String text = '';

  void _onKeyboardTap(String value) {
    setState(() {
      text = text + value;
    });
  }


  Widget numberWidget(int position) {
    try {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))
        ),
        child: Center(child: Text(
          text[position], style: TextStyle(color: Colors.black),)),
      );
    } catch (e) {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
      new Future.delayed(new Duration(seconds: 3), () async {
        final prefs = await SharedPreferences
            .getInstance();
        if (text.length == 4) {
          print(
              'http://eclipsedevelop.ru/api.php/cbcheckcode?num=7$num&code=$text');
          Future<http.Response> fetchAlbum() async {
            return await http.get(
                'http://eclipsedevelop.ru/api.php/cbcheckcode?num=7$num&code=$text');
          }

          fetchAlbum().then((value) {
            if (value.statusCode == 200) {
              Navigator.of(context).pop();

              print(value.body);
              var res = value.body;
              var response = jsonDecode(res);
              // ignore: non_constant_identifier_names
              String Response = response["response"];
              // ignore: unrelated_type_equality_checks
              if (Response == "3") {
                String token = response["token"];
                void inf() async {
                  prefs.setBool('auto', true);
                  prefs.setString('token', token);
                  prefs.setString('num', "7" + num);

                  Navigator.of(context)
                      .pushReplacementNamed('/main');
                }

                inf();
              }
              // ignore: unrelated_type_equality_checks
              if (Response == "5") {
                String token = response["token"];
                void inf() async {
                  final prefs = await SharedPreferences
                      .getInstance();
                  prefs.setBool('auto', true);
                  prefs.setString('token', token);
                  Navigator.of(context)
                      .pushReplacementNamed('/SetName');
                }

                inf();
              }
              // ignore: unrelated_type_equality_checks
              if (Response == "4") {
                print('Code don\'t verification');
              }
            }
            else {
              print(value.statusCode);
            }
          });
        } else {
          //Если код не введен
        }
      });
    }

    return Scaffold(


      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                Color.fromRGBO(34, 15, 45, 1),
                Color.fromRGBO(34, 15, 45, 0.8),
                Color.fromRGBO(34, 15, 45, 0.5)
              ])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                              Radius.circular(50)),
                          color: Color.fromRGBO(34, 15, 45,
                              1), //Если че можно задать фон кнопки назад
                        ),
                        child: IconButton(
                          icon: Container(
                            child: Icon(
                              Icons.arrow_back, color: Colors.white, size: 32,),
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            FadeAnimation(
                                1,
                                Text(
                                  title,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 40),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            FadeAnimation(
                                1.3,
                                Text(
                                  "Введите код подтверждения",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60))
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              constraints: const BoxConstraints(
                                  maxWidth: 500
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  numberWidget(0),
                                  numberWidget(1),
                                  numberWidget(2),
                                  numberWidget(3),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      GestureDetector(
                        onTap: () async {
                          _onLoading();
                        },
                        child: FadeAnimation(1.6, Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromRGBO(54, 25, 58, 1)
                          ),
                          child: Center(
                            child: Text("Подтвердить", style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),),
                          ),
                        )),
                      ),
                      SizedBox(height: 10,),
                      NumericKeyboard(
                        onKeyboardTap: _onKeyboardTap,
                        textColor: Color.fromRGBO(34, 15, 45, 1),
                        rightIcon: Icon(
                          Icons.backspace,
                          color: Color.fromRGBO(34, 15, 45, 1),
                        ),
                        rightButtonFn: () {
                          setState(() {
                            text = text.substring(0, text.length - 1);
                          });
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

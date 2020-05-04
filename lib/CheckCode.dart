import 'dart:convert';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Color.fromRGBO(255, 182, 173, 1),
          Color.fromRGBO(255, 182, 173, 0.8),
          Color.fromRGBO(255, 182, 173, 0.5)
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                      1,
                      Text(
                        title,
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                      1.3,
                      Text(
                        "Введите код подтверждения",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 60,
                        ),
                        FadeAnimation(
                            1.4,
                            Container(
                              padding: EdgeInsets.only(left: 90, right: 40),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 20,
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      focusNode: _focus1,
                                      onChanged: (text) {
                                        String a = _codecontroller1.text;
                                        if (a.length == 1) {
                                          _fieldFocusChange(
                                              context, _focus1, _focus2);
                                        }
                                      },
                                      controller: _codecontroller1,
                                      autofocus: true,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Container(
                                    width: 20,
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
                                      focusNode: _focus2,
                                      onChanged: (text) {
                                        String a = _codecontroller2.text;
                                        if (a.length == 1) {
                                          _fieldFocusChange(
                                              context, _focus2, _focus3);
                                        }
                                        if (a.length == 0) {
                                          _fieldFocusChange(
                                              context, _focus2, _focus1);
                                        }
                                      },
                                      controller: _codecontroller2,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Container(
                                    width: 20,
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
                                      focusNode: _focus3,
                                      onChanged: (text) {
                                        String a = _codecontroller3.text;
                                        if (a.length == 1) {
                                          _fieldFocusChange(
                                              context, _focus3, _focus4);
                                        }
                                        if (a.length == 0) {
                                          _fieldFocusChange(
                                              context, _focus3, _focus2);
                                        }
                                      },
                                      controller: _codecontroller3,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Container(
                                    width: 20,
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
                                      focusNode: _focus4,
                                      onChanged: (text) {
                                        String a = _codecontroller4.text;
                                        if (a.length == 0) {
                                          _fieldFocusChange(
                                              context, _focus4, _focus3);
                                        }
                                      },
                                      controller: _codecontroller4,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        SizedBox(
                          height: 40,
                        ),
                        FadeAnimation(
                            1.6,
                            Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(horizontal: 50),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Color.fromRGBO(255, 182, 173, 1)),
                              child: GestureDetector(
                                onTap: () async {
                                  final prefs = await SharedPreferences
                                      .getInstance();
                                  if ('${_codecontroller1.text + _codecontroller2.text + _codecontroller3.text + _codecontroller4.text}'.length ==4) {
                                    print('http://eclipsedevelop.ru/api.php/cbcheckcode?num=+7$num&code=${_codecontroller1.text + _codecontroller2.text + _codecontroller3.text + _codecontroller4.text}');
                                    Future<http.Response> fetchAlbum() async {
                                      return await http.get('http://eclipsedevelop.ru/api.php/cbcheckcode?num=+7$num&code=${_codecontroller1.text + _codecontroller2.text + _codecontroller3.text + _codecontroller4.text}');
                                    }

                                    fetchAlbum().then((value) {
                                      if(value.statusCode == 200){
                                        print(value.body);
                                        var res  = value.body;
                                        var response = jsonDecode(res);
                                        // ignore: non_constant_identifier_names
                                        String Response = response["response"];
                                        // ignore: unrelated_type_equality_checks
                                        if (Response == "3") {
                                          String token = response["token"];
                                          void inf() async {
                                            prefs.setBool('auto', true);
                                            prefs.setString('token', token);
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
                                      else{
                                        print(value.statusCode);
                                      }
                                    });


                                  } else {
                                    //Если код не введен
                                  }
                                },
                                child: Center(
                                  child: Text(
                                    "Отправить",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                            )),
                        SizedBox(
                          height: 40,
                        ),
                        FadeAnimation(
                            1.5,
                            GestureDetector(
                                onTap: () {
                                  var res = http.get(
                                      'http://eclipsedevelop.ru/api.php/cbgetcode?num=+7$num');
                                },
                                child: Text(
                                  "Отправить код повторно",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey),
                                ))),
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

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}

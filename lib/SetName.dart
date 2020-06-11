import 'package:flutter/material.dart';
import 'package:flutterapp32/CheckCode.dart';
import 'package:http/http.dart' as http;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'FadeAnimation.dart';

class SetName extends StatefulWidget {
  @override
  _SetNameState createState() => _SetNameState();
}

class _SetNameState extends State<SetName> {


  TextEditingController _numcontroller = new TextEditingController();

  bool check = true;
  String title = "Введите имя";
  @override
  Widget build(BuildContext context) {
    _numcontroller.addListener(() {
      print(_numcontroller.text);
    });
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
                                  controller: _numcontroller,
                                  autofocus: true,
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
                        SizedBox(height: 40,),
                        FadeAnimation(1.6, GestureDetector(
                          onTap: () async {
                            print(num);
                            final prefs = await SharedPreferences.getInstance();
                            final token = prefs.getString('token') ?? 'none';

                            Future<http.Response> fetchAlbum() async {
                              print('http://eclipsedevelop.ru/api.php/cbsetname?name=${_numcontroller.text}&token=$token');
                              return await http.get(
                                  'http://eclipsedevelop.ru/api.php/cbsetname?name=${_numcontroller.text}&token=$token');
                            }

                            fetchAlbum().then((value) {
                              if(value.statusCode == 200){
                                Navigator.of(context)
                                    .pushReplacementNamed('/main');
                              }});

                          },
                          child: Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color.fromRGBO(25, 1, 58, 1)
                            ),
                            child: Center(
                              child: Text("Далее", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
                            ),
                          ),
                        )),
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

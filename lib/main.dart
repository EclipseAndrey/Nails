import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'dart:async';

import 'package:flutterapp32/Quality.dart';
import 'package:flutterapp32/home.dart';
import 'package:flutterapp32/Eclipse.dart';
import 'package:flutterapp32/Info.dart';
import 'package:flutterapp32/Contacts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main(){

  final routes = <String, WidgetBuilder>{
    // Путь, по которому создаётся Home Screen
    '/Quality': (BuildContext context) => Quality(),
    '/home': (BuildContext context) => Home(),
    '/Info': (BuildContext context) =>Info(),
    '/Eclipse': (BuildContext context) =>Eclipse(),
    '/Contacts': (BuildContext context) =>Contacts(),
  };

runApp(
  MaterialApp(

    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      DefaultCupertinoLocalizations.delegate,
    ],
    supportedLocales: [
      const Locale('en', 'US'), // English
      const Locale('th', 'TH'), // Thai
      const Locale("ru", "RU"),
    ],
    home: SplashScreen(nextRoute:
    '/Info',
    ),
    debugShowCheckedModeBanner: false,
    routes: routes,


  )
);
}


class SplashScreen extends StatefulWidget {
  final String nextRoute;
  SplashScreen({this.nextRoute});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>  {



  void inf()async{

    final prefs = await SharedPreferences.getInstance();

    final info = prefs.getBool('info') ?? false;

    if(info){
      Navigator.of(context).pushReplacementNamed('/home');
    }else{
      Navigator.of(context).pushReplacementNamed(widget.nextRoute);
    }

  }


  @override
  void initState() {

    super.initState();
    // Создаём таймер, который должен будет переключить SplashScreen на HomeScreen через 2 секунды
    Timer(
        Duration(seconds: 2),
        // Для этого используется статический метод навигатора
        // Это очень похоже на передачу лямбда функции в качестве аргумента std::function в C++
            () {
          inf();
            }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 230, 229, 1),
      body: Center(
        child: Container(
          padding: EdgeInsets.only(bottom: 60,right: 23),
          child: Image.network('https://static.tildacdn.com/tild3230-6134-4236-b864-353236306434/Logo02102018.png',width: 300,height: 300, ),
        ),

      ),
    );
  }
}


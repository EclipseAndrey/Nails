import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp32/Login.dart';
import 'package:flutterapp32/MyOrders.dart';
import 'package:flutterapp32/SetName.dart';
import 'dart:core';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'Trash.dart';
import 'package:flutterapp32/Quality.dart';
import 'package:flutterapp32/home.dart';
import 'package:flutterapp32/Eclipse.dart';
import 'package:flutterapp32/Info.dart';
import 'package:flutterapp32/Contacts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'BottomPage.dart';
import 'package:intl/intl.dart';
import 'Objects.dart';
import 'CheckCode.dart';
import 'Detail.dart';
import 'package:flutter_rounded_progress_bar/flutter_icon_rounded_progress_bar.dart';
import 'package:percent_indicator/percent_indicator.dart';

void main(){

  final routes = <String, WidgetBuilder>{
    // Путь, по которому создаётся Home Screen
    '/CheckCode': (BuildContext context) => CheckCode(''),
    '/Quality': (BuildContext context) => Quality(),
    '/MyOrders': (BuildContext context) => MyOrders(),
    '/Login': (BuildContext context) => Login(),
    '/home': (BuildContext context) => Home(),
    '/Info': (BuildContext context) =>Info(),
    '/Eclipse': (BuildContext context) =>Eclipse(),
    '/main': (BuildContext context) =>SplashScreen(),
//    '/Contacts': (BuildContext context) =>Contacts(),
    '/SetName': (BuildContext context) =>SetName(),
//    '/Trash': (BuildContext context) =>Trash(items),
    '/BottomPage': (BuildContext context) =>BottomPage(),
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

String token;
String num;

var response;
var response2;

List<List<Image>> images = [];
List<Image> imagesCategory = [];
List<int> TrashSave = [];

Like ObjectLikes = Like.r();
List<int> ListLike = [];

TrashList ObjectTrash = TrashList.r();
List<int> ListTrash = [];


List<adress> ListAdress = [adress("Москва","Авиамоторная","8","А","7","320")];


var TrashDate = new DateFormat("dd.MM.yyyy", "en_US").parse("00.00.0000");
var TrashTime = new DateFormat("HH:mm", "en_US").parse("12:30");
bool selectedDate = false, selectedTime= false, selectedAdress = false;

class SplashScreen extends StatefulWidget  {
  final String nextRoute;

  SplashScreen({this.nextRoute});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen>  {

  double Loading = 0.0;
  double LoadingComplete = 0.0;
  double LoadingProgress = 0.0;
  int LoadingP = 1;// LoadingProgress*1000~/LoadingComplete;

  double LoadingCompleteChceck(){
    for(int i = 0; i < 7; i++){
      for(int j = 0; j < ItemCount(i).count; j++) {
        LoadingComplete += 1.0;
      }
      }
    LoadingComplete += 7.0;
  }


  void UpdateLoading(double up){
    LoadingProgress += up;
    LoadingP = (Loading*100).toInt();


      if(LoadingProgress > 0.0)
      Loading = LoadingProgress/LoadingComplete;
      setState(() {

      });

  }



  void inf()async{

    final prefs = await SharedPreferences.getInstance();

    final info = prefs.getBool('info') ?? false;
    final auto = prefs.getBool('auto') ?? false;
    token = prefs.getString('token') ?? 'none';
    num = prefs.getString('num') ?? 'none';

    images.clear();
    imagesCategory.clear();


    void _imageLoad() async {


      var start = new DateTime.now();



      for(int i = 0; i < 7; i ++ ){

        //____________________________________________________________________________________
        Image downloadImage =Image.network('http://eclipsedevelop.ru/images/c-${i+1}.png');
        print('http://eclipsedevelop.ru/images/c-${i+1}.png');
        imagesCategory.add(downloadImage);

        final ImageStream stream = downloadImage.image.resolve(ImageConfiguration.empty);
        final Completer<void> completer = Completer<void>();
        stream.addListener(ImageStreamListener((ImageInfo info, bool syncCall) => completer.complete()));
        await completer.future;
        //___________________________________________________________________________________

        UpdateLoading(1.0);

        if (mounted) {



          List<Image> step = [];
          for(int j = 0; j < ItemCount(i).count; j++){

            print("Загрузка картинки $i $j");


            //_____________________________________________________________________________________
            Image downloadImage =Image.network('http://eclipsedevelop.ru/images/${(i+1)*100+(j+1)}.jpg');
            step.add(downloadImage);

            final ImageStream stream = downloadImage.image.resolve(ImageConfiguration.empty);
            final Completer<void> completer = Completer<void>();
            stream.addListener(ImageStreamListener((ImageInfo info, bool syncCall) => completer.complete()));
            await completer.future;
            //________________________________________________________________________________________


            UpdateLoading(1.0);

            print("Complited");
          }
          images.add(step);



        }

      }

      var end = new DateTime.now();

      print("Загрузка "+end.difference(start).inSeconds.toString()+" секунд");

    }



    await _imageLoad();








    if(info){
      if(auto) {


        if(token != 'none') {

          print('http://eclipsedevelop.ru/api.php/cbvalidate?token=$token');
          Future<http.Response> res() async {
            return await  http.get(
                'http://eclipsedevelop.ru/api.php/cbvalidate?token=$token');
          }

          print('Валидность $token  '+res.toString());

          var value1 = await res();

          if(value1.statusCode == 200) {
            var response = jsonDecode(value1.body);
            String Response = response["response"];
            print(Response);
            if (Response == "11") {
              Navigator.of(context).pushReplacementNamed('/SetName');
            }
            else if(Response == "13"){


              Future<http.Response> res2() async {
                return await http
                    .get('http://eclipsedevelop.ru/api.php/cbmyorders?token=$token');
              }
              print('http://eclipsedevelop.ru/api.php/cbmyorders?token=$token');

              var value2 =await res2();

              if(value2.statusCode == 200) {
                if (value2.statusCode == 200) {
                  response2 = jsonDecode(value2.body);
                  print(response2);
                  ObjectLikes = Like(token);
                  // ignore: non_constant_identifier_names
                  Future<bool> acceptGet = ObjectLikes.Likes();
                  if(await acceptGet){
                     ObjectLikes.getLikes();
                  }
                  ObjectTrash = TrashList(token);
                  // ignore: non_constant_identifier_names
                  Future<bool> acceptGetTrash = ObjectTrash.TrashListUp();
                  if(await acceptGetTrash){
                    ObjectTrash.getTrash();
                  }


                  Navigator.of(context).pushReplacementNamed('/BottomPage');

                }
              }



            }else if(Response == "12"){
              Navigator.of(context).pushReplacementNamed('/Login');
              prefs.setString('token', 'none');
            }
          }


        }else{
          Navigator.of(context).pushReplacementNamed('/Login');
        }
      }else{
        Navigator.of(context).pushReplacementNamed('/Login');
      }
    }else{
      Navigator.of(context).pushReplacementNamed(widget.nextRoute);
    }

  }


  @override
  void initState() {

    super.initState();
    LoadingCompleteChceck();

    // Создаём таймер, который должен будет переключить SplashScreen на HomeScreen через 2 секунды
    inf();

    Timer(
        Duration(seconds: 2222),
        // Для этого используется статический метод навигатора
        // Это очень похоже на передачу лямбда функции в качестве аргумента std::function в C++
            () {
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 230, 229, 1),
      body: Stack(
        children: <Widget>[
          Center(
            child: Container(
              padding: EdgeInsets.only(bottom: 60,right: 23),
              child: Image.network('https://static.tildacdn.com/tild3230-6134-4236-b864-353236306434/Logo02102018.png',width: 300,height: 300, ),
            ),

          ),

          Align(
            alignment: Alignment.bottomCenter,
            child:Padding(
              padding: const EdgeInsets.all(28.0),
              child: CircularPercentIndicator(
                radius: 100.0,
                lineWidth: 10.0,
                animation: false,
                percent: Loading,
                center: new Text(

                  "${LoadingP}%",
                  style:
                  new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                footer: new Text(
                  "Ща мы всё загрузим",
                  style:
                  new TextStyle( fontSize: 17.0),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.purpleAccent,
              ),
            ) ,
          )

        ],
      ),
    );
  }
}


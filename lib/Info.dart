import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutterapp32/home.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Info extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Info();
  }
}

class _Info extends State<Info> {
  bool _showButton = false;
  int i = 0;

  final routes = <String, WidgetBuilder>{
    // Путь, по которому создаётся Home Screen
    '/Quality': (BuildContext context) => Info(),
    '/home': (BuildContext context) => Home(),
  };

  void _changedButton(int index) {
    print(index);
    if (index == 2) {
      setState(() {
        _showButton = true;
      });
    }
  }

  void f() {}

  @override
  void initState() {
    if (i == 5) {
      setState(() {
        _showButton = true;
      });
    }
  }

  final _images = <String>[
    'assets/icons/puc.ico',
    'assets/icons/calendar.ico',
    'assets/images/zayavka.png',
    'assets/icons/phone.ico',
    'assets/images/ok.png'
  ];
  final _htx = <String>[
    'Выберите услугу',
    'Выберите дату и время',
    'Отправьте заявку',
    'Получите подтверждение',
    'Ожидайте мастера вовремя'
  ];
  final _tx = <String>[
    'Поместите выбранные услуги в корзину',
    'Укажите дату и время приезда мастера',
    'Укажите ваше имя и номер телефона',
    'Оператор свяжется с вами для подтверджения выбранных услуг',
    '                                  '
  ];

  Widget _button(String text, void func()) {
    return RaisedButton(
      splashColor: Colors.indigoAccent,
      highlightColor: Colors.indigoAccent,
      color: Color.fromRGBO(255, 77, 77, 1),
      child: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.normal, color: Colors.white, fontSize: 20),
      ),
      onPressed: () {
        func();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SwiperController _controller = SwiperController();

    return Container(
      decoration: BoxDecoration(
        gradient:  LinearGradient(
        begin: FractionalOffset.topCenter,
        end: FractionalOffset.bottomCenter,
        colors: [Colors.white,Color.fromRGBO(255, 230, 229, 1)],
          //stops: [0.3,0.7],
      )
      ),
      child: new Stack(
        children: <Widget>[
          Swiper(
            itemBuilder: (
              BuildContext context,
              int index,
            ) {
//              index == 2 ? _controller.move(2) : SizedBox();
              return Stack(
                children: <Widget>[
                  _topOchka(index, context),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        _images[index],
                        height: 130,
                        fit: BoxFit.fitHeight,
                        color: Colors.black,
                        width: 130,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0, left: 20,right: 20),
                        child: Center(
                          child: Text(
                            _htx[index],
                            style: TextStyle(
//                              color: Colors.black87,
                                color: Color.fromRGBO(219, 33, 76, 1),
                                fontSize: 25,
                                decoration: TextDecoration.none,fontWeight: FontWeight.w300),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 60,right: 60,top: 40),
                        child: Center(
                          child: Text(
                            _tx[index],
                            style: TextStyle(
                                color: Colors.black45,
                                fontSize: 16,
                                decoration: TextDecoration.none,
                                fontFamily: 'Helvetica'),
                          ),
                        ),
                      )
                    ],
                  ),
                  index == 4
                      ? Positioned(
                          bottom: 75,
                          left: MediaQuery.of(context).size.width/2-75,
                          child: GestureDetector(
                            onTap:(){

                              void inf()async{

                                final prefs = await SharedPreferences.getInstance();

                                prefs.setBool('info', true);
                              }
                              inf();


                              Navigator.pushNamed(context, '/home');
                            },
                            child: Container(
                              height: 33,
                              width: 150,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                shape: BoxShape.rectangle,
                                border: Border.all(color: Colors.black45),
                                borderRadius: BorderRadius.all(Radius.circular(25)),
                              ),
                              child: Center(
                                child: Text(
                                  'Понятно',
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Colors.black,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 0,
                        ),
                ],
              );
            },
            loop: false,
            itemCount: 5,
            pagination: new SwiperPagination(),
            control: new SwiperControl(),
            controller: _controller,
          ),
        ],
      ),
    );
  }
}

Widget _topOchka (int i, BuildContext context){

  if(i == 0){
    return Padding(
      padding: const EdgeInsets.only(top: 58.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 2.0),
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(255, 230, 229, 1),
              ),
              child: Center(
                child: Text(
                  '${i+1}',
                  style: TextStyle(color: Colors.black, fontSize: 25,fontWeight: FontWeight.bold,decoration: TextDecoration.none),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 2,
            width: MediaQuery.of(context).size.width / 2 - 42,
            child: Container(
              color: Colors.black,
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      ),
    );
  }
  else if(i == 4){
    return Padding(
      padding: const EdgeInsets.only(top: 58.0),
      child: Row(
        children: <Widget>[
          SizedBox(
            height: 2,
            width: MediaQuery.of(context).size.width / 2 - 42,
            child: Container(
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 2.0),
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(255, 230, 229, 1),

              ),
              child: Center(
                child: Text(
                  '${i+1}',
                  style: TextStyle(color: Colors.black, fontSize: 25,fontWeight: FontWeight.bold,decoration: TextDecoration.none),
                ),
              ),
            ),
          ),

        ],
        mainAxisAlignment: MainAxisAlignment.start,
      ),
    );


  } else {
    return Padding(
      padding: const EdgeInsets.only(top: 58.0),
      child: Row(
        children: <Widget>[
          SizedBox(
            height: 2,
            width: MediaQuery.of(context).size.width / 2 - 42,
            child: Container(
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 2,right: 2),
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(255, 230, 229, 1),
              ),
              child: Center(
                child: Text(
                  '${i+1}',
                  style: TextStyle(color: Colors.black, fontSize: 25,fontWeight: FontWeight.bold,decoration: TextDecoration.none),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 2,
            width: MediaQuery.of(context).size.width / 2 - 42,
            child: Container(
              color: Colors.black,
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}
//Widget _ItemIcon(int i){
//  return Icon('assets/icons/puc.ico');
//}
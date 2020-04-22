import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutterapp32/home.dart';

class Quality extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Quality();
  }
}

class _Quality extends State<Quality> {
  bool _showButton = false;
  int i = 0;

  final routes = <String, WidgetBuilder>{
    // Путь, по которому создаётся Home Screen
    '/Quality': (BuildContext context) => Quality(),
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
    if (i == 2) {
      setState(() {
        _showButton = true;
      });
    }
  }

  final images = <String>[
    'https://thumb.tildacdn.com/tild3361-3266-4164-a639-613536663435/-/resize/150x/-/format/webp/Colorbird_Open_24_ho.png',
    'https://thumb.tildacdn.com/tild3034-3435-4638-a436-646266343664/-/resize/150x/-/format/webp/Colorbird_quality_ma.png',
    'https://thumb.tildacdn.com/tild6334-6265-4532-b732-313235646563/-/resize/150x/-/format/webp/Colorbird_sterile_to.png',
  ];
  final htx = <String>[
    'Обслуживание 24 / 7',
    'Качественные материалы',
    'Стерильные инструменты'
  ];
  final tx = <String>[
    'Мы постоянно совершенствуемся и предоставляем клиентам широкий спектр услуг, включая круглосуточный выезд мастера 7 дней в неделю',
    'Мы постоянно совершенствуемся и предоставляем клиентам широкий спектр услуг, включая круглосуточный выезд мастера 7 дней в неделю',
    'Стерильные маникюрные инструменты и все остальные вспомогательные предметы, включая ванночки, подставки, УФ лампы'
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
      color: Color.fromRGBO(255, 230, 229, 1),
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.network(
                        images[index],
                        fit: BoxFit.fitHeight,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Text(htx[index],style: TextStyle(color: Colors.black87, fontSize: 25, decoration: TextDecoration.none),),
                      ),
                      Padding(
                        padding: EdgeInsets.all(40),
                        child: Text(tx[index], style: TextStyle(color: Colors.black45, fontSize: 16, decoration: TextDecoration.none, fontFamily: 'Helvetica'),),
                      )
                    ],
                  ),
                  index == 2
                      ? Positioned(
                    bottom: 75,
                    left: MediaQuery.of(context).size.width/2-75,
                    child: GestureDetector(
                      onTap:(){
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
            itemCount: 3,
            pagination: new SwiperPagination(),
            control: new SwiperControl(),
            controller: _controller,
          ),
        ],
      ),
    );
  }
}



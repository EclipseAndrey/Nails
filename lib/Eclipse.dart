import 'package:flutter/material.dart';

class Eclipse extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Eclipse();
  }
}

class _Eclipse extends State<Eclipse> with TickerProviderStateMixin {
  Animation<double> animation;
  Animation<double> atx1; // 1 строка
  Animation<double> atx2; // 2 строка
  Animation<double> atx3; // 3 строка
  Animation<double> atx4; // 4 строка
  Animation<double> atx5; // 5 строка
  Animation<double> abt; //   button

  AnimationController controller;
  AnimationController controller_atx1;
  AnimationController controller_atx2;
  AnimationController controller_atx3;
  AnimationController controller_atx4;
  AnimationController controller_atx5;
  AnimationController controller_abt;


  @override
  void initState() {
    super.initState();
    controller =       AnimationController(vsync: this, duration: Duration(seconds: 2));
    controller_atx1 =  AnimationController(vsync: this, duration: Duration(seconds: 1));
    controller_atx2 =  AnimationController(vsync: this, duration: Duration(seconds: 1));
    controller_atx3 =  AnimationController(vsync: this, duration: Duration(seconds: 1));
    controller_atx4 =  AnimationController(vsync: this, duration: Duration(seconds: 1));
    controller_atx5 =  AnimationController(vsync: this, duration: Duration(seconds: 1));
    controller_abt =   AnimationController(vsync: this, duration: Duration(seconds: 1));
    print('Start');
  }


  @override
  Widget build(BuildContext context) {

    Tween tween  = new Tween<double>(begin: 0.0, end: 1.0);
    Tween tween2 = new Tween<double>(begin: 0.0, end: 1.0);
    Tween tween3 = new Tween<double>(begin: 0.0, end: 1.0);
    Tween tween4 = new Tween<double>(begin: 0.0, end: 1.0);
    Tween tween5 = new Tween<double>(begin: 0.0, end: 1.0);
    Tween tween6 = new Tween<double>(begin: 0.0, end: 1.0);
    Tween tween1 = new Tween<double>(begin: 0.0, end: 1.0);

    animation = tween.animate(controller);
    atx1 = tween1.animate(controller_atx1);
    atx2 = tween2.animate(controller_atx2);
    atx3 = tween3.animate(controller_atx3);
    atx4 = tween4.animate(controller_atx4);
    atx5 = tween5.animate(controller_atx5);
    abt = tween6.animate(controller_abt);

    // More code here

    controller.forward();

    animation.addListener(() {
      setState(() {});});
    atx1.addListener(() {
      setState(() {});});
    atx2.addListener(() {
      setState(() {});});
    atx3.addListener(() {
      setState(() {});});
    atx4.addListener(() {
      setState(() {});});
    atx5.addListener(() {
      setState(() {});});
    abt.addListener(() {
      setState(() {});});




    animation.addStatusListener((status) {
      if(status == AnimationStatus.completed && atx1.value == 0.0){
        controller_atx1.forward();
        controller_atx2.forward();
      }
    });
    atx2.addStatusListener((status) {
      if(status == AnimationStatus.completed && atx3.value == 0.0) {
        controller_atx3.forward();
        controller_atx4.forward();
      }
    });
    atx4.addStatusListener((status) {
      if(status == AnimationStatus.completed && atx5.value == 0.0)
        controller_atx5.forward();
    });

    atx5.addStatusListener((status) {
      if(status == AnimationStatus.completed && abt.value == 0.0)
        controller_abt.forward();
    });
    //controller.forward();

    return _Window(context, animation, atx1,atx2,atx3,atx4,atx5,abt);

  }


}

Widget _Window(BuildContext context,Animation<double> animation,Animation<double> atx1,Animation<double> atx2,Animation<double> atx3,Animation<double> atx4,Animation<double> atx5,Animation<double> abt) {



  return Container(
    color: Colors.black,
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    child: Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Container(),
        ),

        Column(

          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom:18.0,top:5),
              child: Opacity(
                opacity: animation.value,
                child: Image.asset(
                  'assets/images/Eclipse.png',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Opacity(
                opacity: atx1.value ,
                child: Row(
                  children: <Widget>[
                    Text('Eclipse Developers', style: TextStyle(fontSize: 20, color: Colors.purpleAccent, decoration: TextDecoration.none,fontFamily: 'Thin'),),
                    Text('- это', style: TextStyle(fontSize: 20, color: Colors.white, decoration: TextDecoration.none,fontFamily: 'Thin'),),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Opacity(
                  opacity: atx2.value ,

                  child: Text('команда разработчиков', style: TextStyle(fontSize: 20, color: Colors.white, decoration: TextDecoration.none,fontFamily: 'Thin'),)),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Opacity(
                  opacity: atx3.value,
                  child: Text('занимающиеся профессиональной', style: TextStyle(fontSize: 20, color: Colors.white, decoration: TextDecoration.none,fontFamily: 'Thin'),)),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Opacity(
                  opacity: atx4.value ,

                  child: Text('разработкой приложений по платформы', style: TextStyle(fontSize: 20, color: Colors.white, decoration: TextDecoration.none,fontFamily: 'Thin'),)),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Opacity(
                opacity: atx5.value ,

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('IOS ', style: TextStyle(fontSize: 20, color: Colors.blueAccent, decoration: TextDecoration.none,fontFamily: 'Thin'),),
                    Text('и ', style: TextStyle(fontSize: 20, color: Colors.white, decoration: TextDecoration.none,fontFamily: 'Thin'),),
                    Text('Android.', style: TextStyle(fontSize: 20, color: Colors.green, decoration: TextDecoration.none,fontFamily: 'Thin',),),
                  ],
                ),
              ),
            ),

          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 38.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Opacity(
              opacity: abt.value ,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.end ,
                children: <Widget>[
                  GestureDetector(
                    onTap:(){
                      Navigator.pushNamed(context, '/home');
                    },
                    child: Container(
                      height: 33,
                      width: 170,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      child: Center(
                        child: Text(
                          'Посетить сайт',
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: GestureDetector(
                      onTap:(){
                        Navigator.pushNamed(context, '/home');
                      },
                      child: Container(
                        height: 33,
                        width: 110,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.rectangle,
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        child: Center(
                          child: Text(
                            'Выйти',
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

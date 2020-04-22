import 'package:flutter/material.dart';
import 'style.dart';


class Contacts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Contacts();
  }
}

class _Contacts extends State<Contacts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, //No more green
        elevation: 0.0, //Shadow gone
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          colors: [
            Colors.white,
            Color.fromRGBO(255, 230, 229, 1),
            Color.fromRGBO(255, 230, 229, 1)
          ],
//              stops: [0.45,0.5],
        )),
        height: MediaQuery.of(context).size.height,
        width:MediaQuery.of(context).size.width ,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Контакты',
                        style: TextStyle(
//                              color: Colors.black87,
                            color: Color.fromRGBO(219, 33, 76, 1),
                            fontSize: 25,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Остались вопросы или вам нужна консультация',
                        style: TextStyle(
//                              color: Colors.black87,
                            color: Colors.black87,
                            fontSize: 18,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'мастера? Напишите нам!',
                        style: TextStyle(
//                              color: Colors.black87,
                            color: Colors.black87,
                            fontSize: 18,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '+7 915 008 51 91',
                        style: TextStyle(
//                              color: Colors.black87,
                            color: Colors.black87,
                            fontSize: 22,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    Text(
                      'colorbird.ru@gmail.com',
                      style: TextStyle(
//                              color: Colors.black87,
                          color: Colors.black87,
                          fontSize: 22,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w300),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 28.0, bottom: 8),
                      child: Container(
                        width: 300,
                        child: Center(
                          child: TextField(
                            decoration: inputDecorationName,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 300,
                      child: Center(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: inputDecoration4,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 18),
                      child: Container(
                        width: 300,
                        child: Center(
                          child: TextField(
                            maxLines: 5,
                            minLines: 2,
                            maxLength: 500,
                            decoration: inputDecorationMess,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/home');
                      },
                      child: Container(
                        height: 33,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.rectangle,
                          border: Border.all(color: Colors.black87),
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        child: Center(
                          child: Text(
                            'Отправить',
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.black,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image:
                  Image.asset('assets/images/inst.png').image,
                  fit: BoxFit.cover),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 5.0,
                  spreadRadius: 0.1,
                  offset: Offset(-5, 5),
                )
              ] //boxShadow
          ),
          height: 60,
          width: 60,
        ),
        //Widget to display inside Floating Action Button, can be `Text`, `Icon` or any widget.
        onPressed: () {
          //Code to execute when Floating Action Button is clicked
          //...
        },
      ),
    );
  }
}

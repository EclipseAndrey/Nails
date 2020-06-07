import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MakeOrder extends StatefulWidget {
  @override
  _MakeOrderState createState() => _MakeOrderState();
}

class _MakeOrderState extends State<MakeOrder> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child:Image.asset('assets/images/backround.png',
            fit: BoxFit.fill,),
        ),
        contentOrder(),
      ],
    );
  }
}

Widget contentOrder(){
  return Column(
    children: <Widget>[
      Container(
        child: Column(
          children: [
            Text("Оформление",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 44,
                  fontFamily: "MPLUS",
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w300, decoration: TextDecoration.none),
            ),
            Padding(
              padding: EdgeInsets.only(left: 48.0, right: 48),
              child: Divider(
                height: 1,
                color: Colors.white60,

              ),
            ),
          ],
        ),
      ),
    ],
  );
}
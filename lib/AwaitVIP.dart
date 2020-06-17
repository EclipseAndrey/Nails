import 'package:flutter/material.dart';
import 'package:flutterapp32/main.dart';

import 'Objects.dart';

class AwaitVIPADmin extends StatefulWidget {
  @override
  _AwaitVIPADminState createState() => _AwaitVIPADminState();
}

class _AwaitVIPADminState extends State<AwaitVIPADmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.withOpacity(0.8),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Запросы на получение VIP",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "MPLUS",
          ),
        ),
      ),
      body: Content(),
    );
  }

  Widget Content(){
    return Container(

      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            children: List.generate(ObjectVIP.getAwaitVIP().length, (index){
              return ItemVIP(ObjectVIP.getAwaitVIP()[index]);
            }),
          ),
        ),
      ),
    );
  }


  Widget ItemVIP(AwaitVIP user){


    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(34, 15, 45, .3),
                blurRadius: 10,
                offset: Offset(-2.5, 5))
          ]),
      width: MediaQuery.of(context).size.width * 0.95,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  Text(user.name,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  Text(" ожидает получения VIP статуса",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  Text("Телефон: ",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  Text("+"+user.num,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:0.0, top:12),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    side: BorderSide(color: Colors.green)),
                color: Colors.transparent,
                textColor: Colors.green,
                onPressed: () {  },
                child: Padding(
                  padding: const EdgeInsets.only(left: 3.0, right: 3, top: 3, bottom: 3),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 3.0),
                          child: Icon(Icons.call, color: Colors.green,),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text("Позвонить",
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 16,
                                fontFamily: "MPLUS",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [

                Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        side: BorderSide(color: Colors.green)),
                    color: Colors.transparent,
                    textColor: Colors.green,
                    onPressed: () {  },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 3.0, right: 3, top: 3, bottom: 3),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 3.0),
                              child: Icon(Icons.check, color: Colors.green,),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text("Подтвердить",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 16,
                                    fontFamily: "MPLUS",
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          side: BorderSide(color: Colors.redAccent)),
                      color: Colors.transparent,
                      textColor: Colors.pinkAccent,
                      onPressed: () {  },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 3.0, right: 3, top: 3, bottom: 3),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 3.0),
                                  child: Icon(Icons.clear, color: Colors.redAccent,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text("Отказать",
                                    style: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 16,
                                        fontFamily: "MPLUS",
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

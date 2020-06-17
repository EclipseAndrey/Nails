import 'package:flutter/material.dart';
import 'package:flutterapp32/Objects.dart';
import 'package:flutterapp32/main.dart';

class Dialogs extends StatefulWidget {
  @override
  _DialogsState createState() => _DialogsState();
}

class _DialogsState extends State<Dialogs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Диалоги"),
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: Colors.white,),
        ),
      ),
      body: Content(),
    );
  }

  Widget Content(){
    print(ObjectMessage.getDialogs().length.toString());
    return SingleChildScrollView(
      child: Column(
        children:
        List.generate(ObjectMessage.getDialogs().length, (index){
          DialogMessage step = ObjectMessage.getDialogs()[index];
          print(step.mess);
          return GestureDetector(
            onTap: (){

            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [BoxShadow(
                        color: Color.fromRGBO(34, 15, 45, .3),
                        blurRadius: 5,
                        offset: Offset(-1, 3)
                    )]
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                            child: Text(step.name +" (" + step.num + ")", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),)),
                        Flexible(
                          flex: 1,
                          child: Text("16:49", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
                        )
                      ],
                    ),
                    SizedBox(height: 4,),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(step.mess, style: TextStyle(fontSize: 16),),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }),

      ),
    );
  }
}

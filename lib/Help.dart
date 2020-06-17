import 'package:flutter/material.dart';

class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {

  List<String> Message = ["@Задайте ваш вопрос тут","Здравствуйте, вы гей?", "@Здравствуйте, да", "@А вы?", "И я да"];

  //s.replaceAll(new RegExp(r'@');

  @override
  Widget build(BuildContext context) {
    if(Message[0][0] == "@"){
      print("@");
    }
    print(Message[0][0]);
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple.withOpacity(0.8),
          leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          title: Text(
            "Чат с поддержкой",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "MPLUS",
            ),
          ),
        ),


        body: Content());
  }

  Widget Content(){

    Widget SMS (String sms){
      if(sms[0] == "@"){
        sms = sms.replaceAll("@", "");
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(

                maxWidth: MediaQuery.of(context).size.width*0.60,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),

                child: Container(
                  color: Colors.deepPurple.withOpacity(0.7),

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(sms, style: TextStyle(fontSize: 16, color: Colors.white),),
                  ),
                ),
              ),
            ),
          ],
        );
      }else{
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width*0.6,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  color: Colors.deepPurple.withOpacity(0.7),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(sms, style: TextStyle(fontSize: 16, color: Colors.white),),
                  ),
                ),
              ),
            ),
          ],
        );
      }
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black.withOpacity(0.08),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children:
                List.generate(Message.length, (index){
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SMS(Message[index]),
                  );
                }),

              ),
            ),
          ),
          Container(
            height: 50,
            padding: EdgeInsets.all(2.0),
            decoration:BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(
                    color: Color.fromRGBO(34, 15, 45, .3),
                    blurRadius: 5,
                    offset: Offset(-2.5, 5)
                )]
            ),
            child: Row(
              children: [
                Expanded(child: TextField(
                  decoration: InputDecoration(
                    hoverColor: Colors.purple,
                    hintText: "Введите сообщение",
                    fillColor: Colors.black12,
                    filled: false

                  ),

                )),
                Icon(Icons.send, color: Colors.deepPurple,)
              ],
            ),
          )
        ],
      ),
    );
  }
}

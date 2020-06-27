import 'package:flutter/material.dart';
import 'package:flutterapp32/main.dart';

class ChatAdmin extends StatefulWidget {
  @override
  _ChatAdminState createState() => _ChatAdminState();
}

class _ChatAdminState extends State<ChatAdmin> {

  List<String> Message = ["@Задайте ваш вопрос тут","Здравствуйте, вы гей?", "@Здравствуйте, да", "@А вы?", "И я да"];
  final _controller = ScrollController();
  TextEditingController controllermessage = TextEditingController();
  //s.replaceAll(new RegExp(r'@');

  bool sending = false;
  @override
  Widget build(BuildContext context) {

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
            ObjectMessage.name+" (+"+ObjectMessage.num+")",
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

      if(sms[0] != "@"){
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width*0.90,
            maxHeight: MediaQuery.of(context).size.height*5
          ),
          child: Row(
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
              Text("  14:20  ", style: TextStyle(color: Colors.black54),),
            ],
          ),
        );
      }else{
        sms = sms.replaceAll("@", "");
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text("  14:20  ", style: TextStyle(color: Colors.black54),),

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
            child: ListView(
              controller: _controller,

              reverse: true,
              children:
              List.generate(ObjectMessage.getMessForAdmin().length, (index){
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SMS(ObjectMessage.getMessForAdmin()[ObjectMessage.getMessForAdmin().length-1-index].mess.toString()),
                );
              }),

            ),
          ),
          Container(
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
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  minLines: 1,
                  controller: controllermessage,
                  decoration: InputDecoration(

                      hoverColor: Colors.purple,
                      hintText: "Введите сообщение",
                      fillColor: Colors.black12,
                      filled: false

                  ),

                )),
                GestureDetector(
                    onTap: ()async{

                      if(!sending){
                        sending = true;
                        setState(() {});
                        await ObjectMessage.sendMessAdmin(controllermessage.text, ObjectMessage.num);
                        await ObjectMessage.upMessForAdmin(ObjectMessage.num);
                        controllermessage.text = "";
                        sending = false;
                      }
                      setState(() {});
                    },
                    child: !sending?Icon(Icons.send, color: Colors.deepPurple,):CircularProgressIndicator(),)
              ],
            ),
          )
        ],
      ),
    );
  }
}

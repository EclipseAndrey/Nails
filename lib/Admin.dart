import 'package:flutter/material.dart';
import 'package:flutterapp32/main.dart';

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Панель Администратора",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "MPLUS",
          ),
        ),
      ),
      body: Content(),
    );
  }

  List<String> AdminMenu =["Чат поддержки","Ожидание подтверждения","Подтвержденные","Отмененные","Ожидание VIPa", "VIP клиенты", "Изменить статус", "Бонусные счета", "Скидки", "Купоны", "Администраторы",];


  Widget MenuItem(String head, int index){
    return                             Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: GestureDetector(
        onTap: ()async{
          print("Tap: $index");
          switch(AdminMenu[index]){
            case "Бонусные счета":{
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return Dialog(

                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25)
                        ),

                      ),
                      width: MediaQuery.of(context).size.width*2/3,
                      height: 80,
                      child: Center(
                        child: new CircularProgressIndicator(),
                      ),
                    ),

                  );
                },
              );

              await ObjectUsers.Up();

              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('/Bonus');
              break;

            }
            case "Ожидание подтверждения":{
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return Dialog(

                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25)
                        ),

                      ),
                      width: MediaQuery.of(context).size.width*2/3,
                      height: 80,
                      child: Center(
                        child: new CircularProgressIndicator(),
                      ),
                    ),

                  );
                },
              );

              await ObjectOrdersAwait.Up();

              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('/OrdersAwait');

              break;

            }
            case "Подтвержденные":{
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return Dialog(

                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25)
                        ),

                      ),
                      width: MediaQuery.of(context).size.width*2/3,
                      height: 80,
                      child: Center(
                        child: new CircularProgressIndicator(),
                      ),
                    ),

                  );
                },
              );

              await ObjectOrdersAccept.Up();

              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('/OrdersAccept');

              break;

            }
            case "Отмененные":{
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return Dialog(

                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25)
                        ),

                      ),
                      width: MediaQuery.of(context).size.width*2/3,
                      height: 80,
                      child: Center(
                        child: new CircularProgressIndicator(),
                      ),
                    ),

                  );
                },
              );

              await ObjectOrdersCacel.Up();

              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('/OrdersCancel');

              break;

            }
          }
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [BoxShadow(
                  color: Color.fromRGBO(34, 15, 45, .3),
                  blurRadius: 10,
                  offset: Offset(-2.5, 5)
              )]
          ),
          width: MediaQuery.of(context).size.width*0.84,
          height: MediaQuery.of(context).size.width*0.15,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Row(
                  children: [
//                    Icon(Icons.help_outline, color: Colors.black54,),
                    Padding(
                      padding: const EdgeInsets.only(left: 14.0),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          head, style: TextStyle(
                            color: Colors.black,
                            fontSize: 18
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
    );
  }


  Widget HeadDivider(int index){
    switch(index){
      case 0:{
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 8, bottom: 3),
              child: Text("Связь с клиентами",
                style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
                fontFamily: "MPLUS",
              ), ),
            ),
            Container(
                width: MediaQuery.of(context).size.width*0.84,
//                child: Divider()
            ),
          ],
        );

      }
      case 1:{
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 3, left: 8),
            child: Text("Записи",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
                fontFamily: "MPLUS",
              ), ),
          ),
          Container(
              width: MediaQuery.of(context).size.width*0.84,
//              child: Divider()
          ),
        ],
      );

    }
      case 4:{
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 3, left: 8),
              child: Text("Управление VIPом",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                  fontFamily: "MPLUS",
                ), ),
            ),
            Container(
                width: MediaQuery.of(context).size.width*0.84,
//                child: Divider()
            ),
          ],
        );

      }

      case 7:{
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 3, left: 8),
              child: Text("Бонусные системы",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                  fontFamily: "MPLUS",
                ), ),
            ),
            Container(
                width: MediaQuery.of(context).size.width*0.84,
//                child: Divider()
            ),
          ],
        );

      }
      case 10:{
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 0, left: 8),
              child: Text("Другое",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                  fontFamily: "MPLUS",
                ), ),
            ),
            Container(
                width: MediaQuery.of(context).size.width*0.84,
                child: Divider()),
          ],
        );

      }
      default: {
        return SizedBox();
      }
    }
  }

  Widget Content(){
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      child: SingleChildScrollView(
        child: Column(

          children: List.generate(AdminMenu.length, (index){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeadDivider(index),
                GestureDetector(

                    child: MenuItem(AdminMenu[index], index )),
              ],
            );
          }),
        ),
      ),
    );
  }
}

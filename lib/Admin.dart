import 'package:flutter/material.dart';

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

  List<String> AdminMenu =["Чат поддержки","Ожидание подтверждения","Подтвержденные","Отмененные","Ожидание VIPa", "VIP клиенты", "Бонусные счета", "Скидки", "Купоны", "Администраторы",];


  Widget MenuItem(String head){
    return                             Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: GestureDetector(
        onTap: (){

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

  Widget Content(){
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      child: SingleChildScrollView(
        child: Column(

          children: List.generate(AdminMenu.length, (index){
            return MenuItem(AdminMenu[index]);
          }),
        ),
      ),
    );
  }
}

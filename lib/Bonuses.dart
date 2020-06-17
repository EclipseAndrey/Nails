import 'package:flutter/material.dart';
import 'package:flutterapp32/main.dart';
import 'Objects.dart';

class Bonuses extends StatefulWidget {
  @override
  _BonusesState createState() => _BonusesState();
}

class _BonusesState extends State<Bonuses> {
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
          "Бонусные счета пользователей",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "MPLUS",
          ),
        ),
      ),
      body: Content(),
    );
  }

  Widget Content() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top : 8.0),
            child: Column(
        children: List.generate(ObjectUsers.getUsers().length, (index) {
            print("generate");
            return ItemUser(ObjectUsers.getUsers()[index]);
        }),
      ),
          )),
    );
  }

  Widget ItemUser(User user) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: GestureDetector(
        onTap: () async {},
        child: Container(
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
          height: MediaQuery.of(context).size.width * 0.15,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
//                    Icon(Icons.help_outline, color: Colors.black54,),
                    Padding(
                      padding: const EdgeInsets.only(left: 14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              user.name,
                              style: TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Padding(
                              padding: const EdgeInsets.only(top:5.0),
                              child: Text(
                                user.num,
                                style: TextStyle(color: Colors.black45, fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "Бонусы",
                              style: TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Text(
                                user.bonus,
                                style: TextStyle(color: Colors.black45, fontSize: 16),
                              ),
                            ),
                          ),
                        ],
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
}

import 'package:flutter/material.dart';

class OkVipAdmin extends StatefulWidget {
  @override
  _OkVipAdminState createState() => _OkVipAdminState();
}

class _OkVipAdminState extends State<OkVipAdmin> {
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
          "список VIP",
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
    return Container();
  }
}

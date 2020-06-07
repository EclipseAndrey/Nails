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
              Content(),
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

  double sizeText = 16;

  String _month(String month){
    switch(month){
      case "1": return "января"; break;
      case "2": return "февраля"; break;
      case "3": return "марта"; break;
      case "4": return "апреля"; break;
      case "5": return "мая"; break;
      case "6": return "июня"; break;
      case "7": return "июля"; break;
      case "8": return "августа"; break;
      case "9": return "сентября"; break;
      case "10": return "октября"; break;
      case "11": return "ноября"; break;
      case "12": return "декабря"; break;
    }
  }


  Widget Date(DateTime date){
    if(date.day == 0){
      return Row(
        children: [
          Text("Выберите ", style:  TextStyle(
              color: Colors.white,
              fontSize: sizeText,
              fontFamily: "MPLUS",
//              decoration: TextDecoration.underline,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w300),),
          GestureDetector(
            onTap: (){

            },
            child: Text("дату", style:  TextStyle(
                color: Colors.blueAccent,
                fontSize: sizeText,
                fontFamily: "MPLUS",
              decoration: TextDecoration.underline,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w300),),
          ),
        ],
      );
    }else{
      return Row(
        children: [
          Text("Дата ", style:  TextStyle(
              color: Colors.white,
              fontSize: sizeText,
              fontFamily: "MPLUS",
//              decoration: TextDecoration.underline,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w300),),
          GestureDetector(
            onTap: (){

            },
            child: Text(date.day.toString()+" "+_month(date.month.toString()), style:  TextStyle(
                color: Colors.blueAccent,
                fontSize: sizeText,
                fontFamily: "MPLUS",
                decoration: TextDecoration.underline,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w300),),
          ),
        ],
      );

    }
  }


                              //НЕ ЗАБЫТЬ ПОСАВИТЬ ФЛАГ selected КОГДА ВЫБРАНО ВРЕМЯ!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  Widget Time(DateTime time, bool selected){
    if(selected){
      return Row(
        children: [
          Text("Выберите ", style:  TextStyle(
              color: Colors.white,
              fontSize: sizeText,
              fontFamily: "MPLUS",
//              decoration: TextDecoration.underline,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w300),),
          GestureDetector(
            onTap: (){

            },
            child: Text("время", style:  TextStyle(
                color: Colors.blueAccent,
                fontSize: sizeText,
                fontFamily: "MPLUS",
                decoration: TextDecoration.underline,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w300),),
          ),
        ],
      );
    }else{
      return Row(
        children: [
          Text("Время ", style:  TextStyle(
              color: Colors.white,
              fontSize: sizeText,
              fontFamily: "MPLUS",
//              decoration: TextDecoration.underline,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w300),),
          GestureDetector(
            onTap: (){

            },
            child: Text("${time.hour}:${time.minute%60}", style:  TextStyle(
                color: Colors.blueAccent,
                fontSize: sizeText,
                fontFamily: "MPLUS",
                decoration: TextDecoration.underline,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w300),),
          ),
        ],
      );
    }
  }
  Widget Telephone(String tel){

    return Row(
      children: [
        Text("Номер ", style:  TextStyle(
            color: Colors.white,
            fontSize: sizeText,
            fontFamily: "MPLUS",
//              decoration: TextDecoration.underline,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w300),),
        GestureDetector(
          onTap: (){

          },
          child: Text(tel, style:  TextStyle(
              color: Colors.blueAccent,
              fontSize: sizeText,
              fontFamily: "MPLUS",
              decoration: TextDecoration.underline,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w300),),
        ),
      ],
    );
  }


  Widget Content(){



  }



}


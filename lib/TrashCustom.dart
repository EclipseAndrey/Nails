import 'dart:convert';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutterapp32/MakeOrder.dart';
import 'package:flutterapp32/home.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:rounded_modal/rounded_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'EmptyTrash.dart';
import 'Objects.dart';
import 'home.dart';
import 'style.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'dart:async';
import 'package:flutter_rounded_date_picker/src/material_rounded_date_picker_style.dart';
import 'package:flutter_rounded_date_picker/src/material_rounded_year_picker_style.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:core';
import 'dart:async';
import 'main.dart';
import 'package:http/http.dart' as http;


class TrashCustom extends StatefulWidget {
  @override
  _TrashCustomState createState() => _TrashCustomState();
}

class _TrashCustomState extends State<TrashCustom> {
  String _cityValue = "Москва";
  int getAddressLength = ObjectAddress.getAddresses().length+1;


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


        ContentTrash(),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20 ,),
            child: Divider(
              thickness: 0.4,
              endIndent: 0,
              indent: 0,
              height: 1,

              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }


  Widget ContentTrash(){

    Widget Prise(ElementItem itemForSales){
      if(itemForSales.sale>0){
        return Row(

          children: <Widget>[
            Text("${itemForSales.price} руб.", style: TextStyle(color: Colors.white, fontSize: 16, decoration: TextDecoration.lineThrough,),),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text("${itemForSales.price - itemForSales.sale} руб.", style: TextStyle(color: Colors.pinkAccent, fontSize: 16),),


            ),
          ],
        );
      }else{
        return Row(

          children: <Widget>[
            Text("${itemForSales.price} руб.", style: TextStyle(color: Colors.white, fontSize: 16, ),),
          ],
        );
      }
    }

    List<int> populations = [];

    for(int i = 0; i < 7; i++){
      for(int j = 0; j < ItemCount(i).count; j++) {
        if(elementInfo(i, j).population){
          populations.add((i+1)*100+j+1);
        }
      }}

    int count = populations.length;
    int ColumnOne;
    int ColumnTwo;

    if (count % 2 > 0) {
      ColumnOne = count ~/ 2 + 1;
      ColumnTwo = count ~/ 2;
    } else {
      ColumnOne = count ~/ 2;
      ColumnTwo = count ~/ 2;
    }
    List<ElementItem> SearchResult=[];


    for(int i = 0; i < populations.length;i++){
      SearchResult.add(elementInfo(populations[i]~/100-1, populations[i]%100-1));
    }


    if(ObjectTrash.getTrash().length > 0){
      List<dynamic> spisok = ObjectTrash.getTrash();
      var size = MediaQuery.of(context).size;

      List<ElementItem> elemts = [];
      for(int i = 0; i < ObjectTrash.getTrash().length; i++){
        elemts.add(elementInfo(int.parse(ObjectTrash.getTrash()[i])~/100-1, int.parse(ObjectTrash.getTrash()[i])%100-1));
      }
      Widget Prise(ElementItem itemForSales){
        if(itemForSales.sale>0){
          return Row(

            children: <Widget>[
              Text("${itemForSales.price} руб.", style: TextStyle(color: Colors.white, fontSize: 16, decoration: TextDecoration.lineThrough,),),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text("${itemForSales.price - itemForSales.sale} руб.", style: TextStyle(color: Colors.pinkAccent, fontSize: 16),),


              ),
            ],
          );
        }else{
          return Row(

            children: <Widget>[
              Text("${itemForSales.price} руб.", style: TextStyle(color: Colors.white, fontSize: 16, ),),
            ],
          );
        }
      }
      Widget PriceEnd(List<dynamic> ids){
        int sum = 0;
        int sale = 0;
        int endSum = 0;
        int count  = ObjectTrash.getTrash().length;
        for(int i = 0; i < count; i++){
          ElementItem step = elementInfo(int.parse(ids[i])~/100-1, int.parse(ids[i])%100-1);
          sum += step.price;
          sale+= step.sale;
        }
        endSum = sum - sale;

        double spaseLine = 3;

        return Row(
          children: <Widget>[
            Expanded(
                child: SizedBox(width: 0,)
            ),
            Expanded(
              flex: 9,
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(top: spaseLine, bottom: spaseLine),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Выбранно услуг",style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: "MPLUS",
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w300),),
                          Text(count.toString(),style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: "MPLUS",
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w300),),
                        ],
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(top: spaseLine, bottom: spaseLine),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("На сумму ",style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: "MPLUS",
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w300),),
                          Text(sum.toString()+" руб.",style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: "MPLUS",
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w300),),
                        ],
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(top: spaseLine, bottom: spaseLine),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Скидка ",style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: "MPLUS",
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w300),),
                          Text(sale.toString()+" руб.",style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: "MPLUS",
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w300),),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                      height: 3,),
                    Padding(
                      padding:  EdgeInsets.only(top: spaseLine, bottom: spaseLine),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Итого ",style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: "MPLUS",
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500),),
                          Text(endSum.toString()+ " руб.",style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: "MPLUS",
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500),),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: SizedBox(width: 0,)
            ),

          ],
        );



      }


      return Column(
        children: [
          Container(
            height: 73,
            child: Column(
              children: [
                Text("Корзина",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 44,
                      fontFamily: "MPLUS",
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w300),
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
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                  width: size.width*0.95,
                  height: double.maxFinite,

                  child: ListView(
                    children: List.generate(ObjectTrash.getTrash().length+1, (index) {
                      if(index == ObjectTrash.getTrash().length){
                        return PriceEnd(ObjectTrash.getTrash());
                      }else
                        return ClipRRect(
                          child: Card(
                              color: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(width: 1, color:Colors.white ),
                              ),

//                color: Color(0xff8A1FFF),
                              child: Container(
                                width: size.width * 0.95,
                                height: size.height * 0.20,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Container(
                                        padding: EdgeInsets.only(left: 5, top: 6),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image(
                                            image: images[int.parse(spisok[index])~/100-1][int.parse(spisok[index])%100-1].image,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(elemts[index].head, style: TextStyle(fontSize: 18, color: Colors.white),),
                                                Text(elemts[index].tx, style: TextStyle(fontSize: 14, color: Colors.white60),),
                                              ],
                                            ),
                                            Prise(elemts[index]),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 18.0),
                                        child: TrashButton(
                                            elementInfo(int.parse(spisok[index])~/100-1,int.parse(spisok[index])%100-1)),
                                        //LikeButton(elementInfo(int.parse(spisok[index])~/100-1,int.parse(spisok[index])%100-1))
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        );
                    }),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            color: Color.fromRGBO(34, 15, 45, 1),
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 4, left: 30, right: 30),
              child: FlatButton(
                onPressed: (){
                  void _showModalBottomSheet(BuildContext context) {
                    showModalBottomSheet<void>(
                      context: context,
                      barrierColor: Colors.black45,
                      shape : RoundedRectangleBorder(
                          borderRadius : BorderRadius.circular(20)
                      ),
                      isScrollControlled: true,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (BuildContext context,
                              StateSetter setState2) {
                            return MakeOrder(setState2);
                          },
                        );
                        //     return MakeOrder();

                      },
                    );

                  }
                  _showModalBottomSheet(context);

//                  showRoundedModalBottomSheet(
//                    context: context,
//                    autoResize: false,
//                    dismissOnTap: false,
//
//
//                    radius: 20.0,  // This is the default
//                    color: Colors.white,  // Also default
//                    builder: (context){
//                      return BottomMakeOrder("+7(930)722-96-02",16.0);
//                    },
//                  );


                  //Navigator.push(context, MaterialPageRoute(builder: (context) => MakeOrder()));


                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    side: BorderSide(color: Colors.white)),
                color: Colors.transparent,
                textColor: Colors.pinkAccent,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30, top: 8, bottom: 8),
                  child: Text("Оформить заказ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: "MPLUS",
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
        ],
      );

    }else{








      return SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text("В корзине пусто",
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 44,
                      fontFamily: "MPLUS",
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w300),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.50,
                  child: AspectRatio(
                    aspectRatio: 1/1,
                    child: Opacity(
                      opacity: 0.5,
                      child: Image.asset('assets/images/telega80.png',
                        fit: BoxFit.fill,),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                            "Вам может понравиться",
                            style: TextStyle(color: Colors.white, fontSize: 35,),
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[

                          Column(
                            children:
                            List.generate(ColumnOne, (index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 18.0),
                                child: Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.44,
                                  child: Stack(
                                    children: <Widget>[

                                      Column(
                                        children: <Widget>[
                                          AspectRatio(
                                            aspectRatio: 9 / 12,
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.circular(15),
                                                child: Image.network(
                                                  SearchResult[index*2]
                                                      .picture, fit: BoxFit.fill,)),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                child: Expanded(
                                                  flex: 7,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding: const EdgeInsets.only(
                                                            left: 16.0, top: 4, right: 2),
                                                        child: FittedBox(
                                                          fit: BoxFit.contain,
                                                          child: Text(SearchResult[index*2]
                                                              .head, style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 16),),
                                                        ),
                                                      ),
                                                      Padding(
                                                          padding: const EdgeInsets.only(
                                                              left: 16.0),
                                                          child: Prise(SearchResult[index*2])
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(right: 8.0),
                                                  child: Container(
                                                      height: 30,
                                                      width: 30,
                                                      child: TrashButton(SearchResult[index*2])),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: LikeButton(elementInfo(populations[index*2]~/100-1, populations[index*2]%100-1)),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                          Column(
                            children:
                            List.generate(ColumnTwo, (index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 18.0),
                                child: Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.44,
                                  child: Stack(
                                    children: <Widget>[

                                      Column(
                                        children: <Widget>[
                                          AspectRatio(
                                            aspectRatio: 9 / 12,
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.circular(15),
                                                child: Image.network(
                                                  SearchResult[index*2+1]
                                                      .picture, fit: BoxFit.fill,)),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                child: Expanded(
                                                  flex: 7,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding: const EdgeInsets.only(
                                                            left: 16.0, top: 4, right: 2),
                                                        child: FittedBox(
                                                          fit: BoxFit.contain,
                                                          child: Text(SearchResult[index*2+1]
                                                              .head, style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 16),),
                                                        ),
                                                      ),
                                                      Padding(
                                                          padding: const EdgeInsets.only(
                                                              left: 16.0),
                                                          child: Prise(SearchResult[index*2+1])
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(right: 8.0),
                                                  child: Container(
                                                      height: 30,
                                                      width: 30,
                                                      child: TrashButton(SearchResult[index*2+1])),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: LikeButton(elementInfo(populations[index*2+1]~/100-1, populations[index*2+1]%100-1)),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),

                    ],
                  ),
                )
              ],
            ),
          ),
        ),




      );
    }






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


  Widget Date(StateSetter setState2){
    DateTime date;
    _showDatePicker() async {
      date = await showDatePicker(
        helpText: "",
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
      );
      setState2(() {
        selectedDate = true;
        date2 = date.day.toString()+" "+_month(date.month.toString());
        date3 = date.day.toString()+"."+date.month.toString();
      });

    }
    print("=========================" + date2);

    if(selectedDate == false){
      print("Дата невыбрана");
      return Row(
        children: [
          Text("Выберите ", style:  TextStyle(
              color: Colors.black,
              fontSize: sizeText,
              fontFamily: "MPLUS",
//              decoration: TextDecoration.underline,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w300),),
          GestureDetector(
            onTap: (){
              _showDatePicker();
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
          Text("", style:  TextStyle(
              color: Colors.black,
              fontSize: sizeText,
              fontFamily: "MPLUS",
//              decoration: TextDecoration.underline,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w300),),
          GestureDetector(
            onTap: (){
              _showDatePicker();
            },
            child: Text(date2, style:  TextStyle(
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

  String time0 (int min){
    if(min < 10)
      return "0" + min.toString();
    else return min.toString();
    
  }

  //НЕ ЗАБЫТЬ ПОСАВИТЬ ФЛАГ selected КОГДА ВЫБРАНО ВРЕМЯ!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  Widget Time(StateSetter setState2){
    TimeOfDay time;
    _showTimePicker() async {
      time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      setState2(() {
        selectedTime = true;
        time2 = "${time.hour}:${time0(time.minute%60)}";
      });

    }
    if(!selectedTime){
      return Row(
        children: [
          Text("Выберите ", style:  TextStyle(
              color: Colors.black,
              fontSize: sizeText,
              fontFamily: "MPLUS",
//              decoration: TextDecoration.underline,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w300),),
          GestureDetector(
            onTap: (){
              _showTimePicker();
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
          Text("В ", style:  TextStyle(
              color: Colors.black,
              fontSize: sizeText,
              fontFamily: "MPLUS",
//              decoration: TextDecoration.underline,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w300),),
          GestureDetector(
            onTap: (){
              _showTimePicker();
            },
            child: Text(time2, style:  TextStyle(
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
  Widget city(StateSetter setState3){
    void showAndSetMenuSelection(BuildContext context, String value) {
      setState3(() {
        _cityValue = value;
      });
      print(_cityValue);
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      child: PopupMenuButton<String>(
        padding: EdgeInsets.zero,
        initialValue: _cityValue,
        onSelected: (value) => showAndSetMenuSelection(context, value),
        child: ListTile(
          title: Text("Выберите город"),
          subtitle: Text(_cityValue),
        ),
        itemBuilder: (context) => <PopupMenuItem<String>>[
          PopupMenuItem<String>(
            value: "Москва",
            child: Text("Москва"),
          ),
          PopupMenuItem<String>(
            value: "Омск",
            child: Text("Омск"),
          ),
          PopupMenuItem<String>(
            value: "Казань",
            child: Text("Казань"),
          ),
        ],
      ),
    );
  }

  Widget SelectAddress(StateSetter setState3, String value){
    final FocusNode streetFocusNode = new FocusNode () ;
    final FocusNode houseFocusNode = new FocusNode () ;
    final FocusNode kvFocusNode = new FocusNode () ;
    final FocusNode stroenieFocusNode = new FocusNode () ;
    final FocusNode corpusFocusNode = new FocusNode () ;
    TextEditingController streetController = TextEditingController(),
        houseController = TextEditingController(),
        kvController = TextEditingController(),
        stroenieController = TextEditingController(),
        corpusController = TextEditingController();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16)
        ),
      ),
      height: 800,
      width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height*0.5,
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
//                  color: Colors.white70,
                  height: 70,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, top : 20),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                            _cityValue = "Москва";
                          },
                          child: Text("Отмена", style:  TextStyle(
                              color: Colors.blueAccent,
                              fontSize: sizeText,
                              fontFamily: "MPLUS",
                              decoration: TextDecoration.underline,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500),),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(height: 3, color: Colors.black45,),
                Container(
                  width: MediaQuery.of(context).size.width*0.90,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: <Widget>[
                          city(setState3),
                          Row(
                            children: <Widget>[
                              Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left:0.0),
                                    child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text("*Улица:", style: TextStyle(fontSize: 16),)),
                                  )),
                              Expanded(
                                flex: 4,
                                child: TextField(
                                  focusNode: streetFocusNode,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.multiline,
                                  controller: streetController,
                                  cursorColor: Colors.deepPurple,
                                  decoration: InputDecoration(
                                    filled: false,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text("*Дом:", style: TextStyle(fontSize: 16),)),
                              ),
                              Expanded(
                                flex: 2,
                                child: TextField(
                                  focusNode: houseFocusNode,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.multiline,
                                  controller: houseController,
                                  cursorColor: Colors.deepPurple,
                                  decoration: InputDecoration(
                                    filled: false,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width*0.03,
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text("Квартира:", style: TextStyle(fontSize: 16),)),
                              ),
                              Expanded(
                                flex: 2,
                                child: TextField(
                                  focusNode: kvFocusNode,
                                  textInputAction: TextInputAction.next,
                                  controller: kvController,
                                  cursorColor: Colors.deepPurple,
                                  decoration: InputDecoration(
                                    filled: false,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left:0.0),
                                    child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text("Строение:", style: TextStyle(fontSize: 16),)),
                                  )),
                              Expanded(
                                flex: 2,
                                child: TextField(
                                  focusNode: stroenieFocusNode,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.multiline,
                                  controller: stroenieController,
                                  cursorColor: Colors.deepPurple,
                                  decoration: InputDecoration(
                                    filled: false,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.02,
                                ),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left:0.0),
                                    child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text("Корпус:", style: TextStyle(fontSize: 16),)),
                                  )),
                              Expanded(
                                flex: 3,
                                child: TextField(
                                  focusNode: corpusFocusNode,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.multiline,
                                  controller: corpusController,
                                  //  cursorColor: Colors.purple,
                                  decoration: InputDecoration(
                                    filled: false,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 48.0, bottom: 28),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child:
                          Center(
                            child: FlatButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  side: BorderSide(color: Colors.black)),
                              color: Colors.white,
                              textColor: Colors.purple,
                              padding: EdgeInsets.all(8.0),
                              onPressed: () {
                                if(_cityValue != "" && streetController.text != "" && houseController.text != ""){
                                  adress Address = adress(city: _cityValue, street: streetController.text, house: houseController.text,
                                      corpus: corpusController.text, stroenie: stroenieController.text, kv: kvController.text);
                                  ObjectAddress.addAddress(Address);
                                  print(Address);
                                  setState3(() {
                                    selectAdress = (ObjectAddress.getAddresses().length+1).toString();
                                  });
                                  Navigator.pop(context);
                                  print("=========selectAdres=======" + selectAdress);
                                }else{
                                  print("===== Заполните обязательные поля");
                                }

                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left : 8.0, right: 8.0),
                                child: Text(
                                  'Добавить',
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Colors.black,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //------------------------------------------------------------------------------------------------------------Сюда наполнение заказа
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text("Добавить адрес", style:  TextStyle(
                    color: Colors.black,
                    fontSize: sizeText+10,
                    fontFamily: "MPLUS",
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500),),
              ),
            ),
          ],
        ),
      ),
    );

  }
  void showAndSetMenuSelection(BuildContext context, String value, StateSetter setState2) {
    print(selectAdress);

    setState2(() {
      selectAdress = value;
    });
    if(selectAdress == "0"){
      print("yeah");
      showModalBottomSheet<void>(
        context: context,
        barrierColor: Colors.black45,
        shape : RoundedRectangleBorder(
            borderRadius : BorderRadius.circular(20)
        ),
        isScrollControlled: true,
        builder: (context) {
          return SelectAddress(setState2, value);

        },
      );
    }
    print(selectAdress);

  }


  Widget adressSelect(StateSetter setState2){

    return Container(
      child: PopupMenuButton<String>(
        padding: EdgeInsets.zero,
        initialValue: selectAdress,
        onSelected: (value) { showAndSetMenuSelection(context, value, setState2);

        setState(() {
          selectAdress = value;
        });},
        child: Adress(selectAdress),
        itemBuilder: (context) => List.generate(ObjectAddress.getAddresses().length+1, (index) {
          setState(() {

          });
          if(index == ObjectAddress.getAddresses().length){
            return PopupMenuItem<String>(
              value: "0",
              child: Row(
                children: [
                  Icon(Icons.add),
                  Padding(
                    padding:  EdgeInsets.only(left:8.0),
                    child: Text("Добавить адрес"),
                  ),
                ],
              ),
            );
          }
          adress step = ObjectAddress.getAddresses()[index];

          String buildAdress(){
            String total = step.city+", "+step.street+ " "+ step.house;
            if(step.corpus!= "null"){
              total+= step.corpus;
            }
            if(step.stroenie!= "null"){
              total+= "C"+step.stroenie;
            }
            if(step.kv!= "null"){
              total+= ", кв. "+step.kv;
            }
            return total;
          }
          return PopupMenuItem<String>(
            value: (index+1).toString(),
            child: Text(buildAdress(), style:  TextStyle(
                color: Colors.black,
                fontSize: sizeText,
                fontFamily: "MPLUS",
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500)),
          );
        }),
      ),
    );

  }
  Widget Adress(String selectAdress){
    if(selectAdress == "-1" || selectAdress == "0"){
      print("address $selectAdress");
      return Row(
        children: [
          Text("Укажите ", style:  TextStyle(
              color: Colors.black,
              fontSize: sizeText,
              fontFamily: "MPLUS",
//              decoration: TextDecoration.underline,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w300),),
          Text("адрес", style:  TextStyle(
              color: Colors.blueAccent,
              fontSize: sizeText,
              fontFamily: "MPLUS",
              decoration: TextDecoration.underline,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w300),),
        ],
      );
    }else{

      print("1address $selectAdress");

      adress step = ObjectAddress.getAddresses()[int.parse(selectAdress)-1];

      String buildAdress(){
        String total = step.city+", "+step.street+ " "+ step.house;
        if(step.corpus!= "null"){
          total+= step.corpus;
        }
        if(step.stroenie!= "null"){
          total+= "C"+step.stroenie;
        }
        if(step.kv!= "null"){
          total+= ", кв. "+step.kv;
        }
        return total;
      }

      return Row(
        children: [
          Text("По адресу  ", style:  TextStyle(
              color: Colors.black,
              fontSize: sizeText,
              fontFamily: "MPLUS",
//              decoration: TextDecoration.underline,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w300),),
          Text(buildAdress(), style:  TextStyle(
              color: Colors.blueAccent,
              fontSize: sizeText,
              fontFamily: "MPLUS",
              decoration: TextDecoration.underline,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w300),),
        ],
      );

    }
  }

  String text = '';


  void _onKeyboardTap(String value) {
    print(text);
    setState(() {
      text = text + value;
    });
  }


  Widget numberWidget(int position) {
    try {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))
        ),
        child: Center(child: Text(
          text[position], style: TextStyle(color: Colors.black),)),
      );
    } catch (e) {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))
        ),
      );
    }
  }

  Widget CheckSwitchNumber(StateSetter setState2){
    String num = maskFormatter.getUnmaskedText();
    void _onLoading() async {
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
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 2 / 3,
              height: 80,
              child: Center(
                child: new CircularProgressIndicator(),
              ),
            ),

          );
        },
      );
      if (text.length == 4) {
        print(
            'http://eclipsedevelop.ru/api.php/cbcheckcode?num=7$num&code=$text');
        Future<http.Response> fetchAlbum() async {
          return await http.get(
              'http://eclipsedevelop.ru/api.php/cbcheckcode?num=7$num&code=$text');
        }

        fetchAlbum().then((value) {
          if (value.statusCode == 200) {
            print(value.body);
            var res = value.body;
            var response = jsonDecode(res);
            // ignore: non_constant_identifier_names
            String Response = response["response"];
            // ignore: unrelated_type_equality_checks
            if (Response == "3") {
              setState2(() {
                text = '';
                numOrder = "7"+num;
              });
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);

            }
            // ignore: unrelated_type_equality_checks
            if (Response == "4") {
              print('Code don\'t verification');
            }
          }
          else {
            print(value.statusCode);
          }
        });
      } else {
        //Если код не введен
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16)
        ),
      ),
      //height: 800,
      width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height*0.5,
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
//                  color: Colors.white70,
                  height: 70,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, top : 20),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Text("Отмена", style:  TextStyle(
                              color: Colors.blueAccent,
                              fontSize: sizeText,
                              fontFamily: "MPLUS",
                              decoration: TextDecoration.underline,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500),),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(height: 3, color: Colors.black45,),
                Container(
                  width: MediaQuery.of(context).size.width*0.90,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          numberWidget(0),
                          numberWidget(1),
                          numberWidget(2),
                          numberWidget(3),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child:
                        Center(
                          child: FlatButton(
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                side: BorderSide(color: Colors.black)),
                            color: Colors.white,
                            textColor: Colors.purple,
                            padding: EdgeInsets.all(8.0),
                            onPressed: () {
                              _onLoading();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left : 8.0, right: 8.0),
                              child: Text(
                                'Отправить',
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                      NumericKeyboard(
                        onKeyboardTap: (String value){
                          setState2(() {
                            text = text + value;
                          });
                          print(text);
                        },
                        textColor: Colors.black87,
                        rightIcon: Icon(
                          Icons.backspace,
                          color: Colors.black87,
                        ),
                        rightButtonFn: () {
                          setState2(() {
                            text = text.substring(0, text.length - 1);
                          });
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text("Ввод кода", style:  TextStyle(
                    color: Colors.black,
                    fontSize: sizeText+10,
                    fontFamily: "MPLUS",
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500),),
              ),
            ),
          ],
        ),
      ),
    );

  }
  MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
      mask: '(###) ###-##-##', filter: { "#": RegExp(r'[0-9]') });

  Widget SwitchNumber(StateSetter setState2){
    void _onLoading() async {
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
      new  Future.delayed(new Duration(seconds: 3), () async {

        String num = maskFormatter.getUnmaskedText();
        print(num);
        var response = await http.get('http://eclipsedevelop.ru/api.php/cbgetcode?num=7$num');
        print('http://eclipsedevelop.ru/api.php/cbgetcode?num=7$num');
        showModalBottomSheet<void>(
          context: context,
          barrierColor: Colors.black45,
          shape : RoundedRectangleBorder(
              borderRadius : BorderRadius.circular(20)
          ),
          isScrollControlled: true,
          builder: (context) {
            return StatefulBuilder(
              builder: (BuildContext context,
                  StateSetter setState3) {
                return CheckSwitchNumber(setState3);
              },
            );

          },
        );

      });
    }


    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16)
        ),
      ),
      height: 800,
      width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height*0.5,
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
//                  color: Colors.white70,
                  height: 70,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, top : 20),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Text("Отмена", style:  TextStyle(
                              color: Colors.blueAccent,
                              fontSize: sizeText,
                              fontFamily: "MPLUS",
                              decoration: TextDecoration.underline,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500),),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(height: 3, color: Colors.black45,),
                Container(
                  width: MediaQuery.of(context).size.width*0.90,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: <Widget>[
                          SizedBox(height: 10,),
                          Row(
                            children: <Widget>[
                              Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right:20.0),
                                    child: Text("*Номер телефона:  ", style: TextStyle(fontSize: 18),),
                                  )),
                              Expanded(
                                flex: 1,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [maskFormatter],
                                  decoration: InputDecoration(
                                    // hintText: "+7",
                                    prefix: Text('+7 '),
                                    hintStyle: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(top:16.0),
                            child: Text("Вам придет СМС с кодом подтверждения", style: TextStyle(fontSize: 16),),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0, bottom: 28),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child:
                          Center(
                            child: FlatButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  side: BorderSide(color: Colors.black)),
                              color: Colors.white,
                              textColor: Colors.purple,
                              padding: EdgeInsets.all(8.0),
                              onPressed: () {
                                _onLoading();


                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left : 8.0, right: 8.0),
                                child: Text(
                                  'Отправить',
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Colors.black,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //------------------------------------------------------------------------------------------------------------Сюда наполнение заказа
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text("Смена номера", style:  TextStyle(
                    color: Colors.black,
                    fontSize: sizeText+10,
                    fontFamily: "MPLUS",
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500),),
              ),
            ),
          ],
        ),
      ),
    );

  }
  String numOrder = num;

  Widget Telephone(StateSetter setState2){
    return Row(
      children: [
        Text("По номеру "+ numOrder+ " (", style:  TextStyle(
            color: Colors.black,
            fontSize: sizeText,
            fontFamily: "MPLUS",
//              decoration: TextDecoration.underline,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w300),),
        GestureDetector(
          onTap: (){
            showModalBottomSheet<void>(
              context: context,
              barrierColor: Colors.black45,
              shape : RoundedRectangleBorder(
                  borderRadius : BorderRadius.circular(20)
              ),
              isScrollControlled: true,
              builder: (context) {
                return SwitchNumber(setState2);

              },
            );
          },
          child: Text("изменить", style:  TextStyle(
              color: Colors.blueAccent,
              fontSize: sizeText,
              fontFamily: "MPLUS",
              decoration: TextDecoration.underline,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w300),),
        ),
        Text(")", style:  TextStyle(
            color: Colors.black,
            fontSize: sizeText,
            fontFamily: "MPLUS",
//              decoration: TextDecoration.underline,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w300),),
      ],
    );
  }
  TextEditingController controllerPromo = TextEditingController();
  TextEditingController controllerComment = TextEditingController();

  Widget commentField(){
    return TextField(
      controller: controllerComment,
        decoration: InputDecoration(
          focusColor: Colors.black,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(10.0)
          ),
        )
    );
  }

  Widget promoField(){
    return TextField(
      controller: controllerPromo,
        obscureText: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(10.0)
          ),
        )
    );
  }



  Widget MakeOrder(StateSetter setState2){
    Future<bool> acceptGetAddress = ObjectAddress.AdressListUp();
    ObjectAddress.getAddresses();
    return Container(

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16)
        ),
      ),

      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.95,
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
//                  color: Colors.white70,
                  height: 70,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, top : 20),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                            selectedDate = false;
                            selectAdress = "-1";
                            selectedTime = false;
                          },
                          child: Text("Отмена", style:  TextStyle(
                              color: Colors.blueAccent,
                              fontSize: sizeText,
                              fontFamily: "MPLUS",
                              decoration: TextDecoration.underline,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500),),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(height: 3, color: Colors.black45,),
                Container(
                  width: MediaQuery.of(context).size.width*0.90,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Text("Когда", style:  TextStyle(
                                color: Colors.black,
                                fontSize: sizeText+4,
                                fontFamily: "MPLUS",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500),),
                            Text(" приехать мастеру?", style:  TextStyle(
                                color: Colors.black,
                                fontSize: sizeText+4,
                                fontFamily: "MPLUS",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400),),
                          ],
                        ),
                      ),
                      Date(setState2),
                      Time(setState2),


                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Row(
                          children: [
                            Text("Куда", style:  TextStyle(
                                color: Colors.black,
                                fontSize: sizeText+4,
                                fontFamily: "MPLUS",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500),),
                            Text(" приехать мастеру?", style:  TextStyle(
                                color: Colors.black,
                                fontSize: sizeText+4,
                                fontFamily: "MPLUS",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400),),
                          ],
                        ),
                      ),
                      adressSelect(setState2),

                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Row(
                          children: [
                            Text("Как", style:  TextStyle(
                                color: Colors.black,
                                fontSize: sizeText+4,
                                fontFamily: "MPLUS",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500),),
                            Text(" с вами связаться?", style:  TextStyle(
                                color: Colors.black,
                                fontSize: sizeText+4,
                                fontFamily: "MPLUS",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400),),
                          ],
                        ),
                      ),
                      Text("Вам позвонит менеджер \nдля подтверждения записи", style:  TextStyle(
                          color: Colors.black54,
                          fontSize: sizeText-4,
//                          fontFamily: "MPLUS",
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w300),),
                      Telephone(setState2),
                      Padding(
                        padding:  EdgeInsets.only(left:  MediaQuery.of(context).size.width*0, right: MediaQuery.of(context).size.width*0, top: 10),
                        child: Divider(height: 3, color: Colors.black45,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Row(
                          children: [
                            Text("", style:  TextStyle(
                                color: Colors.black,
                                fontSize: sizeText+4,
                                fontFamily: "MPLUS",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500),),
                            Text("Промокод", style:  TextStyle(
                                color: Colors.black,
                                fontSize: sizeText+4,
                                fontFamily: "MPLUS",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w300),),
                          ],
                        ),
                      ),

                      Text("Оставьте поле пустым, если\nу вас нет промокода", style:  TextStyle(
                          color: Colors.black54,
                          fontSize: sizeText-4,
//                          fontFamily: "MPLUS",
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w300),),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: promoField(),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Row(
                          children: [
                            Text("", style:  TextStyle(
                                color: Colors.black,
                                fontSize: sizeText+4,
                                fontFamily: "MPLUS",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500),),
                            Text("Комментарий к записи", style:  TextStyle(
                                color: Colors.black,
                                fontSize: sizeText+4,
                                fontFamily: "MPLUS",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w300),),
                          ],
                        ),
                      ),
                      Text("Вы можете оставить свои\nпожелания к заказу", style:  TextStyle(
                          color: Colors.black54,
                          fontSize: sizeText-4,
//                          fontFamily: "MPLUS",
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w300),),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: commentField(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child:
                          Center(
                            child: FlatButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  side: BorderSide(color: Colors.black)),
                              color: Colors.white,
                              textColor: Colors.purple,
                              padding: EdgeInsets.all(8.0),
                              onPressed: ()async {

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

                                String res = await MakeOrderButton(selectAdress,date3+".2020",time2,numOrder,controllerPromo.text,controllerComment.text);

                                Navigator.of(context).pop();

                                showDialog<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content:  Text(res),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('OK'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );



                                },
                              child: Padding(
                                padding: const EdgeInsets.only(left : 8.0, right: 8.0),
                                child: Text(
                                  'Записаться',
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Colors.black,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //------------------------------------------------------------------------------------------------------------Сюда наполнение заказа
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text("Оформление", style:  TextStyle(
                    color: Colors.black,
                    fontSize: sizeText+10,
                    fontFamily: "MPLUS",
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500),),
              ),
            ),
          ],
        ),
      ),
    );
  }


}

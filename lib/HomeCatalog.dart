import 'dart:convert';
import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_regex_validator/constant.dart';
import 'package:flutter_regex_validator/validator.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp32/Detail.dart';
import 'package:flutterapp32/Push_Notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'Detail.dart';
import 'EmptyTrash.dart';
import 'Trash.dart';
import 'Objects.dart';
import 'package:http/http.dart' as http;
import 'MyOrders.dart';
import 'main.dart';
import 'home.dart';
import 'style.dart';


class HomeCatalog extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return _HomeCatalog();
  }

}

var cardAspectRatio  =  12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;


var cardAspectRatioSales  =  10.0 / 10.0;
var widgetAspectRatioSales = cardAspectRatioSales * 1.2;

int IndexPageTwo = 0;
int SelectedCategories = 0;


class _HomeCatalog extends State<HomeCatalog> with TickerProviderStateMixin{

  AnimationController controllerHomeOffset;
  Animation<double> animationHomeOffset;
  Tween tweenHomeOffset;




  @override
  void initState() {
    super.initState();

    controllerHomeOffset = AnimationController(vsync: this, duration: Duration(milliseconds: 300));


  }
  Future<bool> _onWillPop() {
    if(controllerHomeOffset.status == AnimationStatus.completed) {
      controllerHomeOffset.reverse();
    }else{
      Navigator.of(context).pop(true);
    }
  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: ArrowDown(),
      body: PageCatalog(),
    );
  }

  double SizedPlus = 0;
  double SizedPlus1 = 0;
  double SizedPlus2 = 0;
  double MarginPlus = 0;


  bool SeachOpasity = false;
  List<int> SearchIds = [];
  double SearchPadding = 0.0;
  var _controller = TextEditingController();
  bool cancel = false;
  String SearchResultText = "";

  bool ArrowDownOpasity = true;
  ScrollController scrollControllerHome = ScrollController();


  List<int> Likes =[101,202];
  var currentPageC = UrlImage_c.length-1.0;
  var currentPageS = UrlImage_c.length-1.0;

  Widget ArrowDown(){
    if(ArrowDownOpasity &&  controllerHomeOffset.status != AnimationStatus.completed)
    return  FloatingActionButton(
    child: Icon(Icons.keyboard_arrow_down,size: 30,),
    onPressed: (){
      scrollControllerHome.animateTo(250.0, duration: Duration(milliseconds: 200), curve: Curves.easeInCubic);
      setState(() {
        ArrowDownOpasity = false;
      });
    },
    backgroundColor: Colors.white70,
    foregroundColor: Colors.black,
    );
    else return SizedBox();
  }


  Widget PageCatalog(){

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset('assets/images/backround.png',
              fit: BoxFit.fill,),
          ),

          Content(),

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
      ),
    );
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

  Widget Content(){

    tweenHomeOffset = Tween<double>(begin: 1.0, end: 0.0);
    animationHomeOffset = tweenHomeOffset.animate(controllerHomeOffset);




    controllerHomeOffset.addListener(() {
      if(controllerHomeOffset.status == AnimationStatus.completed){
      }
      setState(() {

      });
    });

    scrollControllerHome.addListener(() {

      if(scrollControllerHome.offset> 150){
        setState(() {
          ArrowDownOpasity = false;
        });
      }
    });


    double Trans = MediaQuery.of(context).size.width*(1.0-animationHomeOffset.value);
    double OpasityHome = animationHomeOffset.value;

    Widget PageTwo(){
      switch(IndexPageTwo){
        case 0: {
          return SizedBox();
        }
        case 1:{
          HelpItemCount InfSelected = ItemCount(SelectedCategories);

          int ColumnOne;
          int ColumnTwo;

          if(InfSelected.count%2 > 0){
            ColumnOne = InfSelected.count~/2+1;
            ColumnTwo = InfSelected.count ~/2;
          }else{
            ColumnOne = InfSelected.count~/2;
            ColumnTwo = InfSelected.count~/2;
          }


          return SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child:
              Stack(
                children: [
                  Positioned(
                    left: 10,
                    top: 25,
                    child: GestureDetector(
                      onTap: (){
                        controllerHomeOffset.reverse();

                      },
                      child: Icon(Icons.arrow_back, color: Colors.white,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                            InfSelected.name, style: TextStyle(color: Colors.white, fontSize: 35, ),
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
                                    width: MediaQuery.of(context).size.width* 0.44,
                                    child: Column(
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: (){
                                            Navigator.push(context,  MaterialPageRoute(builder: (context) => Detail(((elementInfo(SelectedCategories, index*2))))));
                                          },
                                          child: Hero(
                                            tag: elementInfo(SelectedCategories, index*2).id,
                                            child: AspectRatio(
                                              aspectRatio: 9/12,
                                              child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(15),
                                                  //child: Image.network(elementInfo(SelectedCategories, index*2).picture, fit: BoxFit.fill,)),
                                                  child: Image(image: images[SelectedCategories][index*2].image, fit: BoxFit.fill,)),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(left : 16.0, top: 4),
                                                    child: Text(elementInfo(SelectedCategories, index*2).head, style: TextStyle(color: Colors.white, fontSize: 16),),
                                                  ),
                                                  Padding(
                                                      padding: const EdgeInsets.only(left: 16.0),
                                                      child: Prise(elementInfo(SelectedCategories, index*2))
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Padding(
                                                padding: const EdgeInsets.only(right: 8.0),
                                                child: Container(
                                                    height: 30,
                                                    width: 30,
                                                    child: TrashButton(elementInfo(SelectedCategories, index*2))),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:
                            List.generate(ColumnTwo, (index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 18.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width* 0.44,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.push(context,  MaterialPageRoute(builder: (context) => Detail(((elementInfo(SelectedCategories, index*2+1))))));
                                        },
                                        child: Hero(
                                          tag: elementInfo(SelectedCategories, index*2+1).id,
                                          child: AspectRatio(
                                            aspectRatio: 9/12,
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.circular(15),
//                                                child: Image.network(elementInfo(SelectedCategories, index*2+1).picture, fit: BoxFit.fill,)),
                                                child: Image(image: images[SelectedCategories][index*2+1].image, fit: BoxFit.fill,)),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.only(left : 16.0, top: 4),
                                                  child: Text(elementInfo(SelectedCategories, index*2+1).head, style: TextStyle(color: Colors.white, fontSize: 16),),
                                                ),
                                                Padding(
                                                    padding: const EdgeInsets.only(left: 16.0),
                                                    child: Prise(elementInfo(SelectedCategories, index*2+1))
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 8.0),
                                              child: Container(
                                                  height: 30,
                                                  width: 30,
                                                  child: TrashButton(elementInfo(SelectedCategories, index*2+1))),
                                            ),
                                          )
                                        ],
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
                ],
              ),
            ),
          );

        }
      }
    }


    Widget SearchInput(){
     TextEditingController cont = TextEditingController();
     FocusNode focusNode = FocusNode();


      return  Container(
        width: MediaQuery.of(context).size.width*0.90,
        child: Center(
          child: TextField(
            focusNode: focusNode,
            onChanged: (text) {
              cont.text = text;
              print("Search: $text");
              SearchIds.clear();

              if(text.length>0) {
                cancel = true;
                SeachOpasity = true;

                for (int i = 0; i < 7; i ++) {
                  for (int j = 0; j < ItemCount(i).count; j++) {
                    ElementItem step = elementInfo(i, j);
                    RegExp exp = new RegExp(text.toLowerCase());
                    String str = step.head.toLowerCase();
                    if(exp.hasMatch(str)){
                      SearchIds.add(step.id);
                    }
                    setState(() {

                    });


                  }
                }
                for (int i = 0; i < 7; i ++) {
                  for (int j = 0; j < ItemCount(i).count; j++) {
                    ElementItem step = elementInfo(i, j);
                    RegExp exp = new RegExp(text.toLowerCase());
                    String str2 = step.tx.toLowerCase();
                    if(exp.hasMatch(str2)){
                      SearchIds.add(step.id);
                    }
                    setState(() {

                    });


                  }
                }
                if(SearchIds.length>0){
                  SearchResultText = "Вот что мы нашли";
                }else{
                  SearchResultText = "Мы ничего не нашли :(";
                }
              }else{
                SearchIds.clear();
                SeachOpasity = false;
                cancel = false;
                setState(() {

                });
              }
            },

            controller: _controller,
            style: TextStyle(color: Colors.white),
            maxLines: 1,
            decoration: InputDecoration(
              hintText: "Поиск",
              hintStyle: TextStyle(color: Colors.white60),
              enabledBorder: const OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderSide: const BorderSide(color: Colors.white, width: 1.2),
                borderRadius: BorderRadius.all(
                  Radius.circular(30),

                ),
              ),

              labelStyle: TextStyle(color: Colors.white),
              border: OutlineInputBorder(

                borderSide:  BorderSide(color: Colors.white, width: 1.0),
                borderRadius: BorderRadius.all(
                  Radius.circular(30),

                ),
              ),

              fillColor: Colors.transparent,
              filled: true,
              suffixIcon: IconButton(
                onPressed: () {
                  cancel = false;
                  SeachOpasity = false;
                  _controller.clear();
                  setState(() {

                  });},
                icon: Icon(cancel?Icons.cancel:Icons.search),
                color: Colors.white70,
              ),
            ),
          ),
        ),
      );
    }


    Widget Search()   {


      int count = SearchIds.length;
      int ColumnOne;
      int ColumnTwo;

      if(!SeachOpasity){

        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Container(
                width: MediaQuery.of(context).size.width*0.90,
                child:
                Text("Категории",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 44,
                      fontFamily: "MPLUS",
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w300),
                ),

              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.90,
              child:Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: <Widget>[
                    FlatButton(
                      onPressed: (){

                        setState(() {
                          SeachOpasity = !SeachOpasity;
                        });
                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          side: BorderSide(color: Colors.white)),
                      color: Colors.transparent,
                      textColor: Colors.pinkAccent,
                      child: Text("Акции",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: "MPLUS",
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:14.0),
                      child: Text("more 30+",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: "MPLUS",
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400),
                      ),
                    ),

                  ],
                ),
              ),
            ),

            //
            //
            //
            //_______________________________________________________
            //
            //
            //
            SlideCategories(),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Container(
                width: MediaQuery.of(context).size.width*0.90,
                child:
                Text("Скидки",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontFamily: "MPLUS",
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w300),
                ),

              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.90,
              child:Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: <Widget>[
                    FlatButton(
                      onPressed: (){
                        scrollControllerHome.animateTo(0.0, duration: Duration(milliseconds: 200), curve: Curves.easeInCubic);
                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          side: BorderSide(color: Colors.white)),
                      color: Colors.transparent,
                      textColor: Colors.pinkAccent,
                      child: Text("Подробнее",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: "MPLUS",
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:14.0),
                      child: Text("Мои купоны",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: "MPLUS",
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400),
                      ),
                    ),

                  ],
                ),
              ),
            ),
            //
            //
            //
            //______________________________________________________________
            //
            //
            //
            Container(
                margin: EdgeInsets.only(bottom: 0, top: 12),
                child: SliderSales1()),
            //
            //
            //
            //______________________________________________________________
            //
            //
            //
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Container(
                width: MediaQuery.of(context).size.width*0.90,
                child:
                Center(
                  child: Text("Популярное",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontFamily: "MPLUS",
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w300),
                  ),
                ),

              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.90,
              child:Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      onPressed: (){
                        scrollControllerHome.animateTo(0.0, duration: Duration(milliseconds: 200), curve: Curves.easeInCubic);
                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          side: BorderSide(color: Colors.white)),
                      color: Colors.transparent,
                      textColor: Colors.pinkAccent,
                      child: Text("Подробнее",
                        style: TextStyle(
                            color: Colors.white,
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
            //
            //
            //
            //______________________________________________________________
            //
            //
            //
            Container(
                margin: EdgeInsets.only(bottom: 0, top: 12),
                child: SliderPop()),
            //
            //
            //
            //______________________________________________________________
            //
            //
            //
            //

            //
            //
            //
            //______________________________________________________________
            //
            //
            //
//            Container(
//                margin: EdgeInsets.only(bottom: 0, top: 12),
//                child: SliderLikes()),
          ],
        );

        //_________________________________________________________________________________



      }
      else
        {

      if (count % 2 > 0) {
        ColumnOne = count ~/ 2 + 1;
        ColumnTwo = count ~/ 2;
      } else {
        ColumnOne = count ~/ 2;
        ColumnTwo = count ~/ 2;
      }


      List<ElementItem> SearchResult=[];


      for(int i = 0; i < SearchIds.length;i++){
        SearchResult.add(elementInfo(SearchIds[i]~/100-1, SearchIds[i]%100-1));
      }



      return Container(
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
                  SearchResultText,
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
//                                      child: Image.network(SearchResult[index*2].picture, fit: BoxFit.fill,)),
                                      child: Image(image: images[SearchResult[index*2].id~/100-1][SearchResult[index*2].id%100-1].image, fit: BoxFit.fill,)),
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
                              child: LikeButton(SearchResult[index*2]),
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
//                                      child: Image.network(SearchResult[index*2+1].picture, fit: BoxFit.fill,)),
                                      child: Image(image: images[SearchResult[index*2+1].id~/100-1][SearchResult[index*2+1].id%100-1].image, fit: BoxFit.fill,)),
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
                              child: LikeButton(SearchResult[index*2+1]),
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
      );
    }

    }



    Widget PageCatalog(){
      if(controllerHomeOffset.status != AnimationStatus.completed)
      return
      Opacity(
        opacity: OpasityHome,
        child: Transform.translate(
          offset: Offset(Trans,0, ),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),

            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              controller: scrollControllerHome,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.only(top : 18.0),
                    child: SearchInput(),
                  ),
                  //
                  //
                  //
                  //   Заголовок 1
                  //
                  //
                  //


                  //
                  //
                  //
                  //_______________________________________________________
                  //
                  //
                  //
                  AnimatedPadding(
                    duration: Duration(milliseconds: 200),
                    padding:  EdgeInsets.only(top: SearchPadding),
                    child: Search(),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      else
        return SizedBox();

    }




    return Stack(
      children: <Widget>[
        PageCatalog(),
        Opacity(
          opacity: 1.0 - OpasityHome,
          child: Transform.translate(
              offset: Offset(0 - MediaQuery.of(context).size.width + Trans,0, ),
              child: PageTwo()),
        ),

      ],
    );

  }

  Widget SlideCategories(){
    PageController controllerC = PageController(initialPage: UrlImage_c.length-1);
    controllerC.addListener(() {
      setState(() {
        currentPageC = controllerC.page;
      });
    });







    int SelectPage = 0;
    var currentPage = currentPageC;
    var padding = 20.0;
    var verticalInset = 20.0;

//    CardScrollWidget(this.currentPage);


    Widget CardScrollWidget() {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: AspectRatio(
          aspectRatio: widgetAspectRatio,
          child: LayoutBuilder(
            builder: (context,contraints){
              var width = contraints. maxWidth;
              var height = contraints. maxHeight;

              var safeWidth = width - 2 * padding;
              var safeHeight = height - 2 * padding;

              var heigtOfPrimaryCard = safeHeight;
              var widthOfPrimaryCard = heigtOfPrimaryCard*cardAspectRatio;

              var primaryCardLeft = safeWidth  - widthOfPrimaryCard;
              var horizontalInset =  primaryCardLeft / 2;

              List<Widget> cardList = List();

              for(int i = 0; i < UrlImage_c.length; i++){
                var delta = i - currentPage;
                bool isOnRight = delta > 0;
                SelectPage = delta.toInt();

                var start = padding + max(primaryCardLeft - horizontalInset * -delta * (isOnRight? 15:1),0.0);

                var cardItem =Positioned.directional(
                top: padding + verticalInset * max(-delta,0.0),
                bottom: padding + verticalInset * max(-delta,0.0),
                start: start,
                textDirection: TextDirection.rtl,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            offset: Offset(3.0,6.0),
                            blurRadius: 10.0,
                          ),

                        ]
                    ),
                    child: AspectRatio(
                      aspectRatio: cardAspectRatio,
                      child: GestureDetector(
                        onTap: (){
                          IndexPageTwo = 1;
                          SelectedCategories = i;
                          controllerHomeOffset.forward();
                          print("onePress");},
                        child: Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            Image(
                              image: imagesCategory[UrlImage_c.length-1 - i].image, fit: BoxFit.cover,),
                            Container(
                              width:200,
                              height: 200,
                              color: Colors.black.withOpacity(0.4),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 3.0, right:  3.0),
                                  child: Text(Header[UrlImage_c.length-1 - i], style:
                                  TextStyle(
                                      color: Colors.white,
                                      fontSize: 34,
                                      fontFamily: "MPLUS",
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w300),),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                );
                cardList.add(cardItem);

              }
              return Stack(
                children: cardList,
              );
            },
          ),
        ),
      );
    }








    return GestureDetector(

      onTapDown: (TapDownDetails details){

        setState(() {
          SizedPlus = 10;
        });

      },
      onTapUp: (TapUpDetails details){
        setState(() {
          SizedPlus = 0;
        });

      },
      onTapCancel: (){
        setState(() {

          SizedPlus = 0;
        });
      },

      onTap: (){
        print("OnTap $SelectPage");

        controllerHomeOffset.forward();
        setState(() {
          IndexPageTwo = 1;
          SelectedCategories = SelectPage;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        margin: EdgeInsets.all(SizedPlus),
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            CardScrollWidget(),
          Positioned.fill(
            child: PageView.builder(
              itemCount: UrlImage_c.length,
              controller: controllerC,
              reverse: true,
              itemBuilder: (context,index){
                return Container();
              },
            ),
          )
          ],
        ),
      ),
    );
  }


  Widget SliderSales1(){
    List<ElementItem> sales = [ElementItem(0, '','', '', '', 0, 0,true, [101, 201, 30],[101, 201, 30],[101, 201, 30],[101, 201, 30])];
    sales.clear();
    for(int cat = 0; cat < 7; cat++){
      HelpItemCount step = ItemCount(cat);
      for(int item =0; item < step.count; item++){
       if(elementInfo(cat, item).sale>0){
         sales.add(elementInfo(cat, item));
       }
      }
    }

    return
      CarouselSlider.builder(
      itemCount: sales.length,
      options: CarouselOptions(
        height: 400,
        aspectRatio: 12/9,
        initialPage: 0,
        enableInfiniteScroll: true,
        viewportFraction: 0.55,
          enlargeCenterPage: true,
      ),
      itemBuilder: (BuildContext context, int itemIndex) =>
          Stack(
            children: <Widget>[
              AnimatedContainer(
                duration: Duration(milliseconds: 100),
                margin: EdgeInsets.all(MarginPlus),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context,  MaterialPageRoute(builder: (context) => Detail(sales[itemIndex])));
                     },

                      child: Hero(
                        tag: sales[itemIndex].id,

                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child:
                          Image(
                            image: images[sales[itemIndex].id~/100-1][sales[itemIndex].id%100-1].image,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left : 16.0, top: 4),
                                child: Text(sales[itemIndex].head, style: TextStyle(color: Colors.white, fontSize: 16),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Row(

                                  children: <Widget>[
                                    Text("${sales[itemIndex].price} руб.", style: TextStyle(color: Colors.white, fontSize: 16, decoration: TextDecoration.lineThrough,),),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text("${sales[itemIndex].price - sales[itemIndex].sale} руб.", style: TextStyle(color: Colors.pinkAccent, fontSize: 16),),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right:0.0),
                          child: TrashButton(sales[itemIndex]),
                        )
                      ],
                    ),

                  ],
                ),
              ),
              Positioned(
                top: -5,
                right: -5,
                child: LikeButton(sales[itemIndex]),
              ),
            ],
          ),
    );
  }

  Widget SliderPop(){

    List<ElementItem> sales = [ElementItem(0, '','', '', '', 0, 0,true, [101, 201, 30],[101, 201, 30],[101, 201, 30],[101, 201, 30])];
    sales.clear();
    for(int cat = 0; cat < 7; cat++){
      HelpItemCount step = ItemCount(cat);
      for(int item =0; item < step.count; item++){
        if(elementInfo(cat, item).population){
          sales.add(elementInfo(cat, item));
        }
      }
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




    return
      CarouselSlider.builder(
        itemCount: UrlImage_c.length,
        options: CarouselOptions(
          height: 400,
          aspectRatio: 12/9,
          initialPage: 0,
          enableInfiniteScroll: true,
          viewportFraction: 0.55,
          enlargeCenterPage: true,
        ),
        itemBuilder: (BuildContext context, int itemIndex) =>
            Stack(
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    Navigator.push(context,  MaterialPageRoute(builder: (context) => Detail(sales[itemIndex])));
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 100),
                    margin: EdgeInsets.all(SizedPlus1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Hero(
                          tag: sales[itemIndex].id,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: Image(
                              image: images[sales[itemIndex].id~/100-1][sales[itemIndex].id%100-1].image,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left : 16.0, top: 4),
                                    child: Text(sales[itemIndex].head, style: TextStyle(color: Colors.white, fontSize: 16),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Prise(sales[itemIndex])
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right:8.0),
                              child: TrashButton(sales[itemIndex]),
                            )
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: -5,
                  right: -5,
                  child: LikeButton(sales[itemIndex]),
                ),
              ],
            ),
      );
  }

  Widget SliderLikes(){

    if(ObjectLikes.getLikes().length>2){

     List<ElementItem> LikesList = [];

     for(int i = 0 ; i < ObjectLikes.getLikes().length; i ++){
       LikesList.add(elementInfo(int.parse(ObjectLikes.getLikes()[i])~/100-1,  int.parse(ObjectLikes.getLikes()[i])%100-1));
     }

      return
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Container(
                width: MediaQuery.of(context).size.width*0.90,
                child:
                Center(
                  child: Text("Избранное",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontFamily: "MPLUS",
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w300),
                  ),
                ),

              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.90,
              child:Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      onPressed: (){
                        scrollControllerHome.animateTo(0.0, duration: Duration(milliseconds: 200), curve: Curves.easeInCubic);
                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          side: BorderSide(color: Colors.white)),
                      color: Colors.transparent,
                      textColor: Colors.pinkAccent,
                      child: Text("Перейти",
                        style: TextStyle(
                            color: Colors.white,
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
            CarouselSlider.builder(
              itemCount: ObjectLikes.getLikes().length,
              options: CarouselOptions(
                height: 400,
                aspectRatio: 12/9,
                initialPage: 0,
                enableInfiniteScroll: false,
                viewportFraction: 0.55,
                enlargeCenterPage: true,
              ),
              itemBuilder: (BuildContext context, int itemIndex) =>
                  Stack(
                    children: <Widget>[
                      GestureDetector(
                        onTapDown: (TapDownDetails details){

                          setState(() {
                            SizedPlus2 = 10;
                          });

                        },
                        onTapUp: (TapUpDetails details){
                          setState(() {
                            SizedPlus2 = 0;
                          });

                        },
                        onTapCancel: (){
                          setState(() {

                            SizedPlus2 = 0;
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 100),
                          margin: EdgeInsets.all(SizedPlus2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Hero(
                                tag: itemIndex,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16.0),
                                  child: Image(
                                    image: images[int.parse(ObjectLikes.getLikes()[itemIndex])~/100-1][int.parse(ObjectLikes.getLikes()[itemIndex])%100-1].image,
                                  ),

                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(left : 16.0, top: 4),
                                          child: Text(LikesList[itemIndex].head, style: TextStyle(color: Colors.white, fontSize: 16),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 16.0),
                                          child: Prise(LikesList[itemIndex]),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right:8.0),
                                    child: TrashButton(LikesList[itemIndex]),
                                  )
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: -5,
                        right: -5,
                        child: LikeButton(LikesList[itemIndex]),
                      ),
                    ],
                  ),
            ),
          ],
        );


    }else{
      return SizedBox();
    }


  }

}




class CardScrollWidgetSales extends StatelessWidget {

  var currentPage;
  var padding = 20.0;
  var verticalInset = 20.0;

  CardScrollWidgetSales(this.currentPage);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: AspectRatio(
        aspectRatio: widgetAspectRatioSales,
        child: LayoutBuilder(
          builder: (context,contraints){
            var width = MediaQuery.of(context).size.width * 0.90;
            var height = contraints. maxHeight;

            var safeWidth = width - 2 * padding;
            var safeHeight = height - 2 * padding;

            var heigtOfPrimaryCard = safeHeight;
            var widthOfPrimaryCard = heigtOfPrimaryCard*cardAspectRatioSales;

            var primaryCardLeft = safeWidth  - widthOfPrimaryCard;
            var horizontalInset =  primaryCardLeft / 2;

            List<Widget> cardList = List();

            for(int i = 0; i < UrlImage_c.length; i++){

              var delta = i - currentPage;
              bool isOnRight = delta > 0;

              var start = padding + max(primaryCardLeft - horizontalInset * -delta * (isOnRight? 15:1),0.0);

              var cardItem = Positioned.directional(

                top: padding + verticalInset * max(-delta,0.0),
                bottom: padding + verticalInset * max(-delta,0.0),
                start: start,
                textDirection: TextDirection.rtl,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            offset: Offset(3.0,6.0),
                            blurRadius: 10.0,
                          ),

                        ]
                    ),
                    child: AspectRatio(
                      aspectRatio: cardAspectRatioSales,
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          Image(image: imagesCategory[UrlImage_c.length-1 - i].image, fit: BoxFit.cover,),
                          Container(
                            width:200,
                            height: 200,
                            color: Colors.black.withOpacity(0.4),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 3.0, right:  3.0),
                                child: Text(Header[UrlImage_c.length-1 - i], style:
                                TextStyle(
                                    color: Colors.white,
                                    fontSize: 34,
                                    fontFamily: "MPLUS",
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w300),),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
              cardList.add(cardItem);
            }
            return Stack(
              children: cardList,
            );
          },
        ),
      ),
    );
  }
}










































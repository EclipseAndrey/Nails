import 'dart:convert';
import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
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


class _HomeCatalog extends State<HomeCatalog>{

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: PageCatalog(),
    );
  }

  List<int> Likes =[101,202];
  var currentPageC = UrlImage_c.length-1.0;
  var currentPageS = UrlImage_c.length-1.0;

  Widget PageCatalog(){

    return Stack(
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
    );
  }


  Widget Content(){
    ScrollController scrollControllerHome = ScrollController();

    scrollControllerHome.addListener(() {

    });

    return Transform.rotate(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),

        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          controller: scrollControllerHome,
          child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           children: <Widget>[
             //
             //
             //
             //   Заголовок 1
             //
             //
             //

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
                       shape: new RoundedRectangleBorder(
                           borderRadius: BorderRadius.all(Radius.circular(25.0)),
                           side: BorderSide(color: Colors.white)),
                       color: Colors.white,
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
             //
             //
             //
             //_______________________________________________________
             //
             //
             //
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
             //
             //
             //
             //______________________________________________________________
             //
             //
             //
             Container(
                 margin: EdgeInsets.only(bottom: 0, top: 12),
                 child: SliderLikes()),
            ],
          ),
        ),
      ),
    );
  }

  Widget SlideCategories(){
    PageController controllerC = PageController(initialPage: UrlImage_c.length-1);
    controllerC.addListener(() {
      setState(() {
        currentPageC = controllerC.page;
      });
    });
    
    return Stack(
      children: <Widget>[
        CardScrollWidget(currentPageC),
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
    );
  }


  Widget SlideSales(){
    PageController controllerC = PageController(initialPage: UrlImage_c.length-1);
    controllerC.addListener(() {
      setState(() {
        currentPageS = controllerC.page;
      });
    });

    return Stack(
      children: <Widget>[
        CardScrollWidgetSales(currentPageS),
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
    );
  }


  Widget SliderSales1(){
    List<ElementItem> sales = [ElementItem(0, '', '', '', 0, 0,true)];
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.network(sales[itemIndex].picture),
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
                        padding: const EdgeInsets.only(right:8.0),
                        child: Icon(Icons.add_shopping_cart, color: Colors.white,),
                      )
                    ],
                  ),

                ],
              ),

            ],
          ),
    );
  }

  Widget SliderPop(){

    List<ElementItem> sales = [ElementItem(0, '', '', '', 0, 0,true)];
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.network(sales[itemIndex].picture),
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
                          child: Icon(Icons.add_shopping_cart, color: Colors.white,),
                        )
                      ],
                    ),

                  ],
                ),

              ],
            ),
      );
  }

  Widget SliderLikes(){

    if(Likes.length>0){

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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.network(UrlImage_c[itemIndex]),
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
                                  child: Text("XS Комплекс", style: TextStyle(color: Colors.white, fontSize: 16),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Row(

                                    children: <Widget>[
                                      Text("1600 руб.", style: TextStyle(color: Colors.white, fontSize: 16, decoration: TextDecoration.lineThrough,),),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Text("1099 руб.", style: TextStyle(color: Colors.pinkAccent, fontSize: 16),),


                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right:8.0),
                            child: Icon(Icons.add_shopping_cart, color: Colors.white,),
                          )
                        ],
                      ),

                    ],
                  ),

                ],
              ),
        );


    }else{
      return SizedBox();
    }


  }

}

class CardScrollWidget extends StatelessWidget {

  var currentPage;
  var padding = 20.0;
  var verticalInset = 20.0;

  CardScrollWidget(this.currentPage);


  @override
  Widget build(BuildContext context) {
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
                      aspectRatio: cardAspectRatio,
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          Image.network(UrlImage_c[UrlImage_c.length-1 - i], fit: BoxFit.cover,),
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
                          Image.network(UrlImage_c[UrlImage_c.length-1 - i], fit: BoxFit.cover,),
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










































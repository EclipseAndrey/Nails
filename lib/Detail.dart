import 'dart:ui';

import 'package:flutter/material.dart';
import 'FadeAnimation.dart';
import 'home.dart';
import './CustomDesign/nails_icons.dart' as custicon;
import 'main.dart';

class Detail extends StatefulWidget {
  ElementItem _elementItem;
  Detail(ElementItem elementItem){
    _elementItem = elementItem;
  }
  @override
  _DetailState createState() => _DetailState(_elementItem);
}

class _DetailState extends State<Detail> {
  ElementItem elementItem;
  _DetailState(ElementItem elementItem){
    this.elementItem = elementItem;
  }

  bool Save = false;
  bool Like = false;
  String Liketx = "В избранное";
  String Savetx = "В корзину";

  void stateLike(){
    print("+++++++++++++++++++++++++++++++++++++++++++");
    if(ObjectLikes.checkLike(elementItem.id))
      {
        print("++++++++++++++++++++++++++++"+ ObjectLikes.checkLike(elementItem.id).toString());
        Like = true;
      }else{
      print("++++++++++++++++++++++++++++"+ ObjectLikes.checkLike(elementItem.id).toString());

      Like = false;
    }

  }
  void stateTrash(){
    print("+++++++++++++++++++++++++++++++++++++++++++");
    if(ObjectTrash.checkTrash(elementItem.id))
    {
      print("++++++++++++++++++++++++++++"+ ObjectTrash.checkTrash(elementItem.id).toString());
      Save = true;
    }else{
      print("++++++++++++++++++++++++++++"+ ObjectTrash.checkTrash(elementItem.id).toString());

      Save = false;
    }

  }


  Widget Prise(ElementItem itemForSales){
    if(itemForSales.sale>0){
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,

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
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("${itemForSales.price} руб.", style: TextStyle(color: Colors.white, fontSize: 16, ),),
        ],
      );
    }
  }

  Widget SaveButton(){

    Widget icon(){
      if(!Save){

        return Icon(Icons.add_shopping_cart, color: Colors.white, size: 24,);
      }
      else
      {
        return Icon(custicon.Nails.telega_2, color: Colors.purpleAccent, size: 24,);
      }


    }


    return FlatButton(

      onPressed: ()async{

        Save = !Save;
        setState(() {
        });
        if(!Save){
          print(await ObjectTrash.deleteTrash(elementItem.id));
          await ObjectTrash.TrashListUp();
          setState(() {

          });
        }else{
          print(await ObjectTrash.addTrash(elementItem.id));
          await ObjectTrash.TrashListUp();
          setState(() {
          });
        }
        stateTrash();
        setState(() {
          print("UP");
        });

        //  setState(() { });
      },
      shape: new RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
          side: BorderSide(color: Colors.white)),
      color: Colors.transparent,
      textColor: Colors.pinkAccent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Text(Save?"Добавлено":"В корзину",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: "MPLUS",
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, ),
              child: icon(),
            ),
          ],
        ),
      ),
    );
  }

  Widget LikeButton(){


    Widget icon(){
      if(!Like){

        return Icon(custicon.Nails.heart_empty, color: Colors.white, size: 24,);
      }
      else
        {
        return  Icon(custicon.Nails.heart, color: Colors.pink, size: 24,);
        }


    }

    return FlatButton(
      onPressed: ()async{

          Like = !Like;
          if(!Like){
            print(await ObjectLikes.deleteLikes(elementItem.id));
            ObjectLikes.Likes();
            setState(() {

            });
          }else{
            print(await ObjectLikes.addLikes(elementItem.id));
             ObjectLikes.Likes();
            setState(() {
            });
          }

        //  setState(() { });
      },
      shape: new RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
          side: BorderSide(color: Colors.white)),
      color: Colors.transparent,
      textColor: Colors.pinkAccent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Text(Like?"В избранном":"В избранное",
              style: TextStyle(
                  color: Colors.pinkAccent,
                  fontSize: 18,
                  fontFamily: "MPLUS",
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, ),
              child: icon(),
            ),
          ],
        ),
      ),
    );
  }



@override
  void initState() {
  stateLike();
  stateTrash();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Save = ObjectTrash.checkTrash(elementItem.id);
    setState(() {
    });
    return Scaffold(
     backgroundColor:  Color.fromRGBO(34, 15, 51, 1),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 12/9,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.topLeft,
                    //width: double.infinity,
                   child: Stack(
                     children: <Widget>[
                       AspectRatio(
                         aspectRatio: 2/1,
                         child: Container(
                           width: MediaQuery.of(context).size.width,
                           child: Stack(
                             children: <Widget>[
                               Container(
                                   width: MediaQuery.of(context).size.width,
                                   child: Image.network(elementItem.picture, fit: BoxFit.cover,)),
                             ],
                           ),
                         ),
                       ),
                       AspectRatio(
                         aspectRatio: 2/1,
                         child: Container(
                           width: MediaQuery.of(context).size.width,
                           child: BackdropFilter(
                             filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                             child: Container(
                               color: Colors.black.withOpacity(0),
                             ),
                           ),
                         ),
                       ),
                       Align(
                         alignment: Alignment.bottomCenter,
                         child: Container(
                           width: MediaQuery.of(context).size.width*0.450,
                           child: AspectRatio(
                             aspectRatio: 9/12,
                             child: Hero(
                               tag: elementItem.id,
                               child: Container(
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.all(Radius.circular(15)),
                                   boxShadow: [
                                     BoxShadow(
                                       color: Colors.black45,
                                       blurRadius: 4.0, // soften the shadow
                                       spreadRadius: 1.0, //extend the shadow
                                       offset: Offset(
                                         -1.0, // Move to right 10  horizontally
                                         1.0, // Move to bottom 10 Vertically
                                       ),
                                     )
                                   ],
                                 ),
                                 child:AspectRatio(
                                   aspectRatio: 9/12,
                                   child: ClipRRect(
                                     borderRadius: BorderRadius.circular(15),
                                     child: Container(
                                       child: Image.network(
                                         elementItem.picture,
                                       ),
                                     ),
                                   ),
                                 ) ,
                               ),
                             ),
                           ),
                         ),
                       ),

                       Align(
                         alignment: Alignment.topLeft,
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: IconButton(
                             color: Colors.white,
                             iconSize: 28,
                             icon: Icon(Icons.arrow_back),
                             onPressed: () {
                               Navigator.pop(context, '/MyOrders');
                             },
                           ),
                         ),
                       )
                     ],
                   ),
                  ),
                ),

              ],
            ),
           SizedBox(height: 20,),
            Container(
              color:  Color.fromRGBO(34, 15, 51, 1),
              child: Column(

                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(elementItem.head, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),),
                      Padding(
                        padding: const EdgeInsets.only(top :8.0),
                        child: Prise(elementItem),
                      ),
                    ],
                  ),
                  SizedBox(height: 40,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[

                      SaveButton(),
                      LikeButton(),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: 0, horizontal: MediaQuery.of(context).size.width*0.10),
                    child: Divider(color: Colors.white,

                    ),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width*0.85,
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            children: <Widget>[
                              Text("Описание",style: TextStyle(fontSize: 20, color: Colors.white),),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Icon(Icons.check, color: Colors.white,),
                              )
                            ],
                          ),
                        ),
                        Text("Уход за ногтями – обязательное мероприятие по сохранению красоты и здоровья рук. Выступая "
                            "в роли индикатора общего состояния, ногти, подвергаясь влиянию агрессивных внешних факторов, "
                            "ломаются и трескаются. Для их поддержания существуют мероприятия по укреплению.\n\nИспользование "
                            "геля безопасно, он не изменяет природную толщину ногтя, создавая поверх защитный слой. В отличие от "
                            "наращивания акрилом или тканевой системой с помощью файбергласса, сама процедура выполняется быстрее и"
                            " проще.", style: TextStyle(fontSize: 16, color: Colors.white),),

                        Padding(
                          padding: const EdgeInsets.only(top: 18.0, bottom: 8),
                          child: Divider(color: Colors.white, height: 2,),
                        ),
                         Padding(
                           padding: const EdgeInsets.only(bottom: 12.0),
                           child: Row(
                            children: <Widget>[
                              Text("Как проходит процедура",style: TextStyle(fontSize: 20, color: Colors.white),),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Icon(Icons.check, color: Colors.white,),
                              )
                            ],
                        ),
                         ),
                        Text("Мастер наносит кистью гелевый слой, не касаясь околоногтевых валиков. Полимеризирует гель под действием УФ-лампы, наносит еще один слой.", style: TextStyle(fontSize: 16, color: Colors.white),),
                      ],
                    ),
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}


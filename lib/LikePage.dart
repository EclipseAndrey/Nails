import 'package:flutter/material.dart';
import 'package:flutterapp32/home.dart';
import 'package:flutterapp32/main.dart';
import 'Objects.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class LikePage extends StatefulWidget {
  @override
  _LikePageState createState() => _LikePageState();
}

class _LikePageState extends State<LikePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/images/backround.png',
              fit: BoxFit.fill,
            ),
          ),
          SingleChildScrollView(child: _Content()),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20,
              ),
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

  Widget _Content() {
    List<dynamic> spisok = ObjectLikes.getLikes();
    var size = MediaQuery.of(context).size;
    if (!(ObjectLikes.getLikes().length > 0)) {
      return Container();
    } else {

      List<ElementItem> elemts = [];
      for(int i = 0; i < ObjectLikes.getLikes().length; i++){
        elemts.add(elementInfo(int.parse(ObjectLikes.getLikes()[i])~/100-1, int.parse(ObjectLikes.getLikes()[i])%100-1));
      }


      return Center(
        child: Column(
          children: List.generate(ObjectLikes.getLikes().length, (index) {
            return ClipRRect(

              child: Card(
                color: Colors.transparent,
                  shape: RoundedRectangleBorder(

                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(width: 1, color:Colors.white ),
                  ),

//                color: Color(0xff8A1FFF),
                  child: Container(
                    color: Colors.transparent,
                width: size.width * 0.95,
                child: Stack(
                  children: [
                    Container(
                      width: size.width*0.85,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image(
                                    image: images[int.parse(spisok[index])~/100-1][int.parse(spisok[index])%100-1].image,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 4,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 14.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(elemts[index].head, style: TextStyle(fontSize: 18, color: Colors.white),),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 12.0),
                                      child: Text(elemts[index].tx, style: TextStyle(fontSize: 14, color: Colors.white60),),
                                    ),

                                  ],
                                ),
                              ),),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 14.0),
                        child: Stack(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom:10.0),
                              child: LikeButton(elementInfo(int.parse(spisok[index])~/100-1,int.parse(spisok[index])%100-1)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding:  EdgeInsets.only(top: 68.0),
                        child: TrashButton(elementInfo(int.parse(spisok[index])~/100-1,int.parse(spisok[index])%100-1)),
                      ),
                    )
                  ],
                ),
              ),
              ),
            );
          }),
        ),
      );
    }
  }
}

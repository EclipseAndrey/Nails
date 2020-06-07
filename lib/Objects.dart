import 'dart:convert';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'home.dart';
import 'package:http/http.dart' as http;

class DataTresh {
  List<ElementItem> items;

  DataTresh(List<ElementItem> items) {
    this.items = items;
  }
}

class Order {
  List<int> ids;
  String adress = "";
  String num = "";
  String name = "";
  String Promo = "";
  String comment = "Не введен.";
  String date = "";
  String time = "";

  Order();

  String getAdress() {
    return this.adress;
  }

  String getNum() {
    return this.num;
  }

  String getName() {
    return this.name;
  }

  String getPromo() {
    return this.Promo;
  }

  String getComment() {
    return this.comment;
  }

  void initId() {
    ids = [1];

    ids.clear();
  }

  void addId(int id) {
    ids.add(id);
  }

  void addAdress(String adress) {
    this.adress = adress;
  }

  void addNum(String num) {
    this.num = num;
  }

  void addName(String name) {
    this.name = name;
  }

  void addPromo(String promo) {
    this.Promo = promo;
  }

  void addComment(String comment) {
    this.comment = comment;
  }
}

class itemOrder {
  List<int> ids;
  String adress = "";
  String num = "";
  String name = "";
  String Promo = "";
  String comment = "Не введен.";
  String date = "";
  String time = "";
  int Status = 0;

  itemOrder();
}

List<String> UrlImage_c = [
  'http://eclipsedevelop.ru/images/c-1.png',
  'http://eclipsedevelop.ru/images/c-2.png',
  'http://eclipsedevelop.ru/images/c-3.png',
  'http://eclipsedevelop.ru/images/c-4.png',
  'http://eclipsedevelop.ru/images/c-5.png',
  'http://eclipsedevelop.ru/images/c-6.png',
  'http://eclipsedevelop.ru/images/c-7.png',
];

List<String> Header = [
  "Комплексы",
  "Маникюр",
  "Покрытия",
  "Педикюр",
  "Дизайн",
  "СПА Уход",
  "Брови",
];

class Like {
  String token;
  var response;
  int count;

  Like.r() {}

  Like(String token) {
    this.token = token;
  }

  List<dynamic> likeIds = [];

  Future<bool> Likes() async {
    Future<bool> res() async {
      var a = await http
          .get('http://eclipsedevelop.ru/api.php/cbgetlikes?token=$token');

      if (a.statusCode == 200) {
        this.response = jsonDecode(a.body);
        print('response ' + this.response.toString());

        return true;
      } else {
        return false;
      }
    }

    print('http://eclipsedevelop.ru/api.php/cbgetlikes?token=$token');

    //

    bool a = await res();

    if (a) {
      print("Like ok" + this.response['response']);
      if (this.response['response'] == '200') {
        print("LIKE 200");
        count = response['count'];
        count > 0 ? likeIds = response['likes'] : likeIds = [];
        return true;
      } else if (this.response == '202') {
        print("LIKE 202");

        return false;
      } else if (this.response == '203') {
        print("LIKE 203");

        return false;
      } else {
        print("LIKE 0");

        return false;
      }
    } else
      return false;
  }

  List<dynamic> getLikes() {
    return likeIds;
  }

  Future<bool> addLikes(int id) async {
    Future<bool> res() async {
      var a = await http.get(
          'http://eclipsedevelop.ru/api.php/cbaddlikes?token=$token&id=$id');

      if (a.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    }

    print('http://eclipsedevelop.ru/api.php/cbaddlikes?token=$token&id=$id');
    if (await res()) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteLikes(int id) async {
    Future<bool> res() async {
      var a = await http.get(
          'http://eclipsedevelop.ru/api.php/cbdeletelikes?token=$token&id=$id');

      if (a.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    }

    print('http://eclipsedevelop.ru/api.php/cbdeletelikes?token=$token&id=$id');
    if (await res()) {
      return true;
    } else {
      return false;
    }
  }

  bool checkLike(int id) {
    bool point = false;
    print("+++++++++++++++++++" + likeIds.length.toString());
    for (int i = 0; i < likeIds.length; i++) {
      print(
          "++++++++++++++++++ " + likeIds[i].toString() + " " + id.toString());
      if (int.parse(likeIds[i]) == id) {
        point = true;
      }
    }
    return point;
  }
}

class LikeButton extends StatefulWidget {
  ElementItem item;

  LikeButton(this.item);

  @override
  _LikeButtonState createState() => _LikeButtonState(item);
}

class _LikeButtonState extends State<LikeButton> {
  ElementItem item;

  _LikeButtonState(this.item);

  bool active;

  @override
  void initState() {
    super.initState();
  }

  Widget Button(bool active){
    if(active){
      return Container(
      height: 710,
      width: 710,
      child: FlareActor(

        'assets/animations/Like4.flr',
        alignment: Alignment.center,
        fit: BoxFit.contain,
        animation: "Like",
      ),
    );
    }else{
      return Container(
        width: 710,
        height: 710,
        child: FlareActor(

          'assets/animations/Like4.flr',
          alignment: Alignment.center,
          color: Colors.white,

          fit: BoxFit.contain,
          animation: "Unlike",

        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    active = ObjectLikes.checkLike(item.id);

//          return Icon(Icons.add);
      return Container(
        height: 61,
        width: 61,
        child: GestureDetector(
          onTap: () async {
            if (!ObjectLikes.checkLike(item.id)) {
              await ObjectLikes.addLikes(item.id);
              await ObjectLikes.Likes();
            } else {
              await ObjectLikes.deleteLikes(item.id);
              await ObjectLikes.Likes();
            }
            active = ObjectLikes.checkLike(item.id);

            setState(() {});
          },
          child: Button(active)
        ),
      );

  }
}





class TrashList {
  String token;
  var response;
  int count;

  TrashList.r() {}

  TrashList(String token) {
    this.token = token;
  }

  List<dynamic> trashIds = [];

  Future<bool> TrashListUp() async {
    Future<bool> res() async {
      var a = await http
          .get('http://eclipsedevelop.ru/api.php/cbgettrash?token=$token');

      if (a.statusCode == 200) {
        this.response = jsonDecode(a.body);
        print('response ' + this.response.toString());

        return true;
      } else {
        return false;
      }
    }

    print('http://eclipsedevelop.ru/api.php/cbgettrash?token=$token');

    //

    bool a = await res();

    if (a) {
      print("Trash ok" + this.response['response']);
      if (this.response['response'] == '200') {
        print("TRASH 200");
        count = response['count'];
        count > 0 ? trashIds = response['trash'] : trashIds = [];
        return true;
      } else if (this.response == '202') {
        print("TRASH 202");

        return false;
      } else if (this.response == '203') {
        print("TRASH 203");

        return false;
      } else {
        print("TRASH 0");

        return false;
      }
    } else
      return false;
  }

  List<dynamic> getTrash() {
    return trashIds;
  }

  Future<bool> addTrash(int id) async {
    Future<bool> res() async {
      var a = await http.get(
          'http://eclipsedevelop.ru/api.php/cbaddtrash?token=$token&id=$id');

      if (a.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    }

    print('http://eclipsedevelop.ru/api.php/cbaddtrash?token=$token&id=$id');
    if (await res()) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteTrash(int id) async {
    Future<bool> res() async {
      var a = await http.get(
          'http://eclipsedevelop.ru/api.php/cbdeletetrash?token=$token&id=$id');

      if (a.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    }

    print('http://eclipsedevelop.ru/api.php/cbdeletetrash?token=$token&id=$id');
    if (await res()) {
      return true;
    } else {
      return false;
    }
  }

  bool checkTrash(int id) {
    bool point = false;
    print("+++++++++++++++++++" + trashIds.length.toString());
    for (int i = 0; i < trashIds.length; i++) {
      print(
          "++++++++++++++++++ " + trashIds[i].toString() + " " + id.toString());
      if (int.parse(trashIds[i]) == id) {
        point = true;
      }
    }
    return point;
  }
}





class TrashButton extends StatefulWidget {

  ElementItem item;

  TrashButton(this.item);

  @override
  _TrashButtonState createState() => _TrashButtonState(item);
}

class _TrashButtonState extends State<TrashButton> {
  ElementItem item;

  _TrashButtonState(this.item);
  bool active;
  @override
  void initState() {
    super.initState();
  }


  Widget Button(bool active){
    if(active){
      return Container(
        height: 710,
        width: 710,
        child: FlareActor(
          'assets/animations/intrash2.flr',
          alignment: Alignment.center,
          fit: BoxFit.contain,
          animation: "onbasket",
        ),
      );
    }else{
      return Container(
        width: 710,
        height: 710,
        child: FlareActor(
          'assets/animations/intrash2.flr',
          alignment: Alignment.center,
          fit: BoxFit.contain,
          animation: "offbasket",

        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    active = ObjectTrash.checkTrash(item.id);


//          return Icon(Icons.add);
    return Container(
      height: 31,
      width: 61,
      child: GestureDetector(
          onTap: () async {
            if (!ObjectTrash.checkTrash(item.id)) {
              await ObjectTrash.addTrash(item.id);
              await ObjectTrash.TrashListUp();
            } else {
              await ObjectTrash.deleteTrash(item.id);
              await ObjectTrash.TrashListUp();
            }
            active = ObjectTrash.checkTrash(item.id);

            setState(() {});
          },
          child: Button(active)
      ),
    );

  }
}





class BottomSheetContent extends StatelessWidget {
  String tel;
  double sizeText;
  BottomSheetContent(String tel, double sizeText){
    this.sizeText = sizeText;
    this.tel =tel;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.95,
      child: Column(
        children: [
          Container(
            height: 70,
            child: Row(
              children: [
                GestureDetector(
                  onTap: (){

                  },
                  child: Text("Отмена", style:  TextStyle(
                      color: Colors.blueAccent,
                      fontSize: sizeText,
                      fontFamily: "MPLUS",
                      decoration: TextDecoration.underline,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w300),),
                ),
              ],
            ),
          ),
          const Divider(thickness: 1),
          Expanded(
            child: ListView.builder(
              itemCount: 21,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("txt"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }




}

class BottomMakeOrder extends StatefulWidget {
  String tel;
  double sizeText;
  BottomMakeOrder(this.tel, this.sizeText);

  @override
  _BottomMakeOrderState createState() => _BottomMakeOrderState(tel,sizeText);
}

class _BottomMakeOrderState extends State<BottomMakeOrder> {
  String tel;
  double sizeText;
  _BottomMakeOrderState(this.tel, this.sizeText);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16)
        ),
      ),
      height: MediaQuery.of(context).size.height*0.95,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
             Container(

               height: 70,
               child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: GestureDetector(
                      onTap: (){

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
                  Divider(thickness: 1),

                  Container(
                    height: 700,
                  ),
                ],
            ),
             ),
          ],
        ),
      ),
    );
  }
}




















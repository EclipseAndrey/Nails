import 'dart:convert';
import 'dart:developer';
import 'package:ansicolor/ansicolor.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'home.dart';
import 'package:http/http.dart' as http;
import 'package:print_color/print_color.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';



@immutable
class Message {
  final String title ;
  final String body;
  const Message({
    @required this.title,
    @required this.body,
});
}





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
    for (int i = 0; i < likeIds.length; i++) {

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

    for (int i = 0; i < trashIds.length; i++) {


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
      print("Добавлен " + item.head);
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
      print("Удален "+ item.head);

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







class adress{
  String
  street,
      city,
      house,
      corpus,
      stroenie,
      kv;
  adress({this.city,this.street,this.house, this.corpus, this.stroenie, this.kv});

  factory adress.fromJson(Map<String,dynamic> json){
    return adress(
        city: json['city'] as String,
        street: json['street'] as String,
        house: json['house'] as String,
        stroenie: json['stroenie'] as String,
        corpus: json['corpus'] as String,
        kv: json['kv'] as String
    );

  }

}

class AdressList{
  List<dynamic> adreses = [];

  var response;
  int count;
  String token;
  AdressList.r();
  AdressList(this.token);

  Future<bool> AdressListUp() async {
    Future<bool> res() async {
      var a = await http
          .get('http://eclipsedevelop.ru/api.php/cbgetaddresses?token=$token');

      if (a.statusCode == 200) {
        this.response = jsonDecode(a.body);
        print('response ' + this.response.toString());

        return true;
      } else {
        return false;
      }
    }

    print('http://eclipsedevelop.ru/api.php/cbgetaddresses?token=$token');

    //

    bool a = await res();

    if (a) {
      print("Address ok" + this.response['response']);
      if (this.response['response'] == '200') {
        print("ADDRESS 200");
        count = response['count'];
        count > 0 ? adreses = response['addresses'].map((i) => adress.fromJson(i)).toList() : adreses = [];
        return true;
      } else if (this.response == '202') {
        print("ADDRESSES 202");

        return false;
      } else if (this.response == '203') {
        print("ADRESSES 203");

        return false;
      } else {
        print("ADRESSES 0");

        return false;
      }
    } else
      return false;
  }

  List<dynamic> getAddresses() {
    return adreses;
  }

  Future<bool> addAddress(adress Address) async {
    if (Address.stroenie == ""){
      Address.stroenie = "null";
    }
    if (Address.corpus == ""){
      Address.corpus = "null";
    }
    if (Address.kv == ""){
      Address.kv = "null";
    }
    Future<bool> res() async {
      var a = await http.get(
          'http://eclipsedevelop.ru/api.php/cbaddaddresses?token=$token&city=${Address.city}&street=${Address.street}&house=${Address.house}&stroenie=${Address.stroenie}&corpus=${Address.corpus}&kv=${Address.kv}');

      if (a.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    }

    print('http://eclipsedevelop.ru/api.php/cbaddaddresses?token=$token&city=${Address.city}&street=${Address.street}&house=${Address.house}&stroenie=${Address.stroenie}&corpus=${Address.corpus}&kv=${Address.kv}');
    if (await res()) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteAddress(adress Address) async {
    Future<bool> res() async {
      var a = await http.get(
          'http://eclipsedevelop.ru/api.php/cbdeleteaddresses?token=$token&city=${Address.city}&street=${Address.street}&house=${Address.house}&stroenie=${Address.stroenie}&corpus=${Address.corpus}&kv=${Address.kv}');

      if (a.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    }

    print('http://eclipsedevelop.ru/api.php/cbdeleteaddresses?token=$token&city=${Address.city}&street=${Address.street}&house=${Address.house}&stroenie=${Address.stroenie}&corpus=${Address.corpus}&kv=${Address.kv}');
    if (await res()) {
      return true;
    } else {
      return false;
    }
  }
}



Future<String> MakeOrderButton(String address, String date, String time, String num, String promo, String comment )async{

  String ids(){
    String ids = "";
    for(int i = 0; i < ObjectTrash.getTrash().length; i ++){
      ids+= ","+ObjectTrash.getTrash()[i].toString();
    }
    return ids;
  }
  var a;
  print('http://eclipsedevelop.ru/api.php/cbmakeorder?token=$token&adress=$address&date=$date&time=$time&num=$num&promo=$promo&comment=$comment&ids=${ids()}');
  Future<bool> make() async {
    a = await http.get(
        'http://eclipsedevelop.ru/api.php/cbmakeorder?token=$token&adress=$address&date=$date&time=$time&num=$num&promo=$promo&comment=$comment&ids=${ids()}');


    if (await a.statusCode == 200) {
      ObjectAddress.AdressListUp();
      return true;
    } else {
      return false;
    }
  }

  if(await make()){
    var response = jsonDecode(a.body);
    if(response['response'] == "14"){
      return "Вы записаны";
    }
    if(response['response'] == "56"){
      return "Укажите, пожалуйста, адрес";
    }
    if(response['response'] == "55"){
      return "Укажите, пожалуйста, время";
    }
    if(response['response'] == "54"){
      return "Укажите, пожалуйста, дату";
    }
    if(response['response'] == "58"){
      return "Хм, корзина пуста";
    }
    else {
      return "Какая-то непонятная ошибка, попробуйте еще.";
    }



  }else{
    return "Что-то пошло не так, попробуйте позже :)";
  }



}




class User{
  String
  num,
      name,
      bonus;
  User({this.num,this.name,this.bonus});

  factory User.fromJson(Map<String,dynamic> json){
    return User(
        num: json['num'] .toString(),
        name: json['name'].toString(),
        bonus: json['bonus'].toString()
    );

  }
}


class UsersList{
  List<dynamic> users = [];
  var response;
  int count;
  String token;
  UsersList.r();
  UsersList(this.token);

  Future<bool> Up() async {
    Future<bool> res() async {
      var a = await http
          .get('http://eclipsedevelop.ru/api.php/cbgetusers?token=$token');

      if (a.statusCode == 200) {
        this.response = jsonDecode(a.body);
        print('response ' + this.response.toString());

        return true;
      } else {
        return false;
      }
    }

    print('http://eclipsedevelop.ru/api.php/cbgetusers?token=$token');

    //

    bool a = await res();

    if (a) {
      print("Users ok" + this.response['response']);
      if (this.response['response'] == '39') {
        print("USERS 39");
        count = response['text']['count'];
        print("Count users "+count.toString());
        count > 0 ? users = response['text']['users'].map((i) => User.fromJson(i)).toList() : users = [];
        return true;
      } else if (this.response == '202') {
        print("USRES 202");

        return false;
      } else if (this.response == '203') {
        print("USERS 203");

        return false;
      } else {
        print("USERS 0");

        return false;
      }
    } else
      return false;
  }

  List<dynamic> getUsers() {
    return users;
  }

}

class ItemOrder{
  String
  name,
  num,
  promo,
  prise,
  comment,
  address,
  date,
  time;
  List<dynamic> OrderIds;



  ItemOrder({this.num,this.name,this.comment,this.promo,this.address,this.time,this.date,this.prise,this.OrderIds});

  factory ItemOrder.fromJson(Map<String,dynamic> json){
    return ItemOrder(
        num: json['num'] .toString(),
        name: json['name'].toString(),
        promo: json['promo'].toString(),
        prise: json['price'].toString(),
        comment: json['comment'].toString(),
        address: json['adress'].toString(),
        date: json['date'].toString(),
        time: json['time'].toString(),
      OrderIds: json['ids'] as List<dynamic>

    );

  }
}

class OrdersListForAdmin{
  List<dynamic> users = [];

  var response;
  int count;
  String token;
  String status;
  OrdersListForAdmin.r();
  OrdersListForAdmin(this.token, this.status);

  Future<bool> Up() async {
    Future<bool> res() async {
      var a = await http
          .get('http://eclipsedevelop.ru/api.php/cbgetorders?token=$token&status=$status');

      if (a.statusCode == 200) {
        this.response = jsonDecode(a.body);
        print('response ' + this.response.toString());

        return true;
      } else {
        return false;
      }
    }

    print('http://eclipsedevelop.ru/api.php/cbgetorders?token=$token&status=$status');

    //

    bool a = await res();

    if (a) {
      print("getorders ok" + this.response['response']);
      if (this.response['response'] == '200') {
        print("getorders 200");
        count = response['count'];
        print("Count users "+count.toString());
        count > 0 ? users = response['orders'].map((i) => ItemOrder.fromJson(i)).toList() : users = [];
        return true;
      } else if (this.response == '202') {
        print("getorders 202");

        return false;
      } else if (this.response == '203') {
        print("getorders 203");

        return false;
      } else {
        print("getorders 0");

        return false;
      }
    } else
      return false;
  }

  List<dynamic> getOrders() {
    return users;
  }

}


class AwaitVIP{
  String
  name,
  num;

  AwaitVIP({this.num,this.name});

  factory AwaitVIP.fromJson(Map<String,dynamic> json){
    return AwaitVIP(
        num: json['num'] .toString(),
        name: json['name'].toString(),
    );

  }
}

class CheckerStatusVIP{
  String status,
  name,
  error = "0";
  CheckerStatusVIP(this.status,this.name);
  CheckerStatusVIP.error(this.error);
}

class VIPList{
  List<dynamic> usersAwait = [];
  List<dynamic> usersOK = [];


  var response;
  int count;
  String token;
  VIPList.r();
  VIPList(this.token);

  Future<bool> UpAwait() async {
    Future<bool> res() async {
      var a = await http
          .get('http://eclipsedevelop.ru/api.php/cbgetrequestusers?token=$token');
      if (a.statusCode == 200) {
        this.response = jsonDecode(a.body);
        print('response ' + this.response.toString());

        return true;
      } else {
        return false;
      }
    }

    print('http://eclipsedevelop.ru/api.php/cbgetrequestusers?token=$token&');

    //

    bool a = await res();

    if (a) {
      print("awaitVIP ok" + this.response['response']);
      if (this.response['response'] == '200') {
        print("awaitVIP 200");
        count = response['text']['count'];
        print("Count users "+count.toString());
        count > 0 ? usersAwait = response['text']['users'].map((i) => AwaitVIP.fromJson(i)).toList() : usersAwait = [];
        return true;
      } else if (this.response == '202') {
        print("awaitVIP 202");

        return false;
      } else if (this.response == '203') {
        print("awaitVIP 203");

        return false;
      } else {
        print("awaitVIP 0");

        return false;
      }
    } else
      return false;
  }

  Future<bool> UpOk() async {
    Future<bool> res() async {
      var a = await http
          .get('http://eclipsedevelop.ru/api.php/cbgetvipusers?token=$token');
      if (a.statusCode == 200) {
        this.response = jsonDecode(a.body);
        print('response ' + this.response.toString());

        return true;
      } else {
        return false;
      }
    }

    print('http://eclipsedevelop.ru/api.php/cbgetvipusers?token=$token&');

    //

    bool a = await res();

    if (a) {
      print("okVIP ok" + this.response['response']);
      if (this.response['response'] == '200') {
        print("okVIP 200");
        count = response['text']['count'];
        print("Count users "+count.toString());
        count > 0 ? usersOK = response['text']['users'].map((i) => AwaitVIP.fromJson(i)).toList() : usersOK = [];
        return true;
      } else if (this.response == '202') {
        print("okVIP 202");

        return false;
      } else if (this.response == '203') {
        print("okVIP 203");

        return false;
      } else {
        print("okVIP 0");

        return false;
      }
    } else
      return false;
  }

  List<dynamic> getAwaitVIP() {
    return usersAwait;
  }
  List<dynamic> getOkVIP() {
    return usersOK;
  }
  Future<bool> setVipStatus(String num, String status)async{
    var a = await http.get('http://eclipsedevelop.ru/api.php/cbsetvipstatus?token=$token&num=$num&status=$status');

    if(await a.statusCode == 200){
    var response = jsonDecode(a.body);
    if(response['response'] == "200"){
      return true;
    }else{
      return false;
    }

    }else{return false;}

  }
  Future<CheckerStatusVIP> checkVipStatus(String num)async{
    print('http://eclipsedevelop.ru/api.php/cbcheckvipstasus?token=$token&num=$num');
    var a = await http.get('http://eclipsedevelop.ru/api.php/cbcheckvipstasus?token=$token&num=$num');
    if(await a.statusCode == 200){
      CheckerStatusVIP step;
      var response = jsonDecode(a.body);
      if(response['response'] == "200"){
        step = CheckerStatusVIP(response['status'], response['name']);
        return step;
      }else{
        return CheckerStatusVIP.error("1");
      }
    }else{return CheckerStatusVIP.error("2");}

  }
}


class MessageE{
  String
  mess;
  var messtime;
  MessageE({this.mess,this.messtime});

  factory MessageE.fromJson(Map<String,dynamic> json){
    return MessageE(
      mess: json['mess'] .toString(),
      messtime: DateFormat("yyyy-MM-dd HH:mm:ss", "en_US").parse(json['time']),
    );

  }
}
class DialogMessage{
  String
  mess,
  name,
  num;
  var messtime;
  DialogMessage({this.mess,this.messtime, this.name, this.num});

  factory DialogMessage.fromJson(Map<String,dynamic> json){
    return DialogMessage(
      mess: json['mess'] .toString(),
      name: json['name'] .toString(),
      num: json['num'] .toString(),
      messtime: DateFormat("yyyy-MM-dd HH:mm:ss", "en_US").parse(json['time']),

    );

  }
}


class MessagePanel {
  String token;
  String name ="";

  List<dynamic> messUsers= [];
  List<dynamic> messAdmin = [];
  List<dynamic> dialogs = [];


  MessagePanel.r();

  MessagePanel(this.token);

  Future<bool> sendMessUser(String mess) async {
    var a = await http.get(
        'http://eclipsedevelop.ru/api.php/cb_sendmess?token=$token&mess=$mess');
    if (await a.statusCode == 200) {
      var response = jsonDecode(a.body);
      if (response['response'] == "200") {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> sendMessAdmin(String mess, String num) async {
    var a = await http.get(
        'http://eclipsedevelop.ru/api.php/cb_sendmess?token=$token&mess=$mess&num=$num');
    if (await a.statusCode == 200) {
      var response = jsonDecode(a.body);
      if (response['response'] == "200") {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> upMessForUsers()async{
    var a = await http.get(
        'http://eclipsedevelop.ru/api.php/cb_usergetmess?token=$token');
    if (await a.statusCode == 200) {
      var response = jsonDecode(a.body);
      if (response['response'] == "200") {
        messUsers = response['text'].map((i) => MessageE.fromJson(i)).toList();
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
  Future<bool> upMessForAdmin(String num)async{
    var a = await http.get(
        'http://eclipsedevelop.ru/api.php/cb_admingetmess?token=$token&num=$num');
    if (await a.statusCode == 200) {
      var response = jsonDecode(a.body);
      if (response['response'] == "200") {
        messAdmin = response['text'].map((i) => MessageE.fromJson(i)).toList();
        name = response['name'].toString();
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
  Future<bool> upDialogs()async{
    print('Up dialogs');
    var a = await http.get(
        'http://eclipsedevelop.ru/api.php/cb_getdialogs?token=$token');
    if (await a.statusCode == 200) {
      print('Up dialogs ok');

      var response = jsonDecode(a.body);
      if (response['response'] == "200") {
        print( response['text'].toString());

        dialogs = response['text'].map((i) => DialogMessage.fromJson(i)).toList();
        return true;
      } else {
        print('Up dialogs error');

        return false;
      }
    } else {
      return false;
    }
  }
  List<dynamic> getMessForUsers(){
    return messUsers;
  }
  List<dynamic> getMessForAdmin(){
    return messAdmin;
  }
  List<dynamic> getDialogs(){
    return dialogs;
  }
  String getNameDialog(){
    return name;
  }





}


















































































































import 'dart:convert';

//import 'package:firebase_messaging/firebase_messaging.dart';
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

List<ElementItem> items = [];
List<int> items_counter;

class Home extends StatefulWidget {
  @override
  _Home createState() => new _Home();
}

String kartinka =
    'https://p16.muscdn.com/img/musically-maliva-obj/1650991040036870~c5_720x720.jpeg';

class _Home extends State<Home> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _launched;

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  //final FirebaseMessaging _messaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
//    _messaging.getToken().then((token) {
//      print(token);
//    });
  }

  @override
  Widget build(BuildContext context) {
    items = [ElementItem(0, '','', '', '', 0, 0,true,[101, 201, 30],[101, 201, 30],[101, 201, 30],[101, 201, 30])];
    items.clear();
    items_counter = [1];
    items_counter.clear();
    return new Scaffold(
  //    key: _scaffoldKey,
      body: Builder(builder: (context) => Categories(context)),
    );
  }
}

class ElementItem {
  String blurpic;
  int id;
  String picture;
  String head;
  String tx;
  int price;
  int sale;
  bool population;
  List <int> color1;
  List <int> color2;
  List <int> color3;
  List <int> color4;

  ElementItem(
      int id, String picture, String blurpic, String head, String tx, int price, int sale,bool populatoion, List <int> color1, List <int> color2,
      List <int> color3, List <int> color4) {
    this.id = id;
    this.picture = picture;
    this.blurpic = blurpic;
    this.head = head;
    this.tx = tx;
    this.price = price;
    this.sale = sale;
    this.population = populatoion;
    this.color1 = color1;
    this.color2 = color2;
    this.color3 = color3;
    this.color4 = color4;
  }
}

ElementItem elementInfo(int category, int indexx) {
  List<List<ElementItem>> info = [];

  List<ElementItem> step = [];
  List<ElementItem> step1 = [];
  List<ElementItem> step2 = [];
  List<ElementItem> step3 = [];
  List<ElementItem> step4 = [];
  List<ElementItem> step5 = [];
  List<ElementItem> step6 = [];
  //Комплексы
  step.add(ElementItem(0101, 'http://eclipsedevelop.ru/images/101.png','http://eclipsedevelop.ru/images/103blur.jpg',  'XS Комплекс', 'Необрезной экспресс-маникюр и педикюр, покрытие лаком', 1699, 0, true, [24, 24, 99],[94, 94, 184],[48, 197, 227],[7, 135, 161]));
  step.add(ElementItem(0102, 'http://eclipsedevelop.ru/images/102.png','http://eclipsedevelop.ru/images/103blur.jpg',   'S Комплекс', 'Маникюр и педикюр, покрытие лаком', 2299, 0, false, [170, 120, 236],[156, 63, 227],[185, 185, 217],[156, 63, 227]));
  step.add(ElementItem(0103, 'http://eclipsedevelop.ru/images/103.png', 'http://eclipsedevelop.ru/images/103blur.jpg',   'М Комплекс', 'Снятие, маникюр и педикюр, покрытие гель-лаком', 3299, 300, false, [238,247,248],[150,126,187],[150,126,187],[238,247,248]));
  step.add(ElementItem(0104, 'http://eclipsedevelop.ru/images/104.png','http://eclipsedevelop.ru/images/103blur.jpg',   'L Комплекс', 'Снятие, маникюр и педикюр, покрытие гель-лаком, дизайн', 4299, 0, true, [101, 201, 30],[101, 201, 30],[101, 201, 30],[101, 201, 30]));
  step.add(ElementItem(0105, 'http://eclipsedevelop.ru/images/105.png','http://eclipsedevelop.ru/images/103blur.jpg',   'XL Комплекс', 'Снятие, маникюр и педикюр, покрытие гель-лаком, дизайн, спа-уход, использование аппарата', 4999, 0, false, [101, 201, 30],[101, 201, 30],[101, 201, 30],[101, 201, 30]));
  step.add(ElementItem(0106, 'http://eclipsedevelop.ru/images/106.png','http://eclipsedevelop.ru/images/103blur.jpg',   'Мужской Комплекс', 'Классический обрезной маникюр и педикюр, полировка', 1999, 0, true, [101, 201, 30],[101, 201, 30],[101, 201, 30],[101, 201, 30]));
  step.add(ElementItem(0107, 'http://eclipsedevelop.ru/images/107.png','http://eclipsedevelop.ru/images/103blur.jpg',   'Детский Комплекс', 'Детский маникюр и педикюр', 999, 0, false, [101, 201, 30],[101, 201, 30],[101, 201, 30],[101, 201, 30]));
  info.add(step);
  //Маникюр
  step1.add(ElementItem(201, 'http://eclipsedevelop.ru/images/201.png','http://eclipsedevelop.ru/images/103blur.jpg', 'Маникюр «ColorBird»', 'Классический маникюр', 600, 101, true, [101, 201, 30],[101, 201, 30],[101, 201, 30],[101, 201, 30]));
  step1.add(ElementItem(202, 'http://eclipsedevelop.ru/images/202.png','http://eclipsedevelop.ru/images/103blur.jpg', 'Маникюр «Combo»', 'Комбинированный маникюр', 700, 0, false, [101, 201, 30],[101, 201, 30],[101, 201, 30],[101, 201, 30]));
  step1.add(ElementItem(203, 'http://eclipsedevelop.ru/images/203.png','http://eclipsedevelop.ru/images/103blur.jpg', 'Бразильский маникюр', 'SPA-маникюр с применением перчаток', 700, 0, true, [101, 201, 30],[101, 201, 30],[101, 201, 30],[101, 201, 30]));
  step1.add(ElementItem(204, 'http://eclipsedevelop.ru/images/204.png','http://eclipsedevelop.ru/images/103blur.jpg', 'Мужской маникюр', 'Обработка кутикулы, полировка ногтевой пластины', 900, 0, true, [101, 201, 30],[101, 201, 30],[101, 201, 30],[101, 201, 30]));
  step1.add(ElementItem(205, 'http://eclipsedevelop.ru/images/205.png','http://eclipsedevelop.ru/images/103blur.jpg', 'Детский маникюр', 'Детский маникюр, удаление заусенцев', 400, 0, false,[101, 201, 30],[101, 201, 30],[101, 201, 30],[101, 201, 30]));
  info.add(step1);
//Покрытия
  step2.add(ElementItem(301, 'http://eclipsedevelop.ru/images/301.png','http://eclipsedevelop.ru/images/103blur.jpg', 'Лак', 'OPI, ESSE', 390, 50, false, [101, 201, 30],[101, 201, 30],[101, 201, 30],[101, 201, 30]));
  step2.add(ElementItem(302, 'http://eclipsedevelop.ru/images/302.png','http://eclipsedevelop.ru/images/103blur.jpg', 'Гель-Лак', 'CND, OPI GelColor, KOD', 950, 0, false, [101, 201, 30],[101, 201, 30],[101, 201, 30],[101, 201, 30]));
  step2.add(ElementItem(303, 'http://eclipsedevelop.ru/images/303.png','http://eclipsedevelop.ru/images/103blur.jpg', 'Укрепление гелем', 'Укрепляющее покрытие', 600, 200, false, [101, 201, 30],[101, 201, 30],[101, 201, 30],[101, 201, 30]));
  step2.add(ElementItem(304, 'http://eclipsedevelop.ru/images/304.png','http://eclipsedevelop.ru/images/103blur.jpg', 'IBX System', 'Укрепление пластины', 700, 0,true, [101, 201, 30],[101, 201, 30],[101, 201, 30],[101, 201, 30]));
  step2.add(ElementItem(305, 'http://eclipsedevelop.ru/images/305.png','http://eclipsedevelop.ru/images/103blur.jpg', 'Снятие геля ', '', 350, 0, false, [101, 201, 30],[101, 201, 30],[101, 201, 30],[101, 201, 30]));
  step2.add(ElementItem(306, 'http://eclipsedevelop.ru/images/306.png','http://eclipsedevelop.ru/images/103blur.jpg', 'Снятие покрытия', 'Снятие долговременного покрытия', 250, 0, false, [101, 201, 30],[101, 201, 30],[101, 201, 30],[101, 201, 30]));
  info.add(step2);
//Педикюр
  step3.add(ElementItem(401, 'http://eclipsedevelop.ru/images/401.png','http://eclipsedevelop.ru/images/103blur.jpg', 'Педикюр «ColorBird»', 'Классический педикюр', 990, 0, false, [101, 201, 30],[101, 201, 30],[101, 201, 30],[101, 201, 30]));
  step3.add(ElementItem(402, 'http://eclipsedevelop.ru/images/402.png','http://eclipsedevelop.ru/images/103blur.jpg', 'Педикюр «Combo»', 'Комбинированный педикюр', 1100, 0, false, [101, 201, 30],[101, 201, 30],[101, 201, 30],[101, 201, 30]));
  step3.add(ElementItem(403, 'http://eclipsedevelop.ru/images/403.png','http://eclipsedevelop.ru/images/103blur.jpg', 'Бразильский педикюр', 'СПА-педикюр с применением специальных носочков', 1200, 0, false, [101, 201, 30],[101, 201, 30],[101, 201, 30],[101, 201, 30]));
  step3.add(ElementItem(404, 'http://eclipsedevelop.ru/images/404.png','http://eclipsedevelop.ru/images/103blur.jpg', 'Сложный педикюр', 'Классический педикюр, удаление натоптышей, лечение трещин', 1300, 0, false, [101, 201, 30],[101, 201, 30],[101, 201, 30],[101, 201, 30]));
  step3.add(ElementItem(405, 'http://eclipsedevelop.ru/images/405.png','http://eclipsedevelop.ru/images/103blur.jpg', 'Мужской педикюр', 'Мужской педикюр, обработка кутикул и стоп, удаление натоптышей', 1100, 0, true, [101, 201, 30],[101, 201, 30],[101, 201, 30],[101, 201, 30]));
  step3.add(ElementItem(406, 'http://eclipsedevelop.ru/images/406.png','http://eclipsedevelop.ru/images/103blur.jpg', 'Детский педикюр', 'Детский педикюр, удаление заусенцев', 700, 0, false, [101, 201, 30],[101, 201, 30],[101, 201, 30],[101, 201, 30]));
  info.add(step3);
//Дизайн
  step4.add(ElementItem(501, 'http://eclipsedevelop.ru/images/501.png','http://eclipsedevelop.ru/images/103blur.jpg', 'Авторский дизайн', 'Стоимость дизайна 10 ногтевых пластин', 500, 0, false, [101, 201, 30],[101, 201, 30],[101, 201, 30],[101, 201, 30]));
  step4.add(ElementItem(502, 'http://eclipsedevelop.ru/images/502.png','http://eclipsedevelop.ru/images/103blur.jpg', 'Френч/Лунный', 'Стоимость дизайна 10 ногтевых пластин + долговременное покрытие', 1200, 0, true, [101, 201, 30],[101, 201, 30],[101, 201, 30],[101, 201, 30]));
  step4.add(ElementItem(503, 'http://eclipsedevelop.ru/images/503.png','http://eclipsedevelop.ru/images/103blur.jpg', 'Стразы', 'Стоимость за одну шт.', 20, 0, false, [101, 201, 30],[101, 201, 30],[101, 201, 30],[101, 201, 30]));
  step4.add(ElementItem(504, 'http://eclipsedevelop.ru/images/504.png','http://eclipsedevelop.ru/images/103blur.jpg', 'Зеркальная пудра', 'Стоимость за одну ногтевую пластину', 100, 0, false, [101, 201, 30],[101, 201, 30],[101, 201, 30],[101, 201, 30]));
  step4.add(ElementItem(505, 'http://eclipsedevelop.ru/images/505.png','http://eclipsedevelop.ru/images/103blur.jpg', 'Дизайн одного пальца', 'Стоимость за одну ногтевую пластину', 100, 0, false, [101, 201, 30],[101, 201, 30],[101, 201, 30],[101, 201, 30]));
  step4.add(ElementItem(506, 'http://eclipsedevelop.ru/images/506.png','http://eclipsedevelop.ru/images/103blur.jpg', 'Глитер', 'Стоимость за одну ногтевую пластину', 200, 100, false, [101, 201, 30],[101, 201, 30],[101, 201, 30],[101, 201, 30]));
  info.add(step4);
//СПА Уход
  step5.add(ElementItem(601, 'http://eclipsedevelop.ru/images/601.png','http://eclipsedevelop.ru/images/103blur.jpg', 'Витаминный уход', 'Омолаживающий и восстанавливающий уход с применением скраба и крема.', 200, 0, true, [101, 201, 30],[101, 201, 30],[101, 201, 30],[101, 201, 30]));
  step5.add(ElementItem(602, 'http://eclipsedevelop.ru/images/602.png','http://eclipsedevelop.ru/images/103blur.jpg', 'Парафинотерапия', 'Увлажняющий и питательный уход с применением парафина.', 300, 0, false, [101, 201, 30],[101, 201, 30],[101, 201, 30],[101, 201, 30]));
  step5.add(ElementItem(603, 'http://eclipsedevelop.ru/images/603.png','http://eclipsedevelop.ru/images/103blur.jpg', 'Тайский массаж', 'Тонизирующий массаж для улучшения кровообращения с применением масла', 200, 0, false, [101, 201, 30],[101, 201, 30],[101, 201, 30],[101, 201, 30]));
  info.add(step5);
//Брови
  step6.add(ElementItem(701, 'http://eclipsedevelop.ru/images/701.png','http://eclipsedevelop.ru/images/103blur.jpg', 'Коррекция', 'Коррекция формы, удаление нежелательных волос', 200, 0, false, [101, 201, 30],[101, 201, 30],[101, 201, 30],[101, 201, 30]));
  step6.add(ElementItem(702, 'http://eclipsedevelop.ru/images/702.png','http://eclipsedevelop.ru/images/103blur.jpg', 'Оформление бровей', 'Подбор и изменение формы', 300, 0, true, [101, 201, 30],[101, 201, 30],[101, 201, 30],[101, 201, 30]));
  step6.add(ElementItem(703, 'http://eclipsedevelop.ru/images/703.png','http://eclipsedevelop.ru/images/103blur.jpg', 'Окрашивание', 'Подбор цвета, окрашивание краской Estel, Igora', 300, 0, false, [101, 201, 30],[101, 201, 30],[101, 201, 30],[101, 201, 30]));
  info.add(step6);
  return info[category][indexx];
}

Widget Categories(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    child: SingleChildScrollView(
      child: Container(
        color: Color.fromRGBO(255, 188, 177, 0.0),
        height: 210 * 1.7 * 7 + 50,
        // Высота экрана равнозначна длине карточек, чтобы пролистывался  скролл, а не лист
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Container(
              height: 50,
              child: Stack(
                children: <Widget>[
                  Image.asset("assets/images/HeaderCatalog.png"),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 18.0),
                      child: Text(
                        "Каталог" , style:  TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 210 * 1.7 * 7,
              // Высота экрана равнозначна длине карточек, чтобы пролистывался  скролл, а не лист
              width: MediaQuery.of(context).size.width,
              child: Column(
//                scrollDirection: Axis.vertical,
                children: List.generate(7, (cat) {
                  return _Category(cat, context);
                }),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class HelpItemCount {
  String name;
  int count;

  HelpItemCount(String name, int count) {
    this.name = name;
    this.count = count;
  }
}

HelpItemCount ItemCount(int index) {
  List<HelpItemCount> info = [HelpItemCount('Комплексы', 7)];

  info.add(HelpItemCount('Маникюр', 5));
  info.add(HelpItemCount('Покрытия', 6));
  info.add(HelpItemCount('Педикюр', 6));
  info.add(HelpItemCount('Дизайн', 6));
  info.add(HelpItemCount('СПА Уход', 3));
  info.add(HelpItemCount('Брови', 3));

  return info[index];
}

Widget _Category(int cat, BuildContext context) {
  HelpItemCount info = ItemCount(cat);

  return Container(
    height: 210 * 1.7,
    width: 600,
    child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              info.name,
              style: TextStyle(
                  color: Color.fromRGBO(255, 116, 81, 0.9),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Divider(
          color: Color.fromRGBO(255, 116, 81, 0.8),
          thickness: 0.4,
        ),
        Padding(
          padding:
              const EdgeInsets.only(right: 1.0, left: 8, bottom: 18, top: 8),
          child: Container(
            height: 160 * 1.7,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(info.count, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, left: 8),
                  child: _Item(elementInfo(cat, index), context),
                );
              }),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _Item(ElementItem item, BuildContext context) {
  Widget inTrash() {
    return Container(
      height: 33,
      width: 150,
      child: FlatButton(
        shape: new RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
            side: BorderSide(color: Colors.black45)),
        color: Colors.white,
        textColor: Colors.pinkAccent,
        padding: EdgeInsets.all(8.0),
        onPressed: () {
          if (items.isEmpty) {
            //items_counter = [1];
            List<ElementItem> step = [item];
            items = step;
          } else {
            bool find = false;
            for (int i = 0; i < items.length; i++) {
              print(
                  'Добавляется элемент id${item.id} проверяется элемент id${items[i].id}');
              if (items[i].id == item.id) {
                //items_counter[i]++;
                // print('Элементов id${items[i].id} - ${items_counter[i]}');
                find = true;
                break;
              }
            }
            print('find = $find');
            if (!find) {
              items.add(item);
              //items_counter.add(1);
            }
          }
          final snackBar = SnackBar(
            duration: new Duration(milliseconds: 1000),
            content: Text(
                '${item.head.length < 18 ? 'Добавлено в корзину: ' + item.head : 'Услуга добавлена в корзину'} '),
            action: SnackBarAction(
              label: 'Хорошо',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );
          Scaffold.of(context).showSnackBar(snackBar);
        },
        child: Center(
          child: Text(
            'В корзину',
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  if (item.picture == '' || item.picture == '0') {
    return Row(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              new BoxShadow(
                color: Colors.black45,
                blurRadius: 20.0,
              ),
            ],
            gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                Colors.white,
              ],
//              stops: [0.45,0.5],
            ),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
          padding: EdgeInsets.all(20),
          height: 250 * 1.7,
          width: 150 * 1.7,
          child: Column(
            children: <Widget>[
              Align(
                alignment: AlignmentDirectional.center,
                child: Text(
                  item.head,
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, right: 8, left: 8),
                child: Container(
                  height: 150 * 1.7 - 120,
                  width: 150 * 1.7 - 16,
                  child: Align(
                    alignment: AlignmentDirectional.topCenter,
                    child: Center(
                      child: Text(
                        item.tx,
                        style: TextStyle(color: Colors.black26, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.topCenter,
                child: Center(
                  child: _price(item.price, item.sale),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: inTrash(),
              ),
            ],
          ),
          //color: Colors.white,
        ),
      ],
    );
  } else
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Detail(item)));
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 25),
        child: Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(255, 164, 116, .4),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(-2, 3), // changes position of shadow
                ),
              ],
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              border: Border.all(
                  width: 1, color: Color.fromRGBO(255, 188, 173, 1))),
          height: 250 * 1.7,
          width: 220,
          child: Column(
            children: <Widget>[
              Hero(
                tag: item.id,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: Image.network(
                          item.picture,
                          fit: BoxFit.fill,
                        ).image,
                        fit: BoxFit.fill),
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0),
                    ),
                  ),
                  height: 74,
                  width: 150 * 1.7, // 255
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 8.0, left: 10, right: 10),
                      child: Text(
                        item.head,
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 13.0, right: 8, top: 8, bottom: 0),
                      child: ConstrainedBox(
                        child: Text(
                          item.tx,
                          style: TextStyle(color: Colors.black26, fontSize: 16),
                        ),
                        constraints: BoxConstraints(minHeight: 80),
                      ),
                    ),
                  ],
                ),
              ),
              _price(item.price, item.sale),
              SizedBox(
                height: 10,
              ),
              inTrash()
            ],
          ),
        ),
      ),
    );
}

Widget _price(int price, int sale) {
  if (sale == 0) {
    return Text(
      '$price руб.',
      style: TextStyle(color: Colors.redAccent, fontSize: 16),
    );
  } else {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          '${price - sale} руб.',
          style: TextStyle(color: Colors.redAccent, fontSize: 16),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            '$price руб.',
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 16,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        )
      ],
    );
  }
}



class homeInheritedWidget extends InheritedWidget{
  final _Home myState;

  homeInheritedWidget({
    Key key,
    Widget child,
    @required this.myState
  }
  ) : super(key: key);
  @override
  bool updateShouldNotify(homeInheritedWidget oldWidget) {
    return false;
  }

  static homeInheritedWidget of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType();
  }

}

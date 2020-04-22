import 'package:flutter/material.dart';
import 'package:flutterapp32/Detail.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'Trash.dart';
import 'Objects.dart';


List<ElementItem> items;


class Home extends StatefulWidget {
  @override
  _Home createState() => new _Home();

}

String kartinka = 'https://p16.muscdn.com/img/musically-maliva-obj/1650991040036870~c5_720x720.jpeg';

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

  @override
  Widget build(BuildContext context) {

    items = [ElementItem(0,'','','',0,0)];
    items.clear();


    return new Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color.fromRGBO(255, 230, 229, 1),
      appBar: new AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: new Text(
          'Заголов Очка',
          style: TextStyle(
            color: Color.fromRGBO(62, 71, 87, 1),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.black45,
          ),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add_shopping_cart,
              color: Colors.black45,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Trash(items)));
            },
          )
        ],
      ),
      drawer: new Drawer(
          // elevation: 260.0,
          child: Container(
        color: Color.fromRGBO(62, 71, 87, 1),
        child: Stack(
          children: <Widget>[

            new ListView(
              padding: EdgeInsets.only(left: 10, right: 10),
              children: <Widget>[
                new DrawerHeader(
                  decoration: BoxDecoration(
//                color: Colors.blue,
                      ),
                  child: _MenuHeader(),
                ),
                new Divider(
                  color: Colors.white38,
                ),
                new ListTile(
                  title: new Text(
                    'Услуги',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
//                Navigator.pushNamed(context, '/home');
                  },
                ),
                new ListTile(
                  title: new Text(
                    'Корзина',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {},
                ),
                new ListTile(
                  title: new Text(
                    'Записи',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/Eclipse');

                  },
                ),
                new ListTile(
                  title: new Text(
                    'Контакты',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/Contacts');

                  },
                ),
                new ListTile(
                  title: new Text(
                    'Быстрый вызов',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {

                    setState(() {
                      _launched = _makePhoneCall('tel:+79307229602');
                    });
                  },
                ),
                new ListTile(
                  title: new Text(
                    'Информация',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/Quality');
                  },
                ),
                new Divider(
                  color: Colors.white38,
                ),
                new ListTile(
                  title: new Text(
                    'Выйти',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                  onTap: () {},
                ),
              ],
            ),
            Align(

              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0, left: 20),
                child: GestureDetector(
                  child: Text(
                    'Eclipse Developers 2020',
                    style: TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                  onTap: (){    print("Hello world");
                  Navigator.pushNamed(context, '/Eclipse');
                  },
                ),
              ),
              alignment: Alignment.bottomLeft,
            ),
          ],
        ),
      )),
      body: Builder(builder: (context)=> _Categories(context)),
    );
  }
}

Widget _MenuHeader() {
  return Center(
    child: Column(
      children: <Widget>[
        Text('Войти с помощью', style: TextStyle(color: Colors.white70)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: Image.asset('assets/images/inst.png').image,
                            fit: BoxFit.cover),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            blurRadius: 5.0,
                            spreadRadius: 0.1,
                            offset: Offset(-5, 5),
                          )
                        ] //boxShadow
                        ),
                    height: 60,
                    width: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Instagram',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: Image.asset('assets/images/vk.png').image,
                            fit: BoxFit.cover),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            blurRadius: 5.0,
                            spreadRadius: 0.01,
                            offset: Offset(-5, 5),
                          )
                        ] //boxShadow
                        ),
                    height: 60,
                    width: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'VK',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class ElementItem {
  int id;
  String picture;
  String head;
  String tx;
  int price;
  int sale;

  ElementItem(
      int id, String picture, String head, String tx, int price, int sale) {
    this.id = id;
    this.picture = picture;
    this.head = head;
    this.tx = tx;
    this.price = price;
    this.sale = sale;
  }
}

ElementItem _elementInfo(int category, int indexx) {
  List<List<ElementItem>> info = [];

  List<ElementItem> step = [];
  List<ElementItem> step1 = [];
  List<ElementItem> step2 = [];
  List<ElementItem> step3 = [];
  List<ElementItem> step4 = [];
  List<ElementItem> step5 = [];
  List<ElementItem> step6 = [];
  //Комплексы
  step.add(ElementItem(
      01,
      'http://eclipsedevelop.ru/images/xs1.png',
      'XS Комплекс',
      'Необрезной экспресс-маникюр и педикюр, покрытие лаком',
      1699,
      0));
  step.add(ElementItem(02, 'http://eclipsedevelop.ru/images/12.png',
      'S Комплекс', 'Маникюр и педикюр, покрытие лаком', 2299, 0));
  step.add(ElementItem(03, 'http://eclipsedevelop.ru/images/13.png',
      'М Комплекс', 'Снятие, маникюр и педикюр, покрытие гель-лаком', 3299, 0));
  step.add(ElementItem(
      04,
      'http://eclipsedevelop.ru/images/14.png',
      'L Комплекс',
      'Снятие, маникюр и педикюр, покрытие гель-лаком, дизайн',
      4299,
      0));
  step.add(ElementItem(
      05,
      'http://eclipsedevelop.ru/images/15.png',
      'XL Комплекс',
      'Снятие, маникюр и педикюр, покрытие гель-лаком, дизайн, спа-уход, использование аппарата',
      4999,
      0));
  step.add(ElementItem(
      06,
      'http://eclipsedevelop.ru/images/16.png',
      'Мужской Комплекс',
      'Классический обрезной маникюр и педикюр, полировка',
      1999,
      0));
  step.add(ElementItem(07, 'http://eclipsedevelop.ru/images/17.png',
      'Детский Комплекс', 'Детский маникюр и педикюр', 999, 0));
  info.add(step);
  print(info.toString());

  //Маникюр
  step1.add(ElementItem(
      08, '0', 'Маникюр «ColorBird»', 'Классический маникюр', 600, 0));
  step1.add(ElementItem(
      09, '0', 'Маникюр «Combo»', 'Комбинированный маникюр', 700, 0));
  step1.add(ElementItem(10, '0', 'Бразильский маникюр',
      'SPA-маникюр с применением перчаток', 700, 0));
  step1.add(ElementItem(11, '0', 'Мужской маникюр',
      'Обработка кутикулы, полировка ногтевой пластины', 900, 0));
  step1.add(ElementItem(12, '0', 'Детский маникюр',
      'Детский маникюр, удаление заусенцев', 400, 0));
  info.add(step1);
//Покрытия
  step2.add(ElementItem(13, '0', 'Лак', 'OPI, ESSE', 390, 0));
  step2
      .add(ElementItem(14, '0', 'Гель-Лак', 'CND, OPI GelColor, KOD', 950, 0));
  step2.add(ElementItem(
      15, '0', 'Укрепление гелем', 'Укрепляющее покрытие', 600, 0));
  step2.add(ElementItem(16, '0', 'IBX System', 'Укрепление пластины', 700, 0));
  step2.add(ElementItem(17, '0', 'Снятие геля ', '', 350, 0));
  step2.add(ElementItem(
      18, '0', 'Снятие покрытия', 'Снятие долговременного покрытия', 250, 0));
  info.add(step2);
//Педикюр
  step3.add(ElementItem(
      19, '0', 'Педикюр «ColorBird»', 'Классический педикюр', 990, 0));
  step3.add(ElementItem(
      20, '0', 'Педикюр «Combo»', 'Комбинированный педикюр', 1100, 0));
  step3.add(ElementItem(21, '0', 'Бразильский педикюр',
      'СПА-педикюр с применением специальных носочков', 1200, 0));
  step3.add(ElementItem(22, '0', 'Сложный педикюр',
      'Классический педикюр, удаление натоптышей, лечение трещин', 1300, 0));
  step3.add(ElementItem(
      23,
      '0',
      'Мужской педикюр',
      'Мужской педикюр, обработка кутикул и стоп, удаление натоптышей',
      1100,
      0));
  step3.add(ElementItem(24, '0', 'Детский педикюр',
      'Детский педикюр, удаление заусенцев', 700, 0));
  info.add(step3);
//Дизайн
  step4.add(ElementItem(25, '0', 'Авторский дизайн',
      'Стоимость дизайна 10 ногтевых пластин', 500, 0));
  step4.add(ElementItem(
      26,
      '0',
      'Френч/Лунный',
      'Стоимость дизайна 10 ногтевых пластин + долговременное покрытие',
      1200,
      0));
  step4.add(ElementItem(27, '0', 'Стразы', 'Стоимость за одну шт.', 20, 0));
  step4.add(ElementItem(28, '0', 'Зеркальная пудра',
      'Стоимость за одну ногтевую пластину', 100, 0));
  step4.add(ElementItem(29, '0', 'Дизайн одного пальца',
      'Стоимость за одну ногтевую пластину', 100, 0));
  step4.add(ElementItem(
      30, '0', 'Глитер', 'Стоимость за одну ногтевую пластину', 200, 100));
  info.add(step4);
//СПА Уход
  step5.add(ElementItem(
      31,
      'http://eclipsedevelop.ru/images/21.png',
      'Витаминный уход',
      'Омолаживающий и восстанавливающий уход с применением скраба и крема. Рекомендуется для сухой кожи рук и ног',
      200,
      0));
  step5.add(ElementItem(
      32,
      'http://eclipsedevelop.ru/images/22.png',
      'Холодная парафинотерапия',
      'Увлажняющий и питательный уход с применением косметического парафина. Идеальный уход во время холодов',
      300,
      0));
  step5.add(ElementItem(
      33,
      'http://eclipsedevelop.ru/images/21.png',
      'Тайский массаж',
      'Тонизирующий массаж для улучшения кровообращения рук и ног с применением массажного масла',
      200,
      0));
  info.add(step5);
//Брови
  step6.add(ElementItem(34, '0', 'Коррекция',
      'Коррекция формы, удаление нежелательных волос', 200, 0));
  step6.add(ElementItem(
      35, '0', 'Оформление бровей', 'Подбор и изменение формы', 300, 0));
  step6.add(ElementItem(36, '0', 'Окрашивание',
      'Подбор цвета, окрашивание краской Estel, Igora', 300, 0));
  info.add(step6);
  return info[category][indexx];
}

Widget _Categories(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    child: ListView(
      scrollDirection: Axis.vertical,
      children: List.generate(7, (cat) {
        return _Category(cat, context);
      }),
    ),
  );
}

class _HelpItemCount {
  String name;
  int count;

  _HelpItemCount(String name, int count) {
    this.name = name;
    this.count = count;
  }
}

_HelpItemCount _ItemCount(int index) {
  List<_HelpItemCount> info = [_HelpItemCount('Комплексы', 7)];

  info.add(_HelpItemCount('Маникюр', 5));
  info.add(_HelpItemCount('Покрытия', 6));
  info.add(_HelpItemCount('Педикюр', 6));
  info.add(_HelpItemCount('Дизайн', 6));
  info.add(_HelpItemCount('СПА Уход', 3));
  info.add(_HelpItemCount('Брови', 3));

  return info[index];
}

Widget _Category(int cat, BuildContext context) {
  _HelpItemCount info = _ItemCount(cat);

  return Container(
    height: 210 * 1.7,
    width: 600,
    child: Column(
      children: <Widget>[
        Text(
          info.name,
          style: TextStyle(color: Colors.black45, fontSize: 20),
        ),
        Divider(),
        Padding(
          padding:
              const EdgeInsets.only(right: 18.0, left: 18, bottom: 18, top: 8),
          child: Container(
            height: 160 * 1.7,
            width: 400,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(info.count, (index) {
                return _Item(_elementInfo(cat, index), context);
              }),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _Item(ElementItem item, BuildContext context) {
  if (item.picture == '' || item.picture == '0') {
    return Row(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              color: Colors.white70,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0))),
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
                child: GestureDetector(
                  onTap: (){
                    if(items.isEmpty){
                      List<ElementItem> step = [item];
                      items = step;
                    }else{items.add(item);}

                    final snackBar = SnackBar(
                      content: Text('${item.head.length < 18?'Добавлено в корзину: '+item.head:'Услуга добавлена в корзину'} '),
                      action: SnackBarAction(
                        label: 'Отмена',
                        onPressed: () {
                          // Some code to undo the change.
                        },
                      ),
                    );

                    // Find the Scaffold in the widget tree and use
                    // it to show a SnackBar.
                    Scaffold.of(context).showSnackBar(snackBar);
                  },
                  child: Container(

                    height: 33,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.rectangle,
                      border: Border.all(color: Colors.black45),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25.0),
                        bottomLeft: Radius.circular(25.0),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'В корзину',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          //color: Colors.white,
        ),
        SizedBox(
          width: 15,
          height: 150,
          child: Container(
            color: Colors.transparent,
          ),
        )
      ],
    );
  } else
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: (){
            Navigator.of(context)
                .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
              return new Detail();
            }));
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white70,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0))),
            padding: EdgeInsets.only(bottom: 0),
            height: 250 * 1.7,
            width: 150 * 1.7,
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: Image.network(
                          item.picture,
                          fit: BoxFit.fill,
                        ).image,
                        fit: BoxFit.fill),
                    color: Colors.white70,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                    ),
                  ),
                  height: 74,
                  width: 150 * 1.7, // 255
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 10, right: 10),
                  child: Align(
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      item.head,
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0, right: 6, left: 12),
                  child: Container(
                    height: 150 * 1.7 - 185,
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
                  child: GestureDetector(
                    onTap: (){

                      if(items.isEmpty){
                        List<ElementItem> step = [item];
                        items = step;
                      }else{items.add(item);}

                      final snackBar = SnackBar(
                        content: Text('${item.head.length < 18?'Добавлено в корзину: '+item.head:'Услуга добавлена в корзину'} '),
                        action: SnackBarAction(
                          label: 'Отмена',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      );

                      // Find the Scaffold in the widget tree and use
                      // it to show a SnackBar.
                      Scaffold.of(context).showSnackBar(snackBar);
                    },
                    child: Container(
                      height: 33,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Colors.black45),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25.0),
                          bottomLeft: Radius.circular(25.0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'В корзину',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            //color: Colors.white,
          ),
        ),
        SizedBox(
          width: 15,
          height: 150,
          child: Container(
            color: Colors.transparent,
          ),
        )
      ],
    );
}

Widget _price(int price, int sale) {
  if (sale == 0) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          '$price руб.',
          style: TextStyle(color: Colors.redAccent, fontSize: 16),
        )
      ],
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

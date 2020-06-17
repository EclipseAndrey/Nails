import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Objects.dart';
import 'home.dart';
import 'main.dart';

class OrdersCancel extends StatefulWidget {
  @override
  _OrdersCancelState createState() => _OrdersCancelState();
}

class _OrdersCancelState extends State<OrdersCancel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.withOpacity(0.8),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Отмененные записи",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "MPLUS",
          ),
        ),
      ),
      body: Content(),
    );
  }

  Widget Content() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top : 8.0),
            child: Column(
              children: List.generate(ObjectOrdersCacel.getOrders().length, (index) {
                return ItemUser(ObjectOrdersCacel.getOrders()[index]);
              }),
            ),
          )),
    );
  }

  String _month(String month) {
    switch (month) {
      case "1":
        return "Января";
        break;
      case "2":
        return "Февраля";
        break;
      case "3":
        return "Марта";
        break;
      case "4":
        return "Апреля";
        break;
      case "5":
        return "Мая";
        break;
      case "6":
        return "Июня";
        break;
      case "7":
        return "Июля";
        break;
      case "8":
        return "Августа";
        break;
      case "9":
        return "Сентября";
        break;
      case "10":
        return "Октября";
        break;
      case "11":
        return "Ноября";
        break;
      case "12":
        return "Декабря";
        break;
    }
  }

  Widget ItemUser(ItemOrder order) {

    Widget uslugi(){

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(order.OrderIds.length, (index){
          int id = int.parse(order.OrderIds[index]);
          return
            Text(elementInfo((id ~/ 100-1), id % 100-1).head,
              style: TextStyle(color: Colors.black54, fontSize: 18),
            );
        }),
      );

    }

    var intlorder = new DateFormat("dd.MM.yyyy HH:mm", "en_US").parse(order.date + " " + order.time);

    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: GestureDetector(
        onTap: () async {},
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(34, 15, 45, .3),
                    blurRadius: 10,
                    offset: Offset(-2.5, 5))
              ]),
          width: MediaQuery.of(context).size.width * 0.95,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(intlorder.day.toString()+" "+_month(intlorder.month.toString()),
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    Text("  "+order.time,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    Text("  Отменено",
                      style: TextStyle(color: Colors.red, fontSize: 20),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Text("",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      Text(order.address,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Выбранные услуги",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: uslugi(),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text("Комментарий к заказу",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(order.comment == ""?"Нет комментария":order.comment,
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Row(
                    children: [
                      Text("Промокод: ",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      Text(order.promo == "0"?"Не указан":order.promo,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Row(
                    children: [
                      Text("Сумма к оплате: ",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      Text(order.prise+" руб.",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Row(
                    children: [
                      Text("Клиент ",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      Text(order.name,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Text("Телефон: ",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      Text(order.num,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:0.0, top:12),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        side: BorderSide(color: Colors.green)),
                    color: Colors.transparent,
                    textColor: Colors.green,
                    onPressed: () {  },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 3.0, right: 3, top: 3, bottom: 3),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 3.0),
                              child: Icon(Icons.call, color: Colors.green,),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text("Позвонить",
                                style: TextStyle(
                                    color: Colors.green,
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
                  ),
                ),
                Row(
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(left: 0.0),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            side: BorderSide(color: Colors.green)),
                        color: Colors.transparent,
                        textColor: Colors.green,
                        onPressed: () {  },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 3.0, right: 3, top: 3, bottom: 3),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 3.0),
                                  child: Icon(Icons.check, color: Colors.green,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text("Восстановить",
                                    style: TextStyle(
                                        color: Colors.green,
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
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp32/main.dart';

import 'Objects.dart';

class Addresses extends StatefulWidget {
  @override
  _AddressesState createState() => _AddressesState();
}

class _AddressesState extends State<Addresses> {
  String _cityValue = "Москва";
  double sizeText = 16;

  TextEditingController AddAddressstreetController = TextEditingController(),
      AddAddresshouseController = TextEditingController(),
      AddAddresskvController = TextEditingController(),
      AddAddressstroenieController = TextEditingController(),
      AddAddresscorpusController = TextEditingController();

  TextEditingController SelectAddressstreetController = TextEditingController(),
      SelectAddresshouseController = TextEditingController(),
      SelectAddresskvController = TextEditingController(),
      SelectAddressstroenieController = TextEditingController(),
      SelectAddresscorpusController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Управление адресами",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "MPLUS",
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: (){

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
                        return AddAddress(setState3);
                      },
                    );

                  },
                );

              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Content(),
    );
  }

  Widget Content() {
    ObjectAddress.AdressListUp();
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(ObjectAddress.getAddresses().length, (index) {

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

            return Padding(
              padding:  EdgeInsets.only(top: 12.0),
              child: GestureDetector(
                onTap: (){
                  showGeneralDialog(
                      barrierColor: Colors.black.withOpacity(0.3),
                      transitionBuilder: (context, a1, a2, widget) {
                        final curvedValue = Curves.easeInOutBack.transform(a1.value) -   1.0;
                        return Transform(
                          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
                          child: Opacity(
                            opacity: a1.value,
                            child: CupertinoAlertDialog(
                              title: Text("Выберите действие"),
                              content: Padding(
                                padding: const EdgeInsets.only(top: 0.0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(buildAdress()),
                                    ),
                                  ],

                                ),
                              ),
                              actions: [
                                CupertinoDialogAction(child: Text("Изменить", style: TextStyle(color: Colors.deepPurple),),onPressed: (){
                                  Navigator.of(context).pop(context);

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
                                          return SelectAddress(setState3, step);
                                        },
                                      );

                                    },
                                  );
                                },),
                                CupertinoDialogAction(child: Text("Удалить", style: TextStyle(color: Colors.redAccent),),onPressed: ()async{

                                  Navigator.of(context).pop(context);

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
                                  }

                                  _onLoading();

                                  await ObjectAddress.deleteAddress(step);

                                  Navigator.of(context).pop(context);


                                  ObjectAddress.AdressListUp();


                                  showGeneralDialog(
                                      barrierColor: Colors.black.withOpacity(0.3),
                                      transitionBuilder: (context, a1, a2, widget) {
                                        final curvedValue = Curves.easeInOutBack.transform(a1.value) -   1.0;
                                        return Transform(
                                          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
                                          child: Opacity(
                                            opacity: a1.value,
                                            child: CupertinoAlertDialog(
                                              title: Text("Адрес удален"),

                                              actions: [
                                                CupertinoDialogAction(child: Text("Ок", style: TextStyle(color: Colors.deepPurple),),onPressed: (){
                                                  Navigator.of(context).pop(context);
                                                  setState(() {

                                                  });
                                                },),

                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      transitionDuration: Duration(milliseconds: 200),
                                      barrierDismissible: true,
                                      barrierLabel: '',
                                      context: context,
                                      pageBuilder: (context, animation1, animation2) {});

                                },)
                              ],
                            ),
                          ),
                        );
                      },
                      transitionDuration: Duration(milliseconds: 200),
                      barrierDismissible: true,
                      barrierLabel: '',
                      context: context,
                      pageBuilder: (context, animation1, animation2) {});
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [BoxShadow(
                          color: Color.fromRGBO(34, 15, 45, .3),
                          blurRadius: 10,
                          offset: Offset(-2.5, 5)
                      )]
                  ),
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: MediaQuery.of(context).size.width * 0.15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(left: 8.0),
                        child: FittedBox(

                            child: Text(buildAdress(), style: TextStyle(fontFamily: "MPLUS",fontSize: 18, color: Colors.black),)),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
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

  Widget SelectAddress(StateSetter setState3, adress step){
    final FocusNode streetFocusNode = new FocusNode () ;
    final FocusNode houseFocusNode = new FocusNode () ;
    final FocusNode kvFocusNode = new FocusNode () ;
    final FocusNode stroenieFocusNode = new FocusNode () ;
    final FocusNode corpusFocusNode = new FocusNode () ;

    SelectAddressstreetController.text =  step.street;
    SelectAddresshouseController.text = step.house;
    SelectAddresskvController.text = step.kv == "null"?"":step.kv;
    SelectAddressstroenieController.text = step.stroenie == "null"?"":step.stroenie;
    SelectAddresscorpusController.text = step.corpus == "null"?"":step.corpus;


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
                                  controller: SelectAddressstreetController,
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
                                  controller: SelectAddresshouseController,
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
                                  controller: SelectAddresskvController,
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
                                  controller: SelectAddressstroenieController,
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
                                  controller: SelectAddresscorpusController,
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
                              onPressed: ()async {
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
                                }

                                _onLoading();

                                await ObjectAddress.deleteAddress(step);
                                //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

                                if(_cityValue != "" && SelectAddressstreetController.text != "" && SelectAddresshouseController.text != ""){
                                  adress Address = adress(city: _cityValue, street: SelectAddressstreetController.text, house: SelectAddresshouseController.text,
                                      corpus: SelectAddresscorpusController.text, stroenie: SelectAddressstroenieController.text, kv: SelectAddresskvController.text);
                                 await ObjectAddress.addAddress(Address);
                                  print(Address);
                                  await ObjectAddress.AdressListUp();
                                  setState3(() {
                                    selectAdress = (ObjectAddress.getAddresses().length).toString();
                                  });
                                  Navigator.pop(context);
                                  print("=========selectAdres=======" + selectAdress);
                                }else{
                                  print("===== Заполните обязательные поля");
                                }
                                Navigator.of(context).pop(context);
                                setState(() {

                                });

                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left : 8.0, right: 8.0),
                                child: Text(
                                  'Сохранить',
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
                child: Text("Редактирование", style:  TextStyle(
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

  Widget AddAddress(StateSetter setState3){
    final FocusNode streetFocusNode = new FocusNode () ;
    final FocusNode houseFocusNode = new FocusNode () ;
    final FocusNode kvFocusNode = new FocusNode () ;
    final FocusNode stroenieFocusNode = new FocusNode () ;
    final FocusNode corpusFocusNode = new FocusNode () ;

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
                                  controller: AddAddressstreetController,
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
                                  controller: AddAddresshouseController,
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
                                  controller: AddAddresskvController,
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
                                  controller: AddAddressstroenieController,
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
                                  controller: AddAddresscorpusController,
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
                              onPressed: ()async {
                                if(_cityValue != "" && AddAddressstreetController.text != "" && AddAddresshouseController.text != ""){
                                  adress Address = adress(city: _cityValue, street: AddAddressstreetController.text, house: AddAddresshouseController.text,
                                      corpus: AddAddresscorpusController.text, stroenie: AddAddressstroenieController.text, kv: AddAddresskvController.text);

                                 await ObjectAddress.addAddress(Address);
                                  print(Address);
                                  await ObjectAddress.AdressListUp();
                                  Navigator.pop(context);
                                  setState(() {

                                  });


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


}

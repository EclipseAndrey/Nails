import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutterapp32/home.dart';
import 'Objects.dart';
import 'home.dart';

class Trash extends StatefulWidget{

  List<ElementItem> items;

  Trash(List<ElementItem> items){
    this.items = items;
  }
  @override
  State<StatefulWidget> createState() {
return _Trash();
  }

}



class _Trash extends State<Trash> with TickerProviderStateMixin{


  List<AnimationController> controller ;
  List<bool> okk;
  List<double> cancel;

  @override
  void initState() {
    controller = [AnimationController(vsync: this, duration: Duration(seconds: 1))];
    controller.clear();
    okk = [true];
    okk.clear();
    cancel = [0.0];
    cancel.clear();

    for(int i = 0; i < items.length; i++) okk.add(true);
    for(int i = 0; i < items.length; i++) cancel.add(1);
    for(int i = 0; i < items.length; i++) {
      controller.add(
          AnimationController(vsync: this, duration: Duration(milliseconds: 200)));
    }
    super.initState();
  }






  ok(){
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    print(items);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text('Ваш заказ', style: TextStyle(fontSize: 22, color: Colors.black),),

      ),
      body: BodyTrash(),
    );
  }

  Widget BodyTrash(){
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
         Column(
          children: <Widget>[
            Divider(),
            Container(
              height: items.length*50.toDouble(),
              child: Column(
                children: List.generate(items.length, (i)=> _ElementTrash(i)),
              ),
            )
          ],
        ),
          Opacity(
            opacity: items.length==0?1:0,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Center(child: Text('Выберите услуги в каталоге услуг')),
            ),
          )
        ],
      ),
    );
  }

  Widget _ElementTrash(int i){
    Animation<double> remove;
    Tween tween  = new Tween<double>(begin: 50, end: 0);

    remove = tween.animate(controller[i]);

    remove.addListener(() {
      setState(() {
      });});
    remove.addStatusListener((status) {
      if(status == AnimationStatus.completed && okk[i]){
        controller.removeAt(i);
        items.removeAt(i);
        okk.removeAt(i);
        cancel.removeAt(i);
        okk[i] = false;
      }
    });

    print('generate $i');
    return Container(
      height: remove.value,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Align(
          alignment:FractionalOffset(1,1),
          child: ListTile(
            leading: CircleAvatar(child:  ImagePodbor(items[i].picture)
            ),
            title: Text(items[i].head, style: TextStyle(color: Colors.black),),
            trailing: GestureDetector(
                onTap: (){
                  setState(() {
                    cancel[i] = 0.0;
                  });
                  controller[i].forward();
                  ok();
                },
                child: Opacity(
                    opacity: cancel[i],
                    child: Icon(Icons.cancel))),
          ),
        ),
      ),
    );
  }
}





Widget ImagePodbor(String image){
  if(image == ''|| image == '0'){
    return Image.asset(
      'assets/images/inst.png',
    );
  }else{
    return Image.network(image);
  }
}
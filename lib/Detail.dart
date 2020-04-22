import 'package:flutter/material.dart';
import 'home.dart';

class Detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'jopa',
      child: Container(
        child: Column(
          children: <Widget>[
            Image.network(kartinka,fit: BoxFit.fill,width: MediaQuery.of(context).size.width,),
            Text("Сайт рыбатекст поможет дизайнеру, верстальщику, вебмастеру сгенерировать несколько абзацев более менее осмысленного текста рыбы на русском языке,"
                " а начинающему оратору отточить навык публичных выступлений в домашних условиях. При создании генератора мы использовали небезизвестный универсальный "
                "код речей. Текст генерируется абзацами случайным образом от двух до десяти предложений в абзаце, что позволяет сделать текст более привлекательным и живым "
                "для визуально-слухового восприятия.", style: TextStyle(fontSize: 16,decoration: TextDecoration.none),),
          ],
        ),
      ),
    );
  }
}

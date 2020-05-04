import 'package:flutter/material.dart';

InputDecoration inputDecoration1 = InputDecoration(
  hintText: 'Email',
);
InputDecoration inputDecoration2 = InputDecoration(
  hintText: 'Email',
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
  ),
  fillColor: Colors.grey[200],
  filled: true,
);
InputDecoration inputDecoration3 = InputDecoration(
  hintText: 'Email',
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
  ),
  fillColor: Colors.grey[200],
  filled: true,
  prefixIcon: Icon(
    Icons.mail,
    color: Colors.black,
  ),
);
InputDecoration inputDecoration4 = InputDecoration(
  labelText: 'Телефон',
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
  ),
  fillColor: Colors.grey[100],
  filled: true,
  suffixIcon: Icon(
    Icons.phone_iphone,
    color: Colors.black,
  ),
);
InputDecoration inputDecoration5 = InputDecoration(
  labelText: 'Телефон',
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
  ),
  hintStyle: TextStyle(
    color: Colors.white,
  ),
  focusedBorder: InputBorder.none,
  contentPadding: EdgeInsets.all(16),
  enabledBorder: InputBorder.none,
);

InputDecoration inputDecorationName = InputDecoration(
  labelText: 'Имя',
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
  ),
  fillColor: Colors.grey[100],
  filled: true,
  suffixIcon: Icon(
    Icons.person,
    color: Colors.black,
  ),
);

InputDecoration inputDecorationMess = InputDecoration(
  labelText: 'Ваш вопрос',
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
  ),
  fillColor: Colors.grey[100],
  filled: true,
  suffixIcon: Icon(
    Icons.mail,
    color: Colors.black,
  ),
);

InputDecoration inputDecorationAdress = InputDecoration(
  labelText: "Адрес",
  border: OutlineInputBorder(

    borderRadius: BorderRadius.all(

      Radius.circular(30),
    ),
  ),
  fillColor: Colors.white,
  filled: true,
  suffixIcon: Icon(
    Icons.location_on,
    color: Colors.black,
  ),
);



InputDecoration inputDecorationNumber = InputDecoration(
  labelText: "Номер",
  border: OutlineInputBorder(

    borderRadius: BorderRadius.all(

      Radius.circular(30),
    ),
  ),
  fillColor: Colors.white,
  filled: true,
  suffixIcon: Icon(
    Icons.phone_iphone,
    color: Colors.black,
  ),
);

InputDecoration inputDecorationNamee = InputDecoration(
  labelText: "Имя",
  border: OutlineInputBorder(

    borderRadius: BorderRadius.all(

      Radius.circular(30),
    ),
  ),
  fillColor: Colors.white,
  filled: true,
  suffixIcon: Icon(
    Icons.person,
    color: Colors.black,
  ),
);

InputDecoration inputDecorationComment = InputDecoration(
  labelText: "Комментарий к заказу",
  border: OutlineInputBorder(

    borderRadius: BorderRadius.all(

      Radius.circular(30),
    ),
  ),
  fillColor: Colors.white,
  filled: true,
  suffixIcon: Icon(
    Icons.chat_bubble_outline,
    color: Colors.black,
  ),
);

InputDecoration inputDecorationPromo = InputDecoration(
  labelText: "Промокод",
  border: OutlineInputBorder(

    borderRadius: BorderRadius.all(

      Radius.circular(30),
    ),
  ),
  fillColor: Colors.white,
  filled: true,
  suffixIcon: Icon(
    Icons.local_offer,
    color: Colors.black,
  ),
);













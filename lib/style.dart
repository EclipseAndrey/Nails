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
import 'package:flutter/material.dart';
import 'package:test_flutter/app/core/values/colors.dart';
import 'package:test_flutter/app/core/values/icons.dart';

List<Icon> getIcons() {
  return const [
    Icon(IconData(personIcon, fontFamily: 'MaterialIcons'), color: purple),
    Icon(IconData(workIcon, fontFamily: 'MaterialIcons'), color: pink),
    Icon(IconData(movieIcon, fontFamily: 'MaterialIcons'), color: green),
    Icon(IconData(sportIcon, fontFamily: 'MaterialIcons'), color: yellow),
    Icon(IconData(travelIcon, fontFamily: 'MaterialIcons'), color: deeppink),
    Icon(IconData(shopIcon, fontFamily: 'MaterialIcons'), color: lightblue),
  ];
}

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowCatModel{
  String text;
  String image;
 final VoidCallback function;
  ShowCatModel({required this.image,required this.text,required this.function});
}
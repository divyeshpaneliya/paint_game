import 'package:flutter/material.dart';
import 'package:paint_game/screen/home/home.dart';
import 'package:paint_game/screen/home/s2.dart';


void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/':(context)=>home(),
        's2':(context)=>s2(),
      },
    ),
  );
}

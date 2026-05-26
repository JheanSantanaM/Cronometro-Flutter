import 'package:cronometro/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(Cronometro());

class Cronometro extends StatelessWidget {
  const Cronometro({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cronômetro',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Colors.amberAccent
        
      ),
      home: Home(),
    );
     
  }
}
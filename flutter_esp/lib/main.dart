import 'package:flutter/material.dart';
import 'package:flutter_esp/Screen/adruino.dart';
import 'package:flutter_esp/Screen/home.dart';
import 'package:flutter_esp/widgets/fondo.dart';



void main()=> runApp(Screen());

class Screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mano',
      initialRoute: 'home',
      routes: {
       'arduino_screen' : ( _ ) => Fondo(),
       'home'           : ( _ ) => Home()
      }

       
      
    );
  }
}

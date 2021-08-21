import 'package:flutter/material.dart';
import 'package:flutter_esp/Screen/adruino.dart';
import 'package:flutter_esp/widgets/background.dart';
import 'package:flutter_esp/widgets/fondo.dart';
 

 class Home extends StatelessWidget {
 
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body: Stack(
         children: [
           //Background(),
           //MyApp()
           Fondo()
         ],
       ),

     );
   }
 }
 

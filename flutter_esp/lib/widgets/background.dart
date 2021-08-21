
import 'package:flutter/material.dart';

class Background extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors:[
              Color(0xff047ca4),
              Color(0xff68cfd6),
              Color(0xff3bd4ce)
          ] )

      ),
      
      
    );
  }
}
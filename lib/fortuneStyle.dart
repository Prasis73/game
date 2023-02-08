import 'package:flutter/material.dart';
//also can modify custom style here
class FortuneCustomStyle extends StatefulWidget {
  MaterialColor? color;
  String text="";
 FortuneCustomStyle({super.key, required this.color, required this.text});

  @override
  State<FortuneCustomStyle> createState() => _FortuneCustomStyleState();
}
 
class _FortuneCustomStyleState extends State<FortuneCustomStyle> {
  @override
  Widget build(BuildContext context) {
    
    return Container(decoration: BoxDecoration(border: Border.all(color: Colors.blue,width: 1),
      color: widget.color
    ),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(child: Text(widget.text,style:const  TextStyle(fontWeight: FontWeight.bold),)),

    );
  }
}
import 'package:flutter/material.dart';
import 'home.dart';

void main(){
  runApp(Flash_card());
}

class Flash_card extends StatelessWidget{
 const Flash_card({super.key});
 @override
  Widget build(BuildContext context) {
   return MaterialApp(
    title: 'Flash card',
    debugShowCheckedModeBanner: false,
    home: Scaffold(
     appBar: AppBar(title: Text('Flash card'),
    ),
     body: HomeScreen(),
    ),
   );

  }
}
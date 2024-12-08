import 'package:flutter/material.dart';
import 'package:smartpark/pages/firstpage.dart';
import 'package:smartpark/pages/history.dart';
import 'package:smartpark/pages/home.dart';
import 'package:smartpark/pages/mark.dart';
import 'package:smartpark/pages/parkslot.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstPage(),
      routes: {
        '/home': (context) => Home(), 
        '/history' :(context) => HistoryPage(),
        '/firstpage' :(context) => FirstPage(),
        '/parkslot' :(context) => ParkingSlotPage(),
        '/mark' :(context) => MarkPage(),
      },

    ); 
  }
}

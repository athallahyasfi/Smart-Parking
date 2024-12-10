import 'package:flutter/material.dart';
import 'package:smartpark/pages/firstpage.dart';
import 'package:smartpark/pages/history.dart';
import 'package:smartpark/pages/home.dart';
import 'package:smartpark/pages/mark.dart';
import 'package:smartpark/pages/parkslot.dart';
import 'package:smartpark/pages/profile.dart';
import 'package:smartpark/pages/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
      routes: {
        '/home': (context) => const Home(),
        '/history': (context) => const HistoryPage(),
        '/firstpage': (context) => const FirstPage(),
        '/parkslot': (context) => ParkingSlotPage(),
        '/mark': (context) => const MarkPage(),
        '/profile': (context) => const ProfilePage(),
        '/login': (context) => const LoginPage(),
      },
    );
  }
}

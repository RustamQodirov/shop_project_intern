import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop/features/investment/home/presentation/screens/investment_home_screen.dart';
import 'package:shop/features/shop/home/presentation/screens/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InvestHomePage(),
    );
  }
}

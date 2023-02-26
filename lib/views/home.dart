import 'package:flutter/material.dart';
import 'package:slide_ruler_sever/views/connetion.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SlideRulerServer',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ConnectionServer());
  }
}

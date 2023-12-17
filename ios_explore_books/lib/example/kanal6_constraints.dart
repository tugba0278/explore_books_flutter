import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const WidgetDetail());
}

class WidgetDetail extends StatefulWidget {
  const WidgetDetail({super.key});

  @override
  State<WidgetDetail> createState() => _WidgetDetailState();
}

class _WidgetDetailState extends State<WidgetDetail> {
  int value = 11;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: GoogleFonts.arimoTextTheme()), //tüm uygulamaya yansır
      home: Center(
        child: Container(
          color: Colors.yellow,
          width: 100,
          height: 200,
          child: Container(color: Colors.purple, width: 50, height: 50),
        ),
      ),
    );
  }
}

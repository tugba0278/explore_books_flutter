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
      home: Row(children: [
        Flexible(
            flex: 2, //2 birimlik yer ayırır
            child: Container(
                color: Colors.yellow,
                child: const Text("helloworldnasılsınız"))),
        Flexible(
            child: Container(
                color: Colors.blueGrey[100], child: const Text("iyiyim")))
      ]),
    );
  }
}

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
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Widget Detail"),
          centerTitle: true,
          backgroundColor: Colors.deepOrange,
          leading: const Text("Menü"),
        ),
        body: Center(
          child: Image.asset("lib/assets/images/images1.png"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              value = value + 1;
            });
          },
          child: const Text("+"),
        ),
      ),
    );
  }
}

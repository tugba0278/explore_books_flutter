import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: const Color.fromARGB(255, 133, 178, 201),
        title: const Text(
          'AYARLAR',
          style: TextStyle(color: Color.fromARGB(255, 67, 85, 94)),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          iconSize: 40,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        child: Center(
          child: Text(
            'BURASI DAHA SONRADAN EKLENECEKTİR.',
            style: TextStyle(
              fontSize: 25,
              fontFamily: 'Arial',
              color: Color.fromARGB(255, 67, 85, 94),
            ),
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    );
  }
}

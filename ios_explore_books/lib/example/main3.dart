import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3, // Toplam sekme sayısı
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Flutter Sekme Örneği'),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Sekme 1'),
                Tab(text: 'Sekme 2'),
                Tab(text: 'Sekme 3'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              Center(
                child: Text('Sekme 1 İçeriği'),
              ),
              Center(
                child: Text('Sekme 2 İçeriği'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

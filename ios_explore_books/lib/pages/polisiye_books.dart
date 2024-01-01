import 'package:flutter/material.dart';
import 'package:ios_explore_books/services/cms/read_content.dart';

class PolisiyeBooks extends StatefulWidget {
  const PolisiyeBooks({super.key});

  @override
  State<PolisiyeBooks> createState() => _PolisiyeBooksState();
}

class _PolisiyeBooksState extends State<PolisiyeBooks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kitaplık'),
      ),
      body: Column(
        children: <Widget>[
          // Sıralama ve filtreleme seçenekleri için Row widget'ı
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Sıralama işlevi
                },
                child: const Text('SIRALA'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Filtreleme işlevi
                },
                child: const Text('FİLTRELE'),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          // GridView.builder artık esnek bir alanda yer alıyor.
          Expanded(
            child: fetchAndDisplayContents(
                'polisiye-books'), // 'your_slug' yerine kendi slug değerinizi girin.
          ),
        ],
      ),
    );
  }
}

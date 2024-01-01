import 'package:flutter/material.dart';
import 'package:ios_explore_books/services/cms/read_content.dart';

class ReligiousBooks extends StatefulWidget {
  const ReligiousBooks({super.key});

  @override
  State<ReligiousBooks> createState() => _ReligiousBooksState();
}

class _ReligiousBooksState extends State<ReligiousBooks> {
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
                'religious-books'), // 'your_slug' yerine kendi slug değerinizi girin.
          ),
        ],
      ),
    );
  }
}

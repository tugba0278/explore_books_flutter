import 'package:flutter/material.dart';
import 'package:ios_explore_books/services/cms/author_list.dart';

class AuthorList extends StatefulWidget {
  const AuthorList({super.key});

  @override
  State<AuthorList> createState() => _AuthorListState();
}

class _AuthorListState extends State<AuthorList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yazarlar'),
      ),
      body: Column(
        children: <Widget>[
          // Sıralama ve filtreleme seçenekleri için Row widget'ı

          const SizedBox(
            height: 20,
          ),
          // GridView.builder artık esnek bir alanda yer alıyor.
          Expanded(
            child: fetchAndDisplayAuthors(
                'author-list'), // 'your_slug' yerine kendi slug değerinizi girin.
          ),
        ],
      ),
    );
  }
}

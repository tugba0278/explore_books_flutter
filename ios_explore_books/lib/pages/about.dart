import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: const Color.fromARGB(255, 133, 178, 201),
        title: const Text(
          'HAKKIMIZDA',
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
            'Bu uygulama, kitapları çeşitli kategorilere göre listeler '
            've kullanıcılara farklı kategorilerdeki kitaplar arasında gezinme imkanı sunar. '
            'Ayrıca kullanıcılar kitaplara puan verebilir, yorumlar yazabilir ve favori kitaplarını belirleyebilir. '
            'Ne tür kitaplar okumak istediğinizi seçerek önerilen kitapları okurseverler görebilir.',
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

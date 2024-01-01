import 'package:dialogue_wise/DTOs/get_contents_request.dart';
import 'package:dialogue_wise/dialoguewise.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';

class BookDetailsPage extends StatelessWidget {
  final String authorName;
  final String bookName;
  final String bookImage;

  const BookDetailsPage({
    super.key,
    required this.authorName,
    required this.bookName,
    required this.bookImage,
  });

  @override
  Widget build(BuildContext context) {
    // MediaQuery.of(context).size alınarak cihazın boyutlarına erişilir.
    var screenSize = MediaQuery.of(context).size;

    // Resim için önerilen yükseklik ve genişlik.
    double imageHeight =
        screenSize.height * 0.5; // Ekranın %50'ı kadar yükseklik.
    double imageWidth = screenSize.width * 1; // Ekrankadar genişlik.

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20),
              height: imageHeight, // Belirlenen yükseklik değeri
              width: imageWidth, // Belirlenen genişlik değeri
              child: Image.network(
                bookImage,
                fit: BoxFit.contain, // Resmi kapsayıcıya sığdır.
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Text(authorName,
                  style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold) // Kitap adı için stil.
                  ),
            ),
            Text(bookName,
                style: const TextStyle(
                  fontSize: 20,
                ) // Kitap adı için stil.
                ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  // Burada puanlama işlemini işleyin
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Yorumunuzu yazın..',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3, // Yorum kutusunun satır sayısı
                // Yorum metnini işleyin
              ),
            ),
          ],
        ),
      ),
    );
  }
}

FutureBuilder<Map> fetchAndDisplayContents(String slug) {
  return FutureBuilder(
    future: getContents(slug),
    builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text("Error: ${snapshot.error}"));
      } else {
        var data = snapshot.data?["data"]["contents"];
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // İki sütun
            childAspectRatio: 0.6, // Yükseklik/genişlik oranı
          ),
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            var book = data[index];
            var coverUrl = book['cover'].substring(
                2, book['cover'].length - 2); // Varsayılan kapak resmi URL'si

            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BookDetailsPage(
                      bookImage: coverUrl,
                      authorName: book["author_name"] ?? 'Unknown',
                      bookName: book["book_name"] ?? 'Unknown',
                    ),
                  ),
                );
              },
              child: Card(
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Image.network(coverUrl,
                              fit: BoxFit.fitWidth), // Kapak resmi
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(book["book_name"] ?? 'Unknown', // Kitap adı
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              Text(book["book_name"] ?? 'Unknown'), // Yazar adı
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 0,
                      right: -15,
                      child: IconButton(
                        icon: Opacity(
                          opacity: 0.8, // %50 saydamlık
                          child: Icon(Icons.favorite,
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary), // Renk ayarı
                        ),
                        onPressed: () {
                          // Kalp ikonuna tıklama işlevi
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
    },
  );
}

Future<Map> getContents(String slug) async {
  var request = GetContentsRequest();
  request.slug = slug;
  var accessToken = '580B3e1f5E934a25c56bc4bc75AB08A018cf485B2C41298ea51599DD';
  var dialogueWiseService = DialoguewiseService(accessToken: accessToken);
  var response = await dialogueWiseService.getContents(request);

  print(response.response);

  return response.response;
}

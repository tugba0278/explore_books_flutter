import 'package:dialogue_wise/DTOs/get_contents_request.dart';
import 'package:dialogue_wise/dialoguewise.dart';
import 'package:flutter/material.dart';

class AuthorDetailsPage extends StatelessWidget {
  final String authorName;
  final String authorImage;
  final String authorBiography;

  const AuthorDetailsPage({
    super.key,
    required this.authorName,
    required this.authorImage,
    required this.authorBiography,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(authorName),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(authorImage, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text(
                authorBiography,
                style: const TextStyle(
                  fontSize: 17,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

FutureBuilder<Map> fetchAndDisplayAuthors(String slug) {
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
            var author = data[index];
            var coverUrl = author['cover'].substring(
                2, author['cover'].length - 2); // Varsayılan kapak resmi URL'si

            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AuthorDetailsPage(
                      authorName: author["author_name"] ?? 'Unknown',
                      authorImage: coverUrl,
                      authorBiography:
                          author["biography"] ?? 'No biography available',
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
                              Text(
                                  author["author_name"] ??
                                      'Unknown', // Kitap adı
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              //Text(author["biography"] ?? 'Unknown'), // Yazar adı
                            ],
                          ),
                        ),
                      ],
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

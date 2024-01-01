import 'package:flutter/material.dart';
import 'package:ios_explore_books/routes.dart';
import 'package:ios_explore_books/services/cloud_database/firebase_cloud_users_crud.dart';

class BookGenreSelection extends StatefulWidget {
  const BookGenreSelection({super.key});

  @override
  _BookGenreSelectionState createState() => _BookGenreSelectionState();
}

class _BookGenreSelectionState extends State<BookGenreSelection> {
  // Firestore Database ile iletişim sağlayabilmek için
  final FirebaseCloudStorage _fireBaseCloudStorage = FirebaseCloudStorage();

  //kitap türlerinin listesi
  List<List<String>> groupedGenres = [
    ['ROMAN', 'POLİSİYE'],
    ['ŞİİR', 'ÇOCUK'],
    ['DİNİ', 'HİKAYE'],
    ['PSİKOLOJİ', 'K.GELİŞİM'],
    ['TARİH', 'SAĞLIK']
  ];

  List<String> selectedGenres = []; //seçilen türleri tutan liste

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
        onPressed: () {
          _fireBaseCloudStorage.updateGenre(genre: selectedGenres);
          navigateToNextPage();
        }, //butona tıklandığında bir sonraki sayfaya geçer
        style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius
                  .zero, //buton köşesinin oval olmaması için zero seçildi
            ),
            backgroundColor: Colors.black, //buton rengi
            minimumSize: const Size(60, 40)), //buton genişliği ve yüksekliği
        child: const Text(
          //text özelleştirme
          'İLERİ',
          style: TextStyle(
              color: Colors.white, //yazı rengi
              fontSize: 20 //yazı boyutu
              ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.endFloat, //butonun konumu
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, //dikeyde merkeze hizalama
          crossAxisAlignment: CrossAxisAlignment
              .stretch, //yatayda widget uzunluğunu sabit yapma
          children: [
            const Text('NE TÜR KİTAPLARDAN HOŞLANIRSINIZ?',
                style: TextStyle(
                    fontSize: 20, //yazı boyutu
                    fontFamily: 'Courier', //yazı tipi
                    fontWeight: FontWeight.bold) //yazı kalınlaştırma
                ),
            const SizedBox(
                height: 60), //text widgetı ile butonlar arasındaki mesafe

            // Dinamik olarak türleri oluştur
            for (List<String> genreGroup in groupedGenres)
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceEvenly, //yan yana kutucuklar arasında aralık bırakma
                children: [
                  for (String genre in genreGroup)
                    ElevatedButton(
                      onPressed: () => toggleGenreSelection(
                          genre), //seçilen buton varsa kaldırır,yoksa seçilmesini sağlar
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed) ||
                                  states.contains(MaterialState.selected)) {
                                // Buton tıklandığında (seçildiğinde) rengi
                                return const Color.fromARGB(255, 188, 170, 164);
                              }
                              // Normal durumda buton rengi
                              return const Color(0xFFEFE7C9);
                            },
                          ),
                          fixedSize: MaterialStateProperty.all(const Size(150,
                              30)) //tüm butonların boyutlarının aynı olmasını sağlar
                          ),
                      child: Text(genre,
                          style: const TextStyle(
                              color: Colors.black, //yazı rengi
                              fontSize: 17, //yazı boyutu
                              fontFamily: 'Courier', //yazı tipi
                              fontWeight: FontWeight.bold) //yazı kalınlaştırma
                          ),
                    ),
                  const SizedBox(
                      height:
                          80), //tür butonları arasında dikeyde mesafe bırakma
                ],
              ),
          ],
        ),
      ),
    );
  }

  void toggleGenreSelection(String genre) {
    genre = genre.toLowerCase();
    //widget içindeki durumu değiştirmek için kullanılır
    setState(() {
      //seçilen değer ekliyse listeden çıkarsın
      if (selectedGenres.contains(genre)) {
        selectedGenres.remove(genre);
      }
      //listede yoksa eklesin
      else {
        selectedGenres.add(genre);
      }
    });
  }

  //bir sonraki sayfaya geçmek için kullanılan fonksiyon
  void navigateToNextPage() {
    //yeni bir sayfaya geçiş yapmamızı sağlar
    Navigator.push(
      context,
      //sayfalar arası geçişin animasyonlu bir şekilde geçişini sağlar
      MaterialPageRoute(
        //geçiş yapılan sayfanın nasıl oluşturulacağını belirler
        builder: (context) => SelectedGenrePage(selectedGenres),
      ),
    );
  }
}

//geçiş yapılan sayfanın özellikleri
class SelectedGenrePage extends StatelessWidget {
  final List<String> selectedGenres;

  const SelectedGenrePage(this.selectedGenres, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seçilen Türler'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Seçili Türler : ${selectedGenres.join(", ").toUpperCase()}',
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
          homepageRoute,
          (_) => false,
        ), //butona tıklandığında bir sonraki sayfaya geçer
        style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius
                  .zero, //buton köşesinin oval olmaması için zero seçildi
            ),
            backgroundColor: Colors.black, //buton rengi
            minimumSize: const Size(60, 40)), //buton genişliği ve yüksekliği
        child: const Text(
          //text özelleştirme
          'İLERİ',
          style: TextStyle(
              color: Colors.white, //yazı rengi
              fontSize: 20 //yazı boyutu
              ),
        ),
      ),
    );
  }
}

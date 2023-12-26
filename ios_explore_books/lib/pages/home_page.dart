import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ios_explore_books/pages/book_genre_selection_page.dart';
import 'package:ios_explore_books/routes.dart';
import 'package:ios_explore_books/services/cloud_database/firebase_cloud_storage.dart';
import 'package:ios_explore_books/utilities/dialogs/logout_dialog.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final FirebaseCloudStorage _fireBaseCloudStorage = FirebaseCloudStorage();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late User _user;
  late String _userName;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    _user = _auth.currentUser!;
    try {
      DocumentSnapshot<Map<String, dynamic>> userDoc =
          await _firestore.collection('users').doc(_user.uid).get();

      setState(() {
        _userName = userDoc['fullName'];
      });
    } catch (e) {
      print("Firestore'dan kullanıcı bilgileri alınamadı: $e");
    }
  }

  Future<bool> isGenreEmpty() async {
    final selectedGenre = await _fireBaseCloudStorage.getGenres();
    final result = selectedGenre.isEmpty;
    print(selectedGenre);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isGenreEmpty(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While the Future is still running, show a loading indicator or other widget.
          return const CircularProgressIndicator(); // Replace this with your loading widget.
        } else if (snapshot.hasError) {
          // If there's an error, handle it here.
          return Text('Error: ${snapshot.error}');
        } else {
          // When the Future is complete:
          // Access the result via snapshot.data
          final bool isGenreEmpty = snapshot.data ?? false;

          // Build your widget based on the result.
          if (!isGenreEmpty) {
            return Scaffold(
              appBar: AppBar(
                leading: Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.menu),
                    iconSize: 40, // Menü simgesinin boyutunu ayarlayın
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                ),
                actions: [],
              ),
              drawer: Drawer(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.zero)),
                backgroundColor: const Color(0xFFF6E3FD),
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 220, 60, 0),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF6E3FD), // Drawer arka plan rengi
                    ),
                    child: Column(
                      children: [
                        // Drawer başlığı
                        // UserAccountsDrawerHeader(
                        //   accountName: Text(
                        //     _userName ?? '',
                        //     style: const TextStyle(
                        //       fontFamily: 'Courier',
                        //       fontSize: 20,
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //   ),
                        //   accountEmail: null,
                        //   currentAccountPicture: CircleAvatar(
                        //     backgroundColor: Colors.white,
                        //     child: Text(
                        //       _userName != null ? _userName![0] : '',
                        //       style: const TextStyle(fontSize: 40.0),
                        //     ),
                        //   ),
                        // ),
                        ExpansionTile(
                          title: const Text(
                            'KİTAP TÜRLERİ',
                            style: TextStyle(
                                fontFamily: 'Courier',
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: const Icon(Icons.arrow_drop_down),
                          children: [
                            ListTile(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(70, 0, 0, 0),
                              title: const Text(
                                'Roman',
                                style: TextStyle(
                                  fontFamily: 'Courier',
                                  fontSize: 20,
                                ),
                              ),
                              onTap: () {},
                            ),
                            ListTile(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(70, 0, 0, 0),
                              title: const Text(
                                'Polisiye',
                                style: TextStyle(
                                  fontFamily: 'Courier',
                                  fontSize: 20,
                                ),
                              ),
                              onTap: () {},
                            ),
                            ListTile(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(70, 0, 0, 0),
                              title: const Text(
                                'Şiir',
                                style: TextStyle(
                                  fontFamily: 'Courier',
                                  fontSize: 20,
                                ),
                              ),
                              onTap: () {},
                            ),
                            ListTile(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(70, 0, 0, 0),
                              title: const Text(
                                'Çocuk',
                                style: TextStyle(
                                  fontFamily: 'Courier',
                                  fontSize: 20,
                                ),
                              ),
                              onTap: () {},
                            ),
                            ListTile(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(70, 0, 0, 0),
                              title: const Text(
                                'Dini',
                                style: TextStyle(
                                  fontFamily: 'Courier',
                                  fontSize: 20,
                                ),
                              ),
                              onTap: () {},
                            ),
                            ListTile(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(70, 0, 0, 0),
                              title: const Text(
                                'Hikaye',
                                style: TextStyle(
                                  fontFamily: 'Courier',
                                  fontSize: 20,
                                ),
                              ),
                              onTap: () {},
                            ),
                            ListTile(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(70, 0, 0, 0),
                              title: const Text(
                                'Psikoloji',
                                style: TextStyle(
                                  fontFamily: 'Courier',
                                  fontSize: 20,
                                ),
                              ),
                              onTap: () {},
                            ),
                            ListTile(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(70, 0, 0, 0),
                              title: const Text(
                                'K.Gelişim',
                                style: TextStyle(
                                  fontFamily: 'Courier',
                                  fontSize: 20,
                                ),
                              ),
                              onTap: () {},
                            ),
                            ListTile(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(70, 0, 0, 0),
                              title: const Text(
                                'Tarih',
                                style: TextStyle(
                                  fontFamily: 'Courier',
                                  fontSize: 20,
                                ),
                              ),
                              onTap: () {},
                            ),
                            ListTile(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(70, 0, 0, 0),
                              title: const Text(
                                'Sağlık',
                                style: TextStyle(
                                  fontFamily: 'Courier',
                                  fontSize: 20,
                                ),
                              ),
                              onTap: () {},
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        ListTile(
                          title: const Text(
                            'YAZAR LİSTESİ',
                            style: TextStyle(
                                fontFamily: 'Courier',
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {},
                        ),
                        const SizedBox(height: 20),
                        ListTile(
                          title: const Text(
                            'HAKKIMIZDA',
                            style: TextStyle(
                                fontFamily: 'Courier',
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            // Hakkımızda sayfasına yönlendirme işlemleri eklenecek
                          },
                        ),
                        const SizedBox(height: 20),
                        ListTile(
                          title: const Text(
                            'AYARLAR',
                            style: TextStyle(
                                fontFamily: 'Courier',
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            // Ayarlar sayfasına yönlendirme işlemleri eklenecek
                          },
                        ),
                        const SizedBox(height: 20),
                        ListTile(
                          title: const Text(
                            'ÇIKIŞ YAP',
                            style: TextStyle(
                                fontFamily: 'Courier',
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () async {
                            final shouldLogout =
                                await showLogOutDialog(context);
                            if (shouldLogout) {
                              await FirebaseAuth.instance.signOut();
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                loginPageRoute,
                                (_) => false,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFDCBAE8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                0), //kaydol butonunun köşe ovalliği
                          ),
                          padding: const EdgeInsets.symmetric(
                              //butonun yazı ile arasındaki mesafe
                              vertical: 20, //dikeyde
                              horizontal: 40),
                        ),
                        child: const Text(
                          "YENİ EKLENENLER",
                          style: TextStyle(color: Colors.black, fontSize: 30),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFDCBAE8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                            //kaydol butonunun köşe ovalliği
                          ),
                          padding: const EdgeInsets.symmetric(
                              //butonun yazı ile arasındaki mesafe
                              vertical: 20, //dikeyde
                              horizontal: 45),
                        ),
                        child: const Text(
                          "ÇOK OKUNANLAR",
                          style: TextStyle(color: Colors.black, fontSize: 30),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFDCBAE8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                0), //kaydol butonunun köşe ovalliği
                          ),
                          padding: const EdgeInsets.symmetric(
                              //butonun yazı ile arasındaki mesafe
                              vertical: 20, //dikeyde
                              horizontal: 70),
                        ),
                        child: const Text(
                          "ÖNERİLENLER",
                          style: TextStyle(color: Colors.black, fontSize: 30),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFDCBAE8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                0), //kaydol butonunun köşe ovalliği
                          ),
                          padding: const EdgeInsets.symmetric(
                              //butonun yazı ile arasındaki mesafe
                              vertical: 20, //dikeyde
                              horizontal: 90),
                        ),
                        child: const Text(
                          "FAVORİLER",
                          style: TextStyle(color: Colors.black, fontSize: 30),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return const BookGenreSelection();
          }
        }
      },
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ios_explore_books/routes.dart';
import 'package:ios_explore_books/utilities/dialogs/user_not_found_dialog.dart';
//import 'package:ios_explore_books/services/cloud_database/firebase_cloud_storage.dart';
//import 'package:ios_explore_books/services/provider/auth_service.dart';

class LoginUser extends StatefulWidget {
  const LoginUser({super.key});

  @override
  _LoginUserState createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  final _formKey = GlobalKey<
      FormState>(); // formun durumunu yöneten bir anahtar (key) oluşturur(erişim sağlama,kontrol etme..)
  final TextEditingController _passwordController =
      TextEditingController(); //passwordun girileceği text metnin kontrolünü sağlar
  final TextEditingController _emailController =
      TextEditingController(); //e-mailin girileceği text metnin kontrolünü sağlar

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        //overflow engellemek için
        padding: const EdgeInsets.only(top: 250), //üstten bırakılan mesafe
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10), // her taraftan bırakılan mesafe
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Column(
                    children: [
                      const Text(
                        //E-mail yazısı
                        "E-MAİL",
                        style: TextStyle(
                          //E-mail text widget özelleştirme
                          fontSize: 30, //yazı boyutu
                          fontStyle: FontStyle.italic, //yazıyı italik yapmak
                          fontFamily: 'Courier', //yazı tipi
                        ),
                      ),
                      const SizedBox(
                          height: 5), //text ve textformfield arası mesafe
                      TextFormField(
                        style: const TextStyle(
                          //E-mail textformfield widget özelleştirme
                          fontSize: 20, //yazı boyutu
                          fontStyle: FontStyle.italic, //yazı italik yapma
                          fontFamily: 'Courier', //yazı tipi
                          fontWeight:
                              FontWeight.bold, //input yazısını kalınlaştırmak
                          color: Colors.white, //input yazı rengi
                        ),
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress, //inputun tipi
                        decoration: const InputDecoration(
                          //input kutucuğu özelleştirme
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius
                                .zero), // input kutucuğunun köşeli olmasını sağlar
                          ),
                          filled: true, //kutucuk doldurulması için onay
                          fillColor: Color(
                              0xFFA36464), // input kutucuğunun arka plan rengi
                          contentPadding: EdgeInsets.symmetric(
                            //input kutucuğunun yüksekliği
                            vertical: 15.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30), //textboxlar arasındaki mesafe
                      const Text(
                        //Parola yazısı
                        "PAROLA",
                        style: TextStyle(
                          //Parola text widget özelleştirme
                          fontSize: 30, //yazı boyutu
                          fontStyle: FontStyle.italic, //yazı italik yapma
                          fontFamily: 'Courier', //yazı tipi
                        ),
                      ),
                      const SizedBox(
                          height: 5), //text ve textformfield arası mesafe
                      TextFormField(
                        style: const TextStyle(
                          //textformfield widget özelleştirme
                          fontSize: 20, //yazı boyutu
                          fontStyle: FontStyle.italic, //yazı italik yapma
                          fontFamily: 'Courier', //yazı tipi
                          fontWeight: FontWeight.bold, //yazı kalınlaştırma
                        ),
                        controller: _passwordController,
                        obscureText: true, //parola girişinin içeriği gizlenir
                        decoration: const InputDecoration(
                          //input kutucuğu özelleştirme
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius
                                .zero), //input kutucuğunun köşeli olması sağlanır
                          ),
                          filled: true,
                          fillColor: Color(
                              0xFFA36464), //input kutucuğunun arka plan rengi
                          contentPadding: EdgeInsets.symmetric(
                            //input kutucuğunun yüksekliği
                            vertical: 15.0,
                          ),
                        ),
                      ),
                      const SizedBox(
                          height:
                              60), // parola kutucuğu ve giriş yap butonu arasındaki mesafe
                    ],
                  ),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // yatayda merkeze hizalama
                    children: [
                      ElevatedButton(
                        //giriş yap butonu
                        onPressed: () async {
                          final email = _emailController.text;
                          final password = _passwordController.text;
                          try {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                              email: email,
                              password: password,
                            );
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                bookGenreSelectionRoute, (route) => false);
                          } catch (e) {
                            print(e.toString());
                            showUserNotFoundDialog(
                              context,
                              "Kullanıcı Bulunmadı",
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            //butonu özelleştirme
                            backgroundColor: const Color(
                                0xFFD4A7A7), //giriş yap butonunun arka plan rengi
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20.0), //giriş yap butonunun köşe ovalliği
                            ),
                            padding: const EdgeInsets.symmetric(
                                //butonun yazı ile arasındaki mesafe
                                vertical: 10, //dikeyde
                                horizontal: 30) //yatayda
                            ),
                        child: const Text(
                          'GİRİŞ YAP',
                          style: TextStyle(
                              //text için özelleştirme
                              fontSize: 20, //yazı boyutu
                              fontFamily: 'Courier', //yazı tipi
                              fontWeight: FontWeight.bold, //yazı kalınlaştırma
                              fontStyle: FontStyle.italic, //yazı italik yapma
                              color: Colors.white //yazı rengi
                              ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.end, //textbuttonu yatayda sona taşıma
                    children: [
                      TextButton(
                        onPressed: () {
                          // Şifremi Unuttum butonu için işlemler
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal:
                                  10), //buttonun yazı ile arasındaki mesafe
                        ),
                        child: const Text(
                          //text için özelleştirme
                          'Şifremi Unuttum',
                          style: TextStyle(
                            color: Colors.black, //yazı rengi
                            fontSize: 20, //yazı boyutu
                            fontFamily: 'Courier', //yazı tipi
                            fontWeight: FontWeight.bold, //yazı kalınlaştırma
                            fontStyle: FontStyle.italic, //yazı italik yapma
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                      //kaydol butonu ile textbutton arası mesafe
                      height: 10),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // yatayda merkeze hizalama
                    children: [
                      ElevatedButton(
                        //kaydol butonu
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            registerPageRoute,
                            (_) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          //butonu özelleştirme
                          backgroundColor: const Color(
                              0xFFD4A7A7), //kaydol butonunun arka plan rengi
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20.0), //kaydol butonunun köşe ovalliği
                          ),
                          padding: const EdgeInsets.symmetric(
                              //butonun yazı ile arasındaki mesafe
                              vertical: 10, //dikeyde
                              horizontal: 50), //yatayda
                        ),
                        child: const Text(
                          'KAYDOL',
                          style: TextStyle(
                              //text için özelleştirme
                              fontSize: 20, //yazı boyutu
                              fontFamily: 'Courier', //yazı tipi
                              fontWeight: FontWeight.bold, //yazı kalınlaştırma
                              fontStyle: FontStyle.italic, //yazı italik yapma
                              color: Colors.white //yazı rengi
                              ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // void _getUserData() async {
  //   var userData = await _firestoreService.getUserData();
  //   if (userData != null) {
  //     print('User data: $userData');
  //   } else {
  //     print('Error getting user data.');
  //   }
  // }
}
// Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) =>
//                                       const BookGenreSelection()) //3_kitaptürüseçme sayfasına yönlendirir
//                               );

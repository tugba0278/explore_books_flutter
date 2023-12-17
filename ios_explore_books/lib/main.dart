import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ios_explore_books/pages/home_page.dart';
import 'package:ios_explore_books/pages/register_user_page.dart';
import 'package:ios_explore_books/pages/book_genre_selection_page.dart';
import 'package:ios_explore_books/pages/login_page.dart';
import 'package:ios_explore_books/firebase_options.dart';
import 'package:ios_explore_books/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Explore Books",
    routes: {
      loginPageRoute: (context) => const LoginUser(),
      registerPageRoute: (context) => const RegisterUser(),
      bookGenreSelectionRoute: (context) => const BookGenreSelection(),
      homepageRoute: (context) => const Homepage(),
    },
    home: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user == null) {
              return const LoginUser();
            } else {
              return const Homepage();
            }
          default:
            return const CircularProgressIndicator.adaptive();
        }
      },
    );
  }
}

// class MyForm extends StatefulWidget {
//   const MyForm({super.key});

//   @override
//   _MyFormState createState() => _MyFormState();
// }

// class _MyFormState extends State<MyForm> {
//   final _formKey = GlobalKey<
//       FormState>(); // formun durumunu yöneten bir anahtar (key) oluşturur(erişim sağlama,kontrol etme..)

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         //overflow engellemek için
//         padding: const EdgeInsets.only(top: 250), //üstten bırakılan mesafe
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(10), // her taraftan bırakılan mesafe
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   Column(
//                     //e-mail için column
//                     children: [
//                       const Text(
//                         //E-mail yazısı
//                         "E-MAİL",
//                         style: TextStyle(
//                           //E-mail text widget özelleştirme
//                           fontSize: 30, //yazı boyutu
//                           fontStyle: FontStyle.italic, //yazıyı italik yapmak
//                           fontFamily: 'Courier', //yazı tipi
//                         ),
//                       ),
//                       const SizedBox(
//                           height: 5), //text ve textformfield arası mesafe
//                       TextFormField(
//                         style: const TextStyle(
//                           //E-mail textformfield wdiget özelleştirme
//                           fontSize: 20, //yazı boyutu
//                           fontStyle: FontStyle.italic, //yazı italik yapma
//                           fontFamily: 'Courier', //yazı tipi
//                           fontWeight:
//                               FontWeight.bold, //input yazısını kalınlaştırmak
//                           color: Colors.white, //input yazı rengi
//                         ),
//                         keyboardType: TextInputType.emailAddress, //inputun tipi
//                         decoration: const InputDecoration(
//                           //input kutucuğu özelleştirme
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(Radius
//                                 .zero), // input kutucuğunun köşeli olmasını sağlar
//                           ),
//                           filled: true, //kutucuk doldurulması için onay
//                           fillColor: Color(
//                               0xFFA36464), // input kutucuğunun arka plan rengi
//                           contentPadding: EdgeInsets.symmetric(
//                             //input kutucuğunun yüksekliği
//                             vertical: 15.0,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 30), //textboxlar arasındaki mesafe
//                   Column(
//                     //parola için column
//                     children: [
//                       const Text(
//                         //Parola yazısı
//                         "PAROLA",
//                         style: TextStyle(
//                           //Parola text widget özelleştirme
//                           fontSize: 30, //yazı boyutu
//                           fontStyle: FontStyle.italic, //yazı italik yapma
//                           fontFamily: 'Courier', //yazı tipi
//                         ),
//                       ),
//                       const SizedBox(
//                           height: 5), //text ve textformfield arası mesafe
//                       TextFormField(
//                         style: const TextStyle(
//                           //textformfield widget özelleştirme
//                           fontSize: 20, //yazı boyutu
//                           fontStyle: FontStyle.italic, //yazı italik yapma
//                           fontFamily: 'Courier', //yazı tipi
//                           fontWeight: FontWeight.bold, //yazı kalınlaştırma
//                         ),
//                         obscureText: true, //parola girişinin içeriği gizlenir
//                         decoration: const InputDecoration(
//                           //input kutucuğu özelleştirme
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(Radius
//                                 .zero), //input kutucuğunun köşeli olması sağlanır
//                           ),
//                           filled: true,
//                           fillColor: Color(
//                               0xFFA36464), //input kutucuğunun arka plan rengi
//                           contentPadding: EdgeInsets.symmetric(
//                             //input kutucuğunun yüksekliği
//                             vertical: 15.0,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                       height:
//                           60), // parola kutucuğu ve giriş yap butonu arasındaki mesafe
//                   Row(
//                     mainAxisAlignment:
//                         MainAxisAlignment.center, // yatayda merkeze hizalama
//                     children: [
//                       ElevatedButton(
//                         //giriş yap butonu
//                         onPressed: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) =>
//                                       const BookGenreSelection()) //3_kitaptürüseçme sayfasına yönlendirir
//                               );
//                         },
//                         style: ElevatedButton.styleFrom(
//                             //butonu özelleştirme
//                             backgroundColor: const Color(
//                                 0xFFD4A7A7), //giriş yap butonunun arka plan rengi
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(
//                                   20.0), //giriş yap butonunun köşe ovalliği
//                             ),
//                             padding: const EdgeInsets.symmetric(
//                                 //butonun yazı ile arasındaki mesafe
//                                 vertical: 10, //dikeyde
//                                 horizontal: 30) //yatayda
//                             ),
//                         child: const Text(
//                           'GİRİŞ YAP',
//                           style: TextStyle(
//                               //text için özelleştirme
//                               fontSize: 20, //yazı boyutu
//                               fontFamily: 'Courier', //yazı tipi
//                               fontWeight: FontWeight.bold, //yazı kalınlaştırma
//                               fontStyle: FontStyle.italic, //yazı italik yapma
//                               color: Colors.white //yazı rengi
//                               ),
//                         ),
//                       ),
//                     ],
//                   ),

//                   Row(
//                     mainAxisAlignment:
//                         MainAxisAlignment.end, //textbuttonu yatayda sona taşıma
//                     children: [
//                       TextButton(
//                         onPressed: () {
//                           // Şifremi Unuttum butonu için işlemler
//                         },
//                         style: TextButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 10,
//                               horizontal:
//                                   10), //buttonun yazı ile arasındaki mesafe
//                         ),
//                         child: const Text(
//                           //text için özelleştirme
//                           'Şifremi Unuttum',
//                           style: TextStyle(
//                             color: Colors.black, //yazı rengi
//                             fontSize: 20, //yazı boyutu
//                             fontFamily: 'Courier', //yazı tipi
//                             fontWeight: FontWeight.bold, //yazı kalınlaştırma
//                             fontStyle: FontStyle.italic, //yazı italik yapma
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                       //kaydol butonu ile textbutton arası mesafe
//                       height: 10),
//                   Column(
//                     mainAxisAlignment:
//                         MainAxisAlignment.center, // yatayda merkeze hizalama
//                     children: [
//                       ElevatedButton(
//                         // E-devlet ile Giriş button
//                         onPressed: () {
//                           // Add your logic for E-devlet ile Giriş button
//                         },
//                         style: ElevatedButton.styleFrom(
//                           // button özelleştirmeleri
//                           backgroundColor:
//                               const Color(0xFFD4A7A7), // arka plan rengi
//                           shape: RoundedRectangleBorder(
//                             borderRadius:
//                                 BorderRadius.circular(20.0), // köşe ovalleği
//                           ),
//                           padding: const EdgeInsets.symmetric(
//                             vertical: 10,
//                             horizontal: 30,
//                           ),
//                         ),
//                         child: const Text(
//                           'E-DEVLET İLE GİRİŞ',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontFamily: 'Courier',
//                             fontWeight: FontWeight.bold,
//                             fontStyle: FontStyle.italic,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 10), // Buttonlar arası mesafe
//                       ElevatedButton(
//                         // Kaydol button
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const MyForm2(),
//                             ),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFFD4A7A7),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20.0),
//                           ),
//                           padding: const EdgeInsets.symmetric(
//                             vertical: 10,
//                             horizontal: 50,
//                           ),
//                         ),
//                         child: const Text(
//                           'KAYDOL',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontFamily: 'Courier',
//                             fontWeight: FontWeight.bold,
//                             fontStyle: FontStyle.italic,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// //  child: ElevatedButton(
// //                       onPressed: () {
// //                         if (_formKey.currentState!.validate()) {
// //                           // Form doğrulandıysa burada yapılacak işlemler
// //                           showDialog(
// //                             //fonksiyon
// //                             context: context,
// //                             builder: (context) {
// //                               return AlertDialog(
// //                                 //bilgiler doğrulandığında gösterilmesi için kullanılan widget
// //                                 title: const Text(
// //                                   'Bilgileriniz',
// //                                   style: TextStyle(
// //                                       //text özelleştirme
// //                                       fontSize: 25, //yazı boyutu
// //                                       fontStyle:
// //                                           FontStyle.italic, //yazı itailk yapma
// //                                       fontFamily: 'Courier', //yazı tipi
// //                                       fontWeight:
// //                                           FontWeight.bold //yazı kalınlaştırma
// //                                       ),
// //                                 ),
// //                                 content: Text(
// //                                   //görüntülenecek text
// //                                   'Ad ve Soyad : ${_fullNameController.text}\n' //girilen tam adı getirir
// //                                   'Telefon Numarası : ${_phoneNumberController.text}\n' //girilen numarayı getirir
// //                                   'Parola : ${_passwordController.text}\n' //girilen şifreyi getirir
// //                                   'E-posta : ${_emailController.text}', //girilen maili getirir
// //                                 ),
// //                                 actions: [
// //                                   //sağdaki buton
// //                                   TextButton(
// //                                     onPressed: () {
// //                                       //butona tıklanınca ilk sayfaya gitsin(giriş yap sayfası)
// //                                       Navigator.of(context)
// //                                           .popUntil((route) => route.isFirst);
// //                                     },
// //                                     style: ButtonStyle(
// //                                         backgroundColor: //buton rengi
// //                                             MaterialStateProperty.all(
// //                                                 const Color(0xFFD4A7A7))),
// //                                     child: const Text('Tamam',
// //                                         style: TextStyle(
// //                                             //text özelleştirme
// //                                             color: Colors.white, //yazı rengi
// //                                             fontSize: 25, //yazı boyutu
// //                                             fontStyle: FontStyle
// //                                                 .italic, //yazı italik yapma
// //                                             fontFamily: 'Courier', //yazı tipi
// //                                             fontWeight: FontWeight
// //                                                 .bold //yazı kalınlaştırma
// //                                             )),
// //                                   ),
// //                                 ],
// //                               );
// //                             },
// //                           );
// //                         }
// //                       },
// //                       style: ElevatedButton.styleFrom(
// //                         backgroundColor:
// //                             const Color(0xFFD4A7A7), //kaydol butonu rengi
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(
// //                               20.0), //kaydol butonu kenarlarının ovalliği
// //                         ),
// //                         padding: const EdgeInsets.symmetric(
// //                             //buton ve kaydol yazısı arasındaki dikey ve yatay mesafe
// //                             vertical: 10,
// //                             horizontal: 30),
// //                       ),
// //                       child: const Text(
// //                         'KAYDOL',
// //                         style: TextStyle(
// //                             //text özelleştirme
// //                             fontSize: 25, //yazı boyutu
// //                             fontFamily: 'Courier', //yazı tipi
// //                             fontWeight: FontWeight.bold, //yazı kalınlaştırma
// //                             fontStyle: FontStyle.italic, //yazı italik yapma
// //                             color: Colors.white //yazı rengi
// //                             ),
// //                       ),
// //                     ),
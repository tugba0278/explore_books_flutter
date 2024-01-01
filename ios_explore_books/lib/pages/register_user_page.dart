import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ios_explore_books/routes.dart';
import 'package:ios_explore_books/services/cloud_database/firebase_cloud_users_crud.dart';

import 'package:ios_explore_books/user_auth/firebase_auth_implementations/firebase_auth.services.dart';
import 'package:ios_explore_books/utilities/dialogs/email_already_in_use_dialog.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({super.key});
  @override
  _MyFormState createState() {
    return _MyFormState();
  }
}

class _MyFormState extends State<RegisterUser> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final _formKey =
      GlobalKey<FormState>(); //doğrulama işlemleri için key oluşturur
  final TextEditingController _fullNameController =
      TextEditingController(); //tam adın girileceği text metnin kontrolünü sağlar
  final TextEditingController _phoneNumberController =
      TextEditingController(); //numaranın girileceği text metnin kontrolünü sağlar
  final TextEditingController _passwordController =
      TextEditingController(); //passwordun girileceği text metnin kontrolünü sağlar
  final TextEditingController _emailController =
      TextEditingController(); //e-mailin girileceği text metnin kontrolünü sağlar
  final FirebaseCloudStorage _fireBaseCloudStorage = FirebaseCloudStorage();

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        //overflow engellenir
        padding: const EdgeInsets.only(top: 130), //üstten bırakılan mesafe
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0), //her taraftan bırakılan mesafe
            child: Form(
              //form widgeti
              key: _formKey, //kontrolü sağlamak için anahtar
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, //dikeyde merkeze hizalama
                children: [
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.center, //yatayda merkeze hizalama
                    children: [
                      const Text(
                        "AD SOYAD",
                        style: TextStyle(
                            //text özelleştirme
                            fontSize: 30, //yazı boyutu
                            fontStyle: FontStyle.italic, //yazı italik yapma
                            fontFamily: 'Courier' //yazı tipi
                            ),
                      ),
                      const SizedBox(
                          height: 5), //text ve textformfield arasındaki mesafe
                      TextFormField(
                        style: const TextStyle(
                            //textformfield özelleştirme
                            fontSize: 20, //yazı boyutu
                            fontStyle: FontStyle.italic, //yazı italik yapma
                            fontFamily: 'Courier', //yazı tipi
                            fontWeight: FontWeight.bold, //yazı kalınlaştırma
                            color: Colors.white //yazı rengi
                            ),
                        controller:
                            _fullNameController, //tam ad içeriği kontrolü
                        decoration: const InputDecoration(
                          //input kutucuğu özelleştirme
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.zero), //kutucuk kenarları ovallik 0
                          ),
                          filled: true,
                          fillColor: Color(0xFFA36464), //kutucuk rengi
                          contentPadding: EdgeInsets.symmetric(
                            //yazı ve kutucuk arasındaki dikey mesafe
                            vertical: 10.0,
                          ),
                        ),
                        validator: (value) {
                          //tam ad input girilip girilmediğini kontrol eder
                          if (value == null || value.isEmpty) {
                            return 'Lütfen adınızı ve soyadınızı girin'; //tam ad girilmediyse bu mesaj iletilir
                          }
                          print(value);
                          return null; //tam ad geçerli
                        },
                      ),
                      const SizedBox(
                          height:
                              40), //1. kutucuk ve 2. text yazısı arasındaki mesafe
                      const Text(
                        "TELEFON NUMARASI",
                        style: TextStyle(
                            //text özelleştirme
                            fontSize: 30, //yazı boyutu
                            fontStyle: FontStyle.italic, //yazı italik yapma
                            fontFamily: 'Courier' //yazı tipi
                            ),
                      ),
                      const SizedBox(
                          height:
                              5), //2. text ve 2. textformfield arasındaki mesafe
                      TextFormField(
                        style: const TextStyle(
                            //textformfield özelleştirme
                            fontSize: 20, //yazı boyutu
                            fontStyle: FontStyle.italic, //yazı italik yapma
                            fontFamily: 'Courier', //yazı tipi
                            fontWeight: FontWeight.bold, //yazı kalınlaştırma
                            color: Colors.white //yazı rengi
                            ),
                        controller:
                            _phoneNumberController, //numara içeriği kontrolü
                        keyboardType: TextInputType.phone, //input tipi
                        decoration: const InputDecoration(
                          //input kutucuğu özelleştirme
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.zero), //input kutucuğu ovalliği 0
                          ),
                          filled: true,
                          fillColor: Color(0xFFA36464), //kutucuk rengi
                          contentPadding: EdgeInsets.symmetric(
                            //input ve kutucuk arasındaki mesafe
                            vertical: 10.0,
                          ),
                        ),
                        validator: (value) {
                          //numara input girilip girilmediğini kontrol eder
                          if (value == null || value.isEmpty) {
                            return 'Lütfen telefon numaranızı girin'; //numara girilmediyse bu mesaj iletilir
                          }
                          return null; //numara geçerli
                        },
                      ),
                      const SizedBox(
                          height: 40), //2. kutucuk ve 3. text arasındaki mesafe
                      const Text(
                        "E-MAİL",
                        style: TextStyle(
                            //text özelleştirme
                            fontSize: 30, //yazı boyutu
                            fontStyle: FontStyle.italic, //yazı italik yapma
                            fontFamily: 'Courier' //yazı tipi
                            ),
                      ),
                      const SizedBox(
                          height: 5), //3. kutucuk ve 3. text arasındaki mesafe
                      TextFormField(
                        style: const TextStyle(
                            //textformfield özelleştirme
                            fontSize: 20, //yazı boyutu
                            fontStyle: FontStyle.italic, //yazı italik yapma
                            fontFamily: 'Courier', //yazı tipi
                            fontWeight: FontWeight.bold, //yazıkalınlaştırma
                            color: Colors.white //yazı rengi
                            ),
                        controller: _emailController, //e-mail içeriği kontrolü
                        keyboardType: TextInputType.emailAddress, //input tipi
                        decoration: const InputDecoration(
                          //input kutucuğu özelleştirme
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.zero), //kutucuk kenarları ovalliği 0
                          ),
                          filled: true,
                          fillColor: Color(0xFFA36464), //kutucuk rengi
                          contentPadding: EdgeInsets.symmetric(
                            //input ve kutucuk arasındaki dikey mesafe
                            vertical: 10.0,
                          ),
                        ),
                        validator: (value) {
                          //e-mail input girilip girilmediğini kontrol eder
                          if (value == null || value.isEmpty) {
                            return 'Lütfen e-posta adresinizi girin'; //e-mail girilmediyse bu mesaj iletilir
                          } else if (!value.contains('@')) {
                            return 'Geçerli bir e-posta adresi girin'; //@ işaretini içermezse bu mesaj iletilir
                          }
                          return null; //e-mail geçerli
                        },
                      ),
                      const SizedBox(
                          height: 40), //3. kutucuk ve 4. text arasındaki mesafe
                      const Text(
                        "PAROLA",
                        style: TextStyle(
                          //text özelleştirme
                          fontSize: 30, //yazı boyutu
                          fontStyle: FontStyle.italic, //yazı itailk yapma
                          fontFamily: 'Courier', //yazı tipi
                        ),
                      ),
                      const SizedBox(
                          height: 5), //4. kutucuk ve 4. text arasındaki mesafe
                      TextFormField(
                        style: const TextStyle(
                            //textformfield özelleştirme
                            fontSize: 20, //yazı boyutu
                            fontStyle: FontStyle.italic, //yazı italik yapma
                            fontFamily: 'Courier', //yazı tipi
                            fontWeight: FontWeight.bold //yazı kalınlaştırma
                            ),
                        controller:
                            _passwordController, //parola içeriği kontrolü
                        obscureText: true, //parola içeriği gizleme(*)
                        decoration: const InputDecoration(
                          //input kutucuğu özelleştirme
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.zero), //kutucuk kenarları ovalliği 0
                          ),
                          filled: true,
                          fillColor: Color(0xFFA36464), //kutucuk rengi
                          contentPadding: EdgeInsets.symmetric(
                            //text ve kutucuk arasındaki dikey mesafe
                            vertical: 10.0,
                          ),
                        ),
                        validator: (value) {
                          //parola input girilip girilmediğini kontrol eder
                          if (value == null || value.isEmpty) {
                            return 'Lütfen parolanızı girin'; //parola girilmediyse bu mesaj iletilir
                          }
                          return null; //parola geçerli
                        },
                      ),
                      const SizedBox(
                          height: 50), //son kutucuk ve buton arasındaki mesafe
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: GestureDetector(
                          onTap: _signUp,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFD4A7A7),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                                //butonun yazı ile arasındaki mesafe
                                vertical: 5, //dikeyde
                                horizontal: 40), //yatayda
                            child: const Text(
                              'KAYDOL',
                              style: TextStyle(
                                  //text özelleştirme
                                  fontSize: 25, //yazı boyutu
                                  fontFamily: 'Courier', //yazı tipi
                                  fontWeight:
                                      FontWeight.bold, //yazı kalınlaştırma
                                  fontStyle:
                                      FontStyle.italic, //yazı italik yapma
                                  color: Colors.white //yazı rengi
                                  ),
                            ),
                          ))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;

      try {
        User? user = await _auth.signUpWithEmailAndPassword(email, password);
        if (user != null) {
          print("user is succesfully created");
          print(user.toString());
          final userDocument = _fireBaseCloudStorage.createNewUser(
            ownerUserId: user.uid,
            fullName: _fullNameController.text,
            phoneNumber: _phoneNumberController.text,
          );
          // ignore: use_build_context_synchronously
          Navigator.pushNamedAndRemoveUntil(
              context, loginPageRoute, (route) => false);
        }
      } catch (e) {
        if (e is FirebaseAuthException) {
          // Check the error code to determine the specific error
          if (e.code == 'email-already-in-use') {
            // Handle the case where the email address is already in use
            print('The email address is already in use by another account.');
            // ignore: use_build_context_synchronously
            showEmailAlreadyInUseDialog(context,
                'The email address is already in use by another account.');
            // You might want to inform the user or take appropriate action.
          } else {
            // Handle other FirebaseAuthException errors
            print('Firebase Authentication Error: ${e.message}');
          }
        } else {
          // Handle other non-FirebaseAuthException errors
          print('Error: $e');
        }
        return null;
      }
    }
  }
}

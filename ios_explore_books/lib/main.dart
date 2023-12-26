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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ios_explore_books/pages/about.dart';
import 'package:ios_explore_books/pages/author_list_page.dart';
import 'package:ios_explore_books/services/cms/author_list.dart';
import 'package:ios_explore_books/pages/child_books.dart';
import 'package:ios_explore_books/pages/poem_books.dart';
import 'package:ios_explore_books/pages/polisiye_books.dart';
import 'package:ios_explore_books/pages/religious_books.dart';
import 'package:ios_explore_books/pages/home_page.dart';
import 'package:ios_explore_books/pages/register_user_page.dart';
import 'package:ios_explore_books/pages/book_genre_selection_page.dart';
import 'package:ios_explore_books/pages/login_page.dart';
import 'package:ios_explore_books/firebase_options.dart';
import 'package:ios_explore_books/pages/roman_books.dart';
import 'package:ios_explore_books/pages/settings.dart';
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
      authorListRoute: (context) => const AuthorList(),
      aboutRoute: (context) => const About(),
      settingsRoute: (context) => const SettingsPage(),
      romanBooksRoute: (context) => const RomanBooks(),
      polisiyeBooksRoute: (context) => const PolisiyeBooks(),
      poemBooksRoute: (context) => const PoemBooks(),
      childBooksRoute: (context) => const ChildBooks(),
      religiousBooksRoute: (context) => const ReligiousBooks(),
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

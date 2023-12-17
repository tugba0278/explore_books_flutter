import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ios_explore_books/enum/menu_action.dart';
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

  Future<bool> isGenreNotEmpty() async {
    final selectedGenre = await _fireBaseCloudStorage.getGenres();

    if (selectedGenre.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isGenreNotEmpty(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While the Future is still running, show a loading indicator or other widget.
          return CircularProgressIndicator(); // Replace this with your loading widget.
        } else if (snapshot.hasError) {
          // If there's an error, handle it here.
          return Text('Error: ${snapshot.error}');
        } else {
          // When the Future is complete:
          // Access the result via snapshot.data
          final bool isGenreNotEmpty = snapshot.data ?? false;

          // Build your widget based on the result.
          if (isGenreNotEmpty) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Hoş Geldiniz, efenim!"),
                actions: [
                  PopupMenuButton<MenuAction>(
                    onSelected: (value) async {
                      switch (value) {
                        case MenuAction.logout:
                          final shouldLogout = await showLogOutDialog(context);
                          if (shouldLogout) {
                            await FirebaseAuth.instance.signOut();
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              loginPageRoute,
                              (_) => false,
                            );
                          }
                          break;
                      }
                    },
                    itemBuilder: (context) {
                      return const [
                        PopupMenuItem<MenuAction>(
                          value: MenuAction.logout, // value is what you see/get
                          child: Text("Log Out"), // child is what the user sees
                        ),
                      ];
                    },
                  )
                ],
              ),
            );
          } else {
            // Return a different widget or handle the case where isGenreEmpty is false.
            return const BookGenreSelection();
          }
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ios_explore_books/utilities/dialogs/generic_dialog.dart';

Future<bool> showLogOutDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: "Çıkış",
    content: "Çıkış yapmak istiyor musunuz?",
    optionsBuilder: () => {
      "İptal": false,
      "Çıkış Yap": true,
    },
  ).then(
    (value) => value ?? false,
  );
}

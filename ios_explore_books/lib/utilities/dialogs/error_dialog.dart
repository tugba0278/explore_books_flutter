import 'package:flutter/material.dart';
import 'package:ios_explore_books/utilities/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(BuildContext context, String text) {
  return showGenericDialog<void>(
    context: context,
    title: "Hata Oluştu",
    content: text,
    optionsBuilder: () => {
      // an inline function that returns a map/dict
      "Tamam": null,
    },
  );
}

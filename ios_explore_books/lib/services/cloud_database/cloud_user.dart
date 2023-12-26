import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ios_explore_books/services/cloud_database/cloud_storage_constants.dart';

class CloudUser {
  final String fullName;
  final String phoneNumber;
  final String documentId;
  final String ownerUserId;
  final List<String> genre;

  CloudUser({
    required this.fullName,
    required this.phoneNumber,
    required this.documentId,
    required this.ownerUserId,
    required this.genre,
  });

  CloudUser.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        ownerUserId = snapshot.data()[ownerUserIdFieldName],
        fullName = snapshot.data()[fullNameFieldName],
        phoneNumber = snapshot.data()[phoneNumberFieldName],
        genre = (snapshot.data()[genreFieldName] as List<dynamic>?)
                ?.map((element) => element as String)
                .toList() ??
            [];
}

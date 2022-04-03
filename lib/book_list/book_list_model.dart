import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../domain/book.dart';

class BookListModel extends ChangeNotifier {
  BookListModel() {
    print("こんにちは7");
  }

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('books').snapshots();

  List<Book>? books;

  void test() {
    print("こんにちは6");
  }

  void fetchBookList() async {
    print("こんにちは1");

    final snap = await FirebaseFirestore.instance.collection('books').get();
    final docs = snap.docs;
    print(docs.length);

    _usersStream.listen((QuerySnapshot snapshot) {
      print("こんにちは2");
      print(snapshot.docChanges.length);
      final List<Book> books = snapshot.docs.map((DocumentSnapshot document) {
        print("こんにちは3");
        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
        final String title = data['title'];
        final String author = data['author'];
        return Book(title, author);
      }).toList();
      this.books = books;
      notifyListeners();
    });
  }
}

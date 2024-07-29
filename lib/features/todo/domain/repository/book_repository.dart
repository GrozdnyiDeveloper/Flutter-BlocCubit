import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_bloccubit/features/todo/domain/entity/book.dart';

class BookRepository {
  final libraryDb = Hive.box("library_db");
  Box<dynamic> get getLibrary => libraryDb;

  Iterable getBooks() {
    return libraryDb.values;
  }

  Book getBook(int index) {
    return libraryDb.getAt(index);
  }

  int getAmount() {
    return libraryDb.length;
  }

  void addBook(Book book) {
    libraryDb.add(book);
  }

  void updateBook(int index, Book book) {
    libraryDb.putAt(index, book);
  }

  void deleteBook(int index) {
    libraryDb.deleteAt(index);
  }

  void deleteAll() {
    libraryDb.deleteAll(libraryDb.keys);
  }
}
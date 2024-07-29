import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:todo_bloccubit/features/todo/domain/entity/book.dart';
import 'package:todo_bloccubit/features/todo/domain/repository/book_repository.dart';

enum LoadingState{
  initial,
  loading,
  success,
  error,
}

class BookController with ChangeNotifier {
  BookRepository _bookRepository = BookRepository();
  BookRepository get getRepository => _bookRepository;

  int _countUnfinished = 0;
  int get getCountUnfinished => _countUnfinished;

  LoadingState _state = LoadingState.initial;
  LoadingState get getState => _state;

  String _lastError = "";
  String get getError => _lastError;

  int id = 0;
  
  List<String> _filter = [""];
  List<String> get getFilter => _filter;

  void init() {
    try {
      _state = LoadingState.loading;
      Future.delayed(const Duration(seconds: 2));
      _countUnfinished = _bookRepository.getBooks().where((element) => !element.isCheck).length;
      _state = LoadingState.success;    
    } catch (e) {
      _lastError = e.toString();
      log(e.toString());
      _state = LoadingState.error;
    } 
    notifyListeners();
  }

  void onChanged(bool isCheck, int index){
    try {
      _state = LoadingState.loading;
      _bookRepository.getBook(index).isCheck = isCheck;
      _countUnfinished = _bookRepository.getBooks().where((element) => !element.isCheck).length;
      _state = LoadingState.success;
    } catch (e) {
      _lastError = e.toString();
      log(e.toString());
      _state = LoadingState.error;
    } 
    notifyListeners();
  }

  Iterable<dynamic> getFilteredBooks() {
    var books =_bookRepository.getBooks();
    try {
      _state = LoadingState.loading;
      for (String f in _filter) {
        books = books.where((book) => book.categories.contains(f));
      }
      _state = LoadingState.success;
    } catch (e) {
      _lastError = e.toString();
      log(e.toString());
      _state = LoadingState.error;
    } 
    return books;
  }

  void addBook(Book book){
    try {
      _state = LoadingState.loading;
      _bookRepository.addBook(book);
      _countUnfinished = _bookRepository.getBooks().where((element) => !element.isCheck).length;
      _state = LoadingState.success;
    } catch (e) {
      _lastError = e.toString();
      log(e.toString());
      _state = LoadingState.error;
    } 
    notifyListeners();
  }

  void updateBook(int index, Book book){
    try {
      _state = LoadingState.loading;
      _bookRepository.updateBook(index, book);
      _countUnfinished = _bookRepository.getBooks().where((element) => !element.isCheck).length;
      _state = LoadingState.success;
    } catch (e) {
      _lastError = e.toString();
      log(e.toString());
      _state = LoadingState.error;
    } 
    notifyListeners();
  }

  void deleteBook(int index){
    try {
      _state = LoadingState.loading;
      _bookRepository.deleteBook(index);
      _countUnfinished = _bookRepository.getBooks().where((element) => !element.isCheck).length;
      _state = LoadingState.success;
    } catch (e) {
      _lastError = e.toString();
      log(e.toString());
      _state = LoadingState.error;
    } 
    notifyListeners();
  }

  void deleteAll() {
    try {
      _state = LoadingState.loading;
      _bookRepository.deleteAll();
      _countUnfinished = _bookRepository.getBooks().where((element) => !element.isCheck).length;
      _state = LoadingState.success;
    } catch (e) {
      _lastError = e.toString();
      log(e.toString());
      _state = LoadingState.error;
    } 
    notifyListeners();
  }

  void addFilter(String f) {
    _filter.add(f);
    notifyListeners();
  }

  void removeFilter(String f) {
    _filter.remove(f);
    notifyListeners();
  }
}
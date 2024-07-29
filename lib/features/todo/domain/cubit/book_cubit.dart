import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_bloccubit/features/todo/domain/entity/book.dart';
import 'package:todo_bloccubit/features/todo/domain/repository/book_repository.dart';

part 'book_state.dart';

class BookCubit extends Cubit<BookState> {
  BookCubit() : super(BookInitial());

  BookRepository _bookRepository = BookRepository();
  BookRepository get getRepository => _bookRepository;

  int _countUnfinished = 0;
  int get getCountUnfinished => _countUnfinished;

  String _lastError = "";
  String get getError => _lastError;

  int id = 0;
  
  List<String> _filter = [""];
  List<String> get getFilter => _filter;

  void init() {
    try {
      emit(BookLoading());
      Future.delayed(const Duration(seconds: 2));
      _countUnfinished = _bookRepository.getBooks().where((element) => !element.isCheck).length;
      emit(BookSuccess());  
    } catch (e) {
      _lastError = e.toString();
      log(e.toString());
      emit(BookError());  
    } 
  }

  void onChanged(bool isCheck, int index){
    try {
      emit(BookLoading());
      _bookRepository.getBook(index).isCheck = isCheck;
      _countUnfinished = _bookRepository.getBooks().where((element) => !element.isCheck).length;
      emit(BookSuccess()); 
    } catch (e) {
      _lastError = e.toString();
      log(e.toString());
      emit(BookError());  
    } 
  }

  Iterable<dynamic> getFilteredBooks() {
    var books =_bookRepository.getBooks();
    try {
      emit(BookLoading());
      for (String f in _filter) {
        books = books.where((book) => book.categories.contains(f));
      }
      emit(BookSuccess()); 
    } catch (e) {
      _lastError = e.toString();
      log(e.toString());
      emit(BookError());  
    } 
    return books;
  }

  void addBook(Book book){
    try {
      emit(BookLoading());
      _bookRepository.addBook(book);
      _countUnfinished = _bookRepository.getBooks().where((element) => !element.isCheck).length;
      emit(BookSuccess()); 
    } catch (e) {
      _lastError = e.toString();
      log(e.toString());
      emit(BookError());  
    } 
  }

  void updateBook(int index, Book book){
    try {
      emit(BookLoading());
      _bookRepository.updateBook(index, book);
      _countUnfinished = _bookRepository.getBooks().where((element) => !element.isCheck).length;
      emit(BookSuccess()); 
    } catch (e) {
      _lastError = e.toString();
      log(e.toString());
      emit(BookError());  
    } 
  }

  void deleteBook(int index){
    try {
      emit(BookLoading());
      _bookRepository.deleteBook(index);
      _countUnfinished = _bookRepository.getBooks().where((element) => !element.isCheck).length;
      emit(BookSuccess()); 
    } catch (e) {
      _lastError = e.toString();
      log(e.toString());
      emit(BookError());  
    } 
  }

  void deleteAll() {
    try {
      emit(BookLoading());
      _bookRepository.deleteAll();
      _countUnfinished = _bookRepository.getBooks().where((element) => !element.isCheck).length;
      emit(BookSuccess()); 
    } catch (e) {
      _lastError = e.toString();
      log(e.toString());
      emit(BookError());  
    } 
  }

  void addFilter(String f) {
    _filter.add(f);
  }

  void removeFilter(String f) {
    _filter.remove(f);
  }
}

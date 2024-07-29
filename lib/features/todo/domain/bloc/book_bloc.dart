import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:todo_bloccubit/features/todo/domain/entity/book.dart';
import 'package:todo_bloccubit/features/todo/domain/repository/book_repository.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookBlocState> {
  BookRepository bookRepository = BookRepository();
  int id = 0;
  int countUnfinished = 0;

  BookBloc() : super(BookInitial()) {
    on<OnLoading>((event, emit) {
      try {
        countUnfinished = bookRepository.getBooks().where((element) => !element.isCheck).length;
        emit(BookSuccess());
      } catch (e) {
        log(e.toString());
        emit(BookError(error: e.toString()));  
      } 
    });

    on<OnChanged>((event, emit) {
      bookRepository.getBook(event.index).isCheck = event.isCheck;
      countUnfinished = bookRepository.getBooks().where((element) => !element.isCheck).length;
      emit(BookSuccess());
    });
    
    on<OnAddBook>((event, emit) {
      try {
        bookRepository.addBook(event.book);
        countUnfinished = bookRepository.getBooks().where((element) => !element.isCheck).length;
        emit(BookSuccess());
      } catch (e) {
        log(e.toString());
        emit(BookError(error: e.toString()));  
      } 
    });

    on<OnEditBook>((event, emit) {
      try {
        bookRepository.updateBook(id, event.book);
        countUnfinished = bookRepository.getBooks().where((element) => !element.isCheck).length;
        emit(BookSuccess());
      } catch (e) {
        log(e.toString());
        emit(BookError(error: e.toString()));  
      } 
    });

    on<OnDeleteBook>((event, emit) {
      try {
        bookRepository.deleteBook(event.id);
        countUnfinished = bookRepository.getBooks().where((element) => !element.isCheck).length;
        emit(BookSuccess());
      } catch (e) {
        log(e.toString());
        emit(BookError(error: e.toString()));  
      } 
    });
  }
}

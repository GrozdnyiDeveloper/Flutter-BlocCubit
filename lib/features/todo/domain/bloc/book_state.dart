part of 'book_bloc.dart';

sealed class BookBlocState {}

class BookInitial extends BookBlocState {}

class BookSuccess extends BookBlocState {}

class BookError extends BookBlocState {
  final String error;
  
  BookError({required this.error}): super();
}

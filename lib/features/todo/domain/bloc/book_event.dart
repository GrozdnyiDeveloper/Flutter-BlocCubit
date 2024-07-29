part of 'book_bloc.dart';

@immutable
sealed class BookEvent {}

class OnLoading extends BookEvent {}

class OnChanged extends BookEvent {
  final bool isCheck;
  final int index;

  OnChanged({required this.index, required this.isCheck});
}

class OnAddBook extends BookEvent {
  final Book book;

  OnAddBook({required this.book});
}

class OnSelectBook extends BookEvent {
  final int id;

  OnSelectBook({required this.id});
}

class OnEditBook extends BookEvent {
  final Book book;

  OnEditBook({required this.book});
}

class OnDeleteBook extends BookEvent {
  final int id;

  OnDeleteBook({required this.id});
}

class OnErrorBook extends BookEvent {}
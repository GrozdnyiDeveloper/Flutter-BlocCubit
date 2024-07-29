import 'package:hive/hive.dart';

part '../adapter/book.g.dart';

@HiveType(typeId: 0)
class Book {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String author;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final List<String> categories;
  @HiveField(4)
  bool isCheck;

  Book({
    required this.title, 
    required this.author, 
    this.description = "",
    required this.categories,
    this.isCheck = false
  });
}
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_bloccubit/features/todo/domain/entity/book.dart';
import 'package:todo_bloccubit/features/app.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(BookAdapter());
  await Hive.openBox("library_db");
  runApp(const App());
}
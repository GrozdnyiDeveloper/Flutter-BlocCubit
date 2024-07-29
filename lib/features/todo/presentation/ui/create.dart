import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_bloccubit/features/todo/domain/cubit/book_cubit.dart';
import 'package:todo_bloccubit/features/todo/domain/entity/book.dart';
import 'package:todo_bloccubit/features/todo/presentation/widget/alert.dart';
import 'package:todo_bloccubit/features/todo/presentation/widget/custombar.dart';

class CreatePage extends StatelessWidget {
  const CreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController title = TextEditingController();
    TextEditingController author = TextEditingController();
    TextEditingController description = TextEditingController();

    return Scaffold(
      appBar: const CustomAppBar(text: 'Создание новой книги',),
      body: BlocBuilder<BookCubit, BookState>(
        builder: (context, state) => switch(state) {
          BookInitial() || BookLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
          BookSuccess() => Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Название",enabledBorder: UnderlineInputBorder()),
                controller: title,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Автор",enabledBorder: UnderlineInputBorder()),
                controller: author,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Описание",enabledBorder: UnderlineInputBorder()),
                controller: description,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (title.text == "" || author.text == "") return;
                  var book = Book(title: title.text, description: description.text, author: author.text, categories: []);
                  context.read<BookCubit>().addBook(book);
                  Navigator.pop(context);
                }, 
                style: ButtonStyle(
                  backgroundColor:  MaterialStateProperty.all(Colors.blue),
                ),
                child: Text("Создать", style: TextStyle(fontSize: 16),)
              )
            ],
          ),
          BookError() => ErrorAlert(text: context.read<BookCubit>().getError),
        },
      ),
    );
  }
}
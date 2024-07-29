import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_bloccubit/features/todo/domain/cubit/book_cubit.dart';
import 'package:todo_bloccubit/features/todo/domain/entity/book.dart';
import 'package:todo_bloccubit/features/todo/presentation/widget/alert.dart';
import 'package:todo_bloccubit/features/todo/presentation/widget/custombar.dart';

class EditPage extends StatelessWidget {
  const EditPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController title = TextEditingController();
    TextEditingController author = TextEditingController();
    TextEditingController description = TextEditingController();
    Book book = context.read<BookCubit>().getRepository.getBook(context.read<BookCubit>().id);
    title.text = book.title;
    author.text = book.author;
    description.text = book.description;

    return Scaffold(
      appBar: const CustomAppBar(text: 'Изменение книги',),
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
                  context.read<BookCubit>().updateBook(context.read<int>(), book);
                  Navigator.pop(context);
                }, 
                style: ButtonStyle(
                  backgroundColor:  MaterialStateProperty.all(Colors.orange),
                ),
                child: Text("Изменить", style: TextStyle(fontSize: 16),)
              )
            ],
          ),
          BookError() => ErrorAlert(text: context.read<BookCubit>().getError),
        },
      ),
    );
  }
}
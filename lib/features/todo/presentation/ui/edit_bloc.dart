import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_bloccubit/features/todo/domain/bloc/book_bloc.dart';
import 'package:todo_bloccubit/features/todo/domain/entity/book.dart';
import 'package:todo_bloccubit/features/todo/presentation/widget/alert.dart';
import 'package:todo_bloccubit/features/todo/presentation/widget/custombar.dart';

class EditBlocPage extends StatelessWidget {
  const EditBlocPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<BookBloc>().add(OnLoading());
    TextEditingController title = TextEditingController();
    TextEditingController author = TextEditingController();
    TextEditingController description = TextEditingController();
     
    title.text = context.read<BookBloc>().bookRepository.getBook(context.read<BookBloc>().id).title;
    author.text = context.read<BookBloc>().bookRepository.getBook(context.read<BookBloc>().id).author;
    description.text = context.read<BookBloc>().bookRepository.getBook(context.read<BookBloc>().id).description;

    return Scaffold(
      appBar: const CustomAppBar(text: 'Изменение книги',),
      body: BlocBuilder<BookBloc, BookBlocState>(
        builder: (context, state) => switch(state) {
          BookInitial() => const Center(
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
                  context.read<BookBloc>().add(OnEditBook(book: book));
                  Navigator.pop(context);
                }, 
                style: ButtonStyle(
                  backgroundColor:  MaterialStateProperty.all(Colors.orange),
                ),
                child: Text("Изменить", style: TextStyle(fontSize: 16),)
              )
            ],
          ),
          BookError() => ErrorAlert(text: state.error),
        },
      ),
    );
  }
}
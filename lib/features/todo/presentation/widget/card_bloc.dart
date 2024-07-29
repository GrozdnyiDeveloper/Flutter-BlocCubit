import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_bloccubit/features/todo/domain/bloc/book_bloc.dart';

class TodoBlocCard extends StatelessWidget {
  const TodoBlocCard({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        leading: Checkbox(
          value: context.read<BookBloc>().bookRepository.getBook(index).isCheck,
          onChanged: (value) => context.read<BookBloc>().add(OnChanged(index: index, isCheck: value ?? false)),
        ),
        title: Text(
          context.read<BookBloc>().bookRepository.getBook(index).title
        ),
        children: [
          Text(
            "Автор: " + context.read<BookBloc>().bookRepository.getBook(index).author,
            style: TextStyle(fontSize: 20),
          ),
          Text(
            "Описание: " + context.read<BookBloc>().bookRepository.getBook(index).description,
            style: TextStyle(fontSize: 20),
          ),
          ElevatedButton(
            onPressed: () async {
              context.read<BookBloc>().add(OnLoading());
              context.read<BookBloc>().id = index;
              await Navigator.pushNamed(context, '/edit');
            },
            child: Text("Изменить", style: TextStyle(fontSize: 16),),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.orange) 
            )
          ),
          ElevatedButton(
            onPressed: () async {
              context.read<BookBloc>().add(OnDeleteBook(id: index));
              context.read<BookBloc>().add(OnLoading());
            },
            child: Text("Удалить", style: TextStyle(fontSize: 16),),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red) 
            )
          )
        ],
      )
    );
  }
}
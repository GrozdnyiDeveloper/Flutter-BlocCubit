import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_bloccubit/features/todo/domain/cubit/book_cubit.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        leading: Checkbox(
          value: context.watch<BookCubit>().getRepository.getBook(index).isCheck,
          onChanged: (value) => context.read<BookCubit>().onChanged(
            value ?? false, 
            index
          ),
        ),
        title: Text(
          context.read<BookCubit>().getRepository.getBook(index).title
        ),
        children: [
          Text(
            "Автор: " + context.read<BookCubit>().getRepository.getBook(index).author,
            style: TextStyle(fontSize: 20),
          ),
          Text(
            "Описание: " + context.read<BookCubit>().getRepository.getBook(index).description,
            style: TextStyle(fontSize: 20),
          ),
          ElevatedButton(
            onPressed: () async {
              context.read<BookCubit>().id = index;
              await Navigator.pushNamed(context, '/edit');
            },
            child: Text("Изменить", style: TextStyle(fontSize: 16),),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.orange) 
            )
          ),
          ElevatedButton(
            onPressed: () async {
              context.read<BookCubit>().deleteBook(index);
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
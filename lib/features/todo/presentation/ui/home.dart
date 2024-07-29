import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_bloccubit/features/todo/domain/cubit/book_cubit.dart';
import 'package:todo_bloccubit/features/todo/presentation/widget/alert.dart';
import 'package:todo_bloccubit/features/todo/presentation/widget/card.dart';
import 'package:todo_bloccubit/features/todo/presentation/widget/homebar.dart';

class Home extends StatelessWidget {
  
  const Home({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const HomeAppBar(),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          heroTag: "btnCreate",
          onPressed: () async {
            await Navigator.pushNamed(context, '/create');
          },
          child: Text("+", style: TextStyle(fontSize: 32),),
          backgroundColor: Colors.blue,
        ),
      ),
      body: BlocBuilder<BookCubit, BookState>(
        builder: (context, state) => switch(state) {
          BookInitial() || BookLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
          BookSuccess() => ListView.builder(
            itemCount: context.select<BookCubit, int>(
              (value) => value.getRepository.getAmount()
            ),
            itemBuilder: (context, index) {
              return TodoCard(
                index: index,
              );
            },
          ),
          BookError() => ErrorAlert(text: context.read<BookCubit>().getError),
        }
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloccubit/features/todo/domain/bloc/book_bloc.dart';
import 'package:todo_bloccubit/features/todo/presentation/widget/alert.dart';
import 'package:todo_bloccubit/features/todo/presentation/widget/card_bloc.dart';
import 'package:todo_bloccubit/features/todo/presentation/widget/homebar_bloc.dart';

class HomeBloc extends StatelessWidget {
  
  const HomeBloc({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<BookBloc>().add(OnLoading());
    return Scaffold(
      appBar: const HomeAppBlocBar(),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          heroTag: "btnCreate",
          onPressed: () async {
            context.read<BookBloc>().add(OnLoading());
            await Navigator.pushNamed(context, '/create');
          },
          child: Text("+", style: TextStyle(fontSize: 32),),
          backgroundColor: Colors.blue,
        ),
      ),
      body: BlocBuilder<BookBloc, BookBlocState>(
        builder: (context, state) => switch(state) {
          BookInitial() => const Center(
            child: CircularProgressIndicator(),
          ),
          BookSuccess() => ListView.builder(
            itemCount: context.read<BookBloc>().bookRepository.getBooks().length,
            itemBuilder: (context, index) {
              return TodoBlocCard(
                index: index,
              );
            },
          ),
          BookError() => ErrorAlert(text: state.error),
        }
      ),
    );
  }
}

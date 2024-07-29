import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_bloccubit/features/todo/domain/cubit/book_cubit.dart';
import 'package:todo_bloccubit/features/todo/presentation/controller/book_controller.dart';
import 'package:todo_bloccubit/features/todo/presentation/widget/alert.dart';
import 'package:todo_bloccubit/features/todo/presentation/widget/custombar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(text: 'Настройки',),
      body: BlocBuilder<BookCubit, BookState>(
        builder: (context, state) => switch(state) {
          BookInitial() || BookLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
          BookSuccess() => Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: ElevatedButton(
                    onPressed: () async {
                      context.read<BookController>().deleteAll();
                      Navigator.pop(context);
                    }, 
                    style: ButtonStyle(
                      backgroundColor:  MaterialStateProperty.all(Colors.red),
                    ),
                    child: Text("Очистить список", style: TextStyle(fontSize: 16),)
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: ElevatedButton(
                    onPressed: () async {
                      SystemNavigator.pop();
                    }, 
                    style: ButtonStyle(
                      backgroundColor:  MaterialStateProperty.all(Colors.orange),
                    ),
                    child: Text("Выход", style: TextStyle(fontSize: 16),)
                  ),
                ),
              ],
            ),
          ),
          BookError() => ErrorAlert(text: context.read<BookController>().getError),
        },
      ),
    );
  }
}

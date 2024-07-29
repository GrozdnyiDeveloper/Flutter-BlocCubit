import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_bloccubit/features/todo/domain/bloc/book_bloc.dart';

class HomeAppBlocBar extends StatelessWidget implements PreferredSizeWidget{
  const HomeAppBlocBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Не прочитанные: ${context.watch<BookBloc>().countUnfinished}'),
      leading: Padding(
        padding: EdgeInsets.all(8.0),
        child: Builder(
          builder: (context) => FloatingActionButton(
            heroTag: "btnSettings",
            onPressed: () async {
              await Navigator.pushNamed(context, '/settings');
            }, 
            child: Icon(Icons.settings, color: Colors.black,),
            backgroundColor: Colors.white,
          ),
        )
      )
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
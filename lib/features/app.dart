import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_bloccubit/features/todo/domain/bloc/book_bloc.dart';
import 'package:todo_bloccubit/features/todo/domain/cubit/book_cubit.dart';
import 'package:todo_bloccubit/features/todo/presentation/controller/book_controller.dart';
import 'package:todo_bloccubit/routes/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BookController()..init(),
        ),
        BlocProvider<BookCubit>(
          create: (BuildContext context) => BookCubit()..init()
        ),
        BlocProvider<BookBloc>(
          create: (BuildContext context) => BookBloc()
        ),
      ],
      child: MaterialApp(
        onGenerateRoute: (settings) {
          if (settings.name == Pages.create.screenPath) {
            return MaterialPageRoute (
              settings: settings,
              builder: (context) => Pages.create.screen as Widget,
            );
          }
          else if (settings.name == Pages.edit.screenPath) {
            return MaterialPageRoute (
              settings: settings,
              builder: (context) => Pages.edit.screen as Widget,
            );
          }
          else if (settings.name == Pages.settings.screenPath) {
            return MaterialPageRoute (
              settings: settings,
              builder: (context) => Pages.settings.screen as Widget,
            );
          }
          return null;
        },
        theme: ThemeData(useMaterial3: false),
        home: Pages.home.screen as Widget,
      ),
    );
  }
}
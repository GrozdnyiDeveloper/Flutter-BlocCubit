import 'package:todo_bloccubit/features/todo/presentation/ui/create.dart';
import 'package:todo_bloccubit/features/todo/presentation/ui/create_bloc.dart';
import 'package:todo_bloccubit/features/todo/presentation/ui/edit.dart';
import 'package:todo_bloccubit/features/todo/presentation/ui/edit_bloc.dart';
import 'package:todo_bloccubit/features/todo/presentation/ui/home.dart';
import 'package:todo_bloccubit/features/todo/presentation/ui/home_bloc.dart';
import 'package:todo_bloccubit/features/todo/presentation/ui/settings.dart';

enum Pages{
  home,
  create,
  edit,
  settings
}

bool bloc = true;

extension AppPageExtension on Pages {
  String get screenPath {
    return switch (this) {
      Pages.home => '/',
      Pages.create => '/create',
      Pages.edit => '/edit',
      Pages.settings => '/settings',
    };
  }

  Object get screen {
    if (bloc) {
      return switch (this) {
        Pages.home => const HomeBloc(),
        Pages.create => const CreateBlocPage(),
        Pages.edit => const EditBlocPage(),
        Pages.settings => const SettingsPage(),
      };
    } else {
      return switch (this) {
        Pages.home => const Home(),
        Pages.create => const CreatePage(),
        Pages.edit => const EditPage(),
        Pages.settings => const SettingsPage(),
      };
    }
  }
}
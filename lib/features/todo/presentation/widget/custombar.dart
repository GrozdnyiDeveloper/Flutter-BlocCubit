import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String text;

  const CustomAppBar({super.key, required this.text});
  

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(text),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
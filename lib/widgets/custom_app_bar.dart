import 'package:flutter/material.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  final Color? backgroundColor;

  final double elevation;

  final List<Widget>? actions;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.backgroundColor,
    this.elevation = 4.0,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.primary,
      elevation: elevation,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
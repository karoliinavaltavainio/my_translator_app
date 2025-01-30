import 'package:flutter/material.dart';

/// A customizable AppBar widget adhering to Material Design guidelines.
///
/// This AppBar includes a title and can accept additional actions.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// The title to display in the AppBar.
  final String title;

  /// Optional background color for the AppBar.
  final Color? backgroundColor;

  /// Optional elevation for the AppBar.
  final double elevation;

  /// List of widgets to display in the AppBar's actions.
  final List<Widget>? actions;

  /// Creates a [CustomAppBar].
  ///
  /// The [title] is required to display the AppBar's title.
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
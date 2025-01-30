import 'package:flutter/material.dart';


class HistoryButton extends StatelessWidget {
  final IconData icon;

  final String tooltip;

  final double iconSize;

  final Color? iconColor;

  final VoidCallback onPressed;

  const HistoryButton({
    Key? key,
    this.icon = Icons.history,
    this.tooltip = 'View History',
    this.iconSize = 24.0,
    this.iconColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        size: iconSize,
        color: iconColor ?? Theme.of(context).colorScheme.secondary,
      ),
      tooltip: tooltip,
      onPressed: onPressed,
    );
  }
}
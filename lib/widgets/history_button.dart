import 'package:flutter/material.dart';

/// A reusable button widget that navigates to the HistoryScreen.
///
/// You can customize the icon, tooltip, size, and color as needed.
class HistoryButton extends StatelessWidget {
  /// The icon to display inside the button.
  final IconData icon;

  /// The tooltip text that appears when the user long-presses the button.
  final String tooltip;

  /// The size of the icon.
  final double iconSize;

  /// The color of the icon.
  final Color? iconColor;

  /// The callback function that is called when the button is pressed.
  final VoidCallback onPressed;

  /// Creates a [HistoryButton].
  ///
  /// The [onPressed] callback is required to define the navigation behavior.
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
import 'package:flutter/material.dart';
import '../models/translation.dart'; // Adjust the path if necessary
import '../controllers/translation_controller.dart';

/// A screen that displays the translation history.
class HistoryScreen extends StatefulWidget {
  /// The list of translations to display.
  final List<Translation> history;

  /// Creates a [HistoryScreen].
  ///
  /// The [history] parameter must not be null.
  const HistoryScreen({Key? key, required this.history}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  // We use this to call clearHistory()
  final TranslationController translationController = TranslationController();

  // Confirm user wants to clear all
  void _confirmClear() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Clear History"),
        content: const Text("Are you sure you want to delete all history?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // Cancel
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              _clearHistory();
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  // Actually clear the history in SharedPreferences and from the list
  Future<void> _clearHistory() async {
    await translationController.clearHistory();
    setState(() {
      widget.history.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("History cleared successfully!"),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Translation History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: "Clear History",
            onPressed: _confirmClear,
          ),
        ],
      ),
      body: widget.history.isEmpty
          ? const Center(
        child: Text(
          'No translations yet.',
          style: TextStyle(fontSize: 16),
        ),
      )
          : ListView.builder(
        itemCount: widget.history.length,
        itemBuilder: (context, index) {
          final translation = widget.history[index];
          return ListTile(
            leading: const Icon(Icons.translate, color: Colors.deepOrange),
            title: Text(
              translation.translatedText,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(translation.inputText),
            trailing: Text(
              _formatTimestamp(translation.timestamp),
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          );
        },
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    // Example format: "14:30 on 21/04/2023"
    String hour = timestamp.hour.toString().padLeft(2, '0');
    String minute = timestamp.minute.toString().padLeft(2, '0');
    String day = timestamp.day.toString().padLeft(2, '0');
    String month = timestamp.month.toString().padLeft(2, '0');
    String year = timestamp.year.toString();
    return "$hour:$minute on $day/$month/$year";
  }
}

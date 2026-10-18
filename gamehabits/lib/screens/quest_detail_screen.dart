import 'package:flutter/material.dart';

class QuestDetailScreen extends StatelessWidget {
  final String questTitle; // Variabel untuk menerima judul quest

  const QuestDetailScreen({super.key, required this.questTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Quest')),
      body: Center(
        child: Text(
          'Anda sedang melihat detail untuk misi:\n$questTitle',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}

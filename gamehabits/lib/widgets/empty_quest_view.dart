import 'package:flutter/material.dart';

class EmptyQuestView extends StatelessWidget {
  const EmptyQuestView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      key: Key('empty-state'),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Belum ada quest hari ini.\nWaktunya bersantai!',
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

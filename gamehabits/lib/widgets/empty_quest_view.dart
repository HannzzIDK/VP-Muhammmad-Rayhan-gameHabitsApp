import 'package:flutter/material.dart';

class EmptyQuestView extends StatelessWidget {
  const EmptyQuestView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Center(
      key: const Key('empty-state'),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox, size: 64, color: colorScheme.outline),
            const SizedBox(height: 16),
            Text(
              'Belum ada quest hari ini.\nWaktunya bersantai!',
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyLarge?.copyWith(color: colorScheme.outline),
            ),
          ],
        ),
      ),
    );
  }
}

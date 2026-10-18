import 'package:flutter/material.dart';

import '../models/quest.dart';

import 'package:gamehabits/widgets/quest_card.dart';

class QuestSelection extends StatelessWidget {
  final List<Quest> quests;
  final Function(int) onClaim;

  const QuestSelection({
    super.key,
    required this.quests,
    required this.onClaim,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: quests.length,
      itemBuilder: (context, index) {
        final quest = quests[index];
        return QuestCard(
          title: quest.title,
          isMainQuest: quest.isMainQuest,
          expReward: quest.expReward,
          coinReward: quest.coinReward,
          isCompleted: quest.isCompleted,
          onClaim: () => onClaim(index),
        );
      },
    );
  }
}

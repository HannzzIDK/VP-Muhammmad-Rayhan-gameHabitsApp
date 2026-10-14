class Quest {
  int id;
  String title;
  bool isMainQuest;
  int expReward;
  int coinReward;
  bool isCompleted;

  Quest({
    required this.id,
    required this.title,
    required this.isMainQuest,
    required this.expReward,
    required this.coinReward,
    this.isCompleted = false,
  });
}

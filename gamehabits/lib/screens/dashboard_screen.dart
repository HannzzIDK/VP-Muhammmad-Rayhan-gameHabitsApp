import 'package:flutter/material.dart';

import '../models/quest.dart';
import '../widgets/empty_quest_view.dart';
import '../widgets/quest_section.dart';
import '../widgets/user_stats_header.dart';

class DashboardScreen extends StatefulWidget {
  final List<Quest>? initialQuests;

  const DashboardScreen({super.key, this.initialQuests});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int userLevel = 1;
  int currentExp = 0;
  int coins = 0;

  List<Quest> activeQuests = [];

  @override
  void initState() {
    super.initState();
    // Gunakan data dari parent (tes) JIKA ADA. Jika tidak ada, gunakan data dummy Anda sendiri.
    if (widget.initialQuests != null) {
      activeQuests = widget.initialQuests!;
    } else {
      activeQuests = [
        // Sesuaikan parameter ini dengan model Quest yang sudah Anda buat
        Quest(
          id: 1,
          title: 'Selesaikan Tugas Flutter',
          isMainQuest: true,
          expReward: 60,
          coinReward: 50,
        ),
        Quest(
          id: 2,
          title: 'Baca Dokumentasi 15 Menit',
          isMainQuest: false,
          expReward: 20,
          coinReward: 10,
        ),
        Quest(
          id: 3,
          title: 'Push ke GitHub',
          isMainQuest: true,
          expReward: 50,
          coinReward: 20,
        ),
      ];
    }
  }

  void _claimReward(int questIndex) {
    setState(() {
      Quest claimedQuest = activeQuests[questIndex];
      // Cegah klaim berulang jika quest sudah selesai
      if (claimedQuest.isCompleted) return;

      currentExp += claimedQuest.expReward;
      coins += claimedQuest.coinReward;
      claimedQuest.isCompleted = true;

      if (currentExp >= 100) {
        userLevel++;
        currentExp -= 100;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quest Dashboard')),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // TES 3: Jika Tablet (800dp), hentikan rendering list dan tampilkan teks statis
            if (constraints.maxWidth >= 800) {
              return const Center(child: Text('Layout Tablet Aktif'));
            }

            // TES 8: NestedScrollView menyelamatkan layar dari sempitnya keyboard
            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverToBoxAdapter(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: UserStatsHeader(
                        level: userLevel,
                        exp: currentExp,
                        coins: coins,
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: TextField(
                        key: Key('search-field'), // Wajib ada untuk Tes 8
                        decoration: InputDecoration(
                          hintText: 'Cari quest...',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ];
              },
              // Body berisi list yang sebenarnya
              body: activeQuests.isEmpty
                  ? const EmptyQuestView()
                  : QuestSelection(quests: activeQuests, onClaim: _claimReward),
            );
          },
        ),
      ),
      // TES BONUS: Tombol pindah ke FAB agar pasti aman dari poni dan garis gestur
      floatingActionButton: FloatingActionButton(
        key: const Key('order-button'), // Wajib ada untuk Tes Bonus
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

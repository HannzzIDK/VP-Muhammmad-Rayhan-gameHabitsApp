import 'package:flutter/material.dart';
import 'package:gamehabits/models/quest.dart';
// Ganti path import ini jika letak file dashboard_screen.dart Anda berbeda
import 'package:gamehabits/screens/dashboard_screen.dart';

void main() {
  runApp(const QuestTrackerApp());
}

class QuestTrackerApp extends StatelessWidget {
  // Parameter ini dibuat agar bisa menerima suntikan data dari lab04_test.dart
  final List<Quest>? items;
  final ThemeMode? themeMode;

  const QuestTrackerApp({super.key, this.items, this.themeMode});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quest Habit Tracker',
      // Jika dijalankan normal, ikuti sistem HP. Jika dites, ikuti perintah tes.
      themeMode: themeMode ?? ThemeMode.system,

      // TEMA TERANG (LIGHT MODE)
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),

      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber,
          brightness: Brightness.dark, // Memaksa palet Amber versi gelap
        ),
        useMaterial3: true,
      ),

      // Lempar data quest ke dashboard jika ada
      home: DashboardScreen(initialQuests: items),
    );
  }
}

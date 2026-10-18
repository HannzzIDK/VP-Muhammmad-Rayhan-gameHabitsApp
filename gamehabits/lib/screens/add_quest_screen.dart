import 'package:flutter/material.dart';

class AddQuestScreen extends StatelessWidget {
  const AddQuestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Quest Baru')),
      body: const Center(
        child: Text('Formulir tambah quest akan dikerjakan di Week 5'),
      ),
    );
  }
}

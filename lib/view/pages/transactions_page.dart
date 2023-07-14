import 'package:flutter/material.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('transactions'),
      ),
      body: Container(
        // decoration: const BoxDecoration(color: BACKGROUND_COLOR2),
        child: const Center(
          child: Text('this is transactions page'),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More'),
      ),
      body: Container(
        //decoration: const BoxDecoration(color: BACKGROUND_COLOR2),
        child: const Center(
          child: Text('this is more page'),
        ),
      ),
    );
  }
}

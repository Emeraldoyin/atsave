import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: const Text('Wallet'),
        ),
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

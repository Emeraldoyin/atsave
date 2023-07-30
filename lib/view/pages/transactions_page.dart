import 'package:easysave/bloc_folder/db_connectivity/connectivity_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../consts/app_images.dart';
import '../../controller/home/home_controller.dart';
import '../../utils/helpers/boilerplate/stateless_view.dart';

class TransactionsPage extends StatelessView<Home, HomePageController> {
  const TransactionsPage(HomePageController controller, {Key? key})
      : super(controller, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: const Text('Transactions'),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<ConnectivityBloc, ConnectivityState>(
                builder: (context, state) {
                  if (state is DbSuccessState &&
                      state.availableSavingsTransactions != null &&
                      state.availableSavingsTransactions!.isNotEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(top: 16.h),
                      child: controller.buildTransactionList(),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 200),
                    child: Center(
                      child: Column(
                        children: [
                          const Text('No transactions yet'),
                          Image.asset(image30)
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ));
  }
}

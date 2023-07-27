import 'package:easysave/bloc_folder/db_connectivity/connectivity_bloc.dart';
import 'package:easysave/controller/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/savings_goals.dart';

Future<void> showDeleteDialog(
    SavingsGoals goal, BuildContext context, state) async {
  String? name = goal.goalNotes;
  // int id = widget.eachTask.id!;

  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Delete Goal '),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Are you sure you want to delete savings goal "$name"?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              context
                  .read<ConnectivityBloc>()
                  .add(DeleteSavingsGoalsEvent(goal: goal));
              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //   content: Text('task $name deleted successfully'),
              //   showCloseIcon: true,
              // ));
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Home()));
            },
          ),
        ],
      );
    },
  );
}

Future<void> showPinDialog(
    SavingsGoals goal, BuildContext context, state) async {
  String? name = goal.goalNotes;
  // int id = widget.eachTask.id!;

  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Pin Goal '),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Do you want to add "$name" to pinned goals?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              context
                  .read<ConnectivityBloc>()
                  .add(DeleteSavingsGoalsEvent(goal: goal));
              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //   content: Text('task $name deleted successfully'),
              //   showCloseIcon: true,
              // ));
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Home()));
            },
          ),
        ],
      );
    },
  );
}

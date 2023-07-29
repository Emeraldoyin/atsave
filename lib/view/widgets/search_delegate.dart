import 'package:easysave/controller/home/goal_details_controller.dart';
import 'package:easysave/model/savings_goals.dart';
import 'package:easysave/model/savings_transactions.dart';
import 'package:easysave/view/pages/goal_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc_folder/db_connectivity/connectivity_bloc.dart';

class TransactionsDelegate extends SearchDelegate {
  List<SavingsTransactions>? transactionSuggestions = [];
  List<SavingsTransactions>? allTransactions;

  TransactionsDelegate({this.transactionSuggestions, this.allTransactions});

  @override
  List<Widget>? buildActions(BuildContext context) {
    IconButton(
        onPressed: () {
          allTransactions!.clear();
        },
        icon: Icon(Icons.arrow_back));
    return null;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: BackButtonIcon());
  }

  @override
  Widget buildResults(
    BuildContext context,
  ) {
    return BlocBuilder<ConnectivityBloc, ConnectivityState>(
      builder: (context, state) {
        if (state is DbSuccessState) {
          final allTransactions = state.availableSavingsTransactions;
          final results = state.availableSavingsGoals
              .map((goal) => goal.goalNotes)
              .toList();
          final showResults = results
              .where(
                  (goal) => goal!.toLowerCase().contains(query.toLowerCase()))
              .toList();
          return ListView.builder(
            itemCount: showResults.length,
            itemBuilder: (context, index) {
              final result = showResults[index];
              return ListTile(
                  title: Text(showResults[index]!),
                  onTap: () {
                    query = result!;
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GoalDetails(
                                  goal: state.availableSavingsGoals.firstWhere(
                                      (goal) => goal.goalNotes == result),
                                  categories: state.availableCategories,
                                )));
                  });
            },
          );
        }
        return Container();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return BlocBuilder<ConnectivityBloc, ConnectivityState>(
      builder: (context, state) {
        if (state is DbSuccessState) {
          List<String> suggestions = state.availableSavingsGoals
              .map((goal) => goal.goalNotes!)
              .toList();
          List<String> showSuggestions = suggestions
              .where((goal) => goal.toLowerCase().contains(query.toLowerCase()))
              .toList();
          return showSuggestions.isNotEmpty
              ? ListView.builder(
                  itemCount: showSuggestions.length,
                  itemBuilder: (context, index) {
                    final result = showSuggestions[index];
                    return ListTile(
                        title: Text(showSuggestions[allTransactions![index].savingsId!]),
                        onTap: () {
                          query = result;
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GoalDetails(
                                      goal: state.availableSavingsGoals
                                          .firstWhere((goal) =>
                                              goal.goalNotes == result), categories: state.availableCategories,)));
                        });
                  },
                )
              : Center(child: Text('No available transactions with this name'));
        }
        return Container();
      },
    );
  }
}

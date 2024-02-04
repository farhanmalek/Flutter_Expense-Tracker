import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpensesList extends StatelessWidget {
  //forward the prop, or the param for the list to output.
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    //We use listview here, scrollable list. the .builder function will create the items when they are visible or about to be to save performance, which is why we arent using column.
    //itemCount identifies how many times the itemBuilder is executed, ouputting the titles of the expenses.
    return ListView.builder(
      itemCount: expenses.length,
      //Dismissable allows us to swipe to remove an item
      itemBuilder: (ctx, index) => Dismissible(
          key: ValueKey(expenses[index]),
          background: Container(
            //using out theme here to get the related error
            color: Theme.of(context).colorScheme.error,
            margin: const EdgeInsets.symmetric(horizontal: 16),
          ),
          //once dismissed remove the expense
          onDismissed: (direction) {
            onRemoveExpense(expenses[index]);
          },
          child: ExpenseItem(
              expenses[index]),
              ), //key idenfities each widget uniquely.
    );
  }
}

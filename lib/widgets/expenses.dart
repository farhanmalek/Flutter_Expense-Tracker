import 'package:expense_tracker/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

//Stateful widget as we are going to be changing the UI
class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
//creating a private property
//Creating a list of expenses that will be output onto the screen
  final List<Expense> _registeredExpenses = [
    //Each expense was created using the Expense constructor function, accessing these properties would be like _registeredExpenses[0].title = Golf Fitting.
    Expense(
        title: 'Golf Fitting',
        amount: 140.00,
        date: DateTime.now(),
        category: Category.leisure),
    Expense(
        title: 'Balls',
        amount: 75.00,
        date: DateTime.now(),
        category: Category.leisure),
  ];

//Open modal when + is pressed on navbar
  void _openAddExpenseOverlay() {
    //show method has heaps of options of pre built modals.
    //When in a class that extends state, context property is added to the class.
    //Context value as info on position of widget in widget tree.
    //builder takes a function, takes a ctx value, context of modalBottomSheet
    showModalBottomSheet(
        isScrollControlled:
            true, //ensures modal takes full height no overlap w keyboard
        context: context,
        builder: (ctx) {
          //return widget that is displayed when this modal is open;
          return NewExpense(
            onAddExpense: _addExpense,
          );
        });
  }

//Add expense to our list, so register the user input
  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex =
        _registeredExpenses.indexOf(expense); //index of value in the list

    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context)
        .clearSnackBars(); //Removes any info msgs of screen if removing multiple items.
        //How to show alerts
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Expense Deleted. Still spent the coin tho."),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex,
                  expense); //insert adds item at certain position in list.
            });
          },
        ), //Button on alert to bring back the deleted item
      ),
    );
  }

//This is the widget that is displayed on the home property
  @override
  Widget build(BuildContext context) {
    //If no expenses show this.
    Widget mainContent = const Center(
      child: Text("No Expenses? On the hard save."),
    );

//If expenses are added then show the expenses
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
    //Scaffold provides a standard layout, appBar is like the header.
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        //actions will hold all the buttons we want.
        // on pressing of the + button the add expense overlay opens
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add)),
        ],
      ), //Adds like a bar or navbar top of screen
      body: Column(
        children: [
          Chart(expenses: _registeredExpenses),
          //Seperate Widget for outputting list of expenses.
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}

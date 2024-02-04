//Describes the data structure for an expense, which is simply a class

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

//To format date
final formatter = DateFormat.yMd();

//Load up the uuid setup.
const uuid = Uuid();

//Enums, prefined values
enum Category {
  food,
  travel,
  leisure,
  work,
}

//This is a map. for icons.
const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {
  //Constructor function using named parameters.
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid
            .v4(); //initialiser list, so : after the function, to initialise props that arent received
  //as arguements.

//The properties of our expense object.
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

//using a getter
  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});

  final Category category;
  final List<Expense> expenses;

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum = sum +
          expense
              .amount; //for in is for lists for each element in the list essentially.
    }

    return sum;
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/models/expense.dart';
//This is the widget that shows up when we click the + button to add a new expense

//To format date
final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  //we need the onAddExpense so its passed as a prop.
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  //A way to store input in variable is as below, similar to setting state in react.
  // String _enteredTitle = '';

  // void _saveTitleInput(String inputValue) {
  //   _enteredTitle =
  //       inputValue; //not wrapping it in setstate as not using entered value in UI code.

  // }

  final _titleController =
      TextEditingController(); //creates an object that handles user input, susses the storing of value.

  final _amountController = TextEditingController(); //handle amount input.

  DateTime?
      _selectedDate; //DateTime is a type for date. initially can store value or nothing. so ? used.

//Set initial category as leisure
  Category _selectedCategory = Category.leisure;

  //open the date picker
  //example of a promise using async await.
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        firstDate: firstDate,
        lastDate: now,
        initialDate: now); //example of show... so built in function

    setState(() {
      _selectedDate =
          pickedDate; //set the state so we can show the selected date on screen
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      // Show error if inputs are invalid
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text('Ensure valid inputs are entered.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }

    widget.onAddExpense(Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory));
    Navigator.pop(context);
  }

  //tell flutter to delete controller when not needed, it will live on in memory otherwise.
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Wrapping entire widget in padding to give it padding all around.
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            //controller property will store that value that in input.
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('Amount'),
                    prefixText: '\$ ',
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end, //push date to end
                  crossAxisAlignment:
                      CrossAxisAlignment.center, //center vertically
                  children: [
                    Text(_selectedDate == null
                        ? "No date selected"
                        : formatter.format(
                            _selectedDate!)), //exclamation forces dart to say its not null.
                    IconButton(
                      onPressed: _presentDatePicker, //on click open the picker
                      icon: const Icon(Icons.calendar_month),
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              DropdownButton(
                //Item that is shown when the dropdown is closed.
                  value: _selectedCategory,
                  //Transform each list item to dropdwownmenuitem
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(
                            category.name.toUpperCase(),
                          ),
                        ),
                      )
                      .toList(),
                      //Saying what ever value is picked set that value in state
                  onChanged: (value) {
                    setState(() {
                      if (value == null) {
                        return;
                      }
                      _selectedCategory = value;
                    });
                  }), //Dropdown button once clicked
              const Spacer(), //spacer fills up empty space between widgets
              TextButton(
                  onPressed: () {
                    Navigator.pop(context); //removes overlay from screen
                  },
                  child: const Text('Cancel')),
              ElevatedButton(
                  onPressed: _submitExpenseData,
                  child: const Text("Save Expense"))
            ],
          )
        ],
      ),
    );
  }
}

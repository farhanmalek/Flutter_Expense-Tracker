import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';
//Seed color is sort of like primary colour that the rest of the theme will be made up of, flutter uses that main colour and matches other features around it.
var kColorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(
        255, 96, 59, 181)); //global vars set up w k for theme related vars

var kDarkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 9, 99, 125)); //dark color scheme

void main() {
  runApp(
    //Material App is needed to get everything going. It is the Root.
    MaterialApp(
      //theming
      //.copyWith is a method we use so we can keep features of the theme we are choosing and just change what we want instead of setting everything from scratch.
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        //Style the card
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        //Style the button, background colour is background of button, foreground is the text of the button
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
          ),
        ),
      ),
      //This is the normal theme
      theme: ThemeData().copyWith(
          colorScheme: kColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.primaryContainer,
          ),
          cardTheme: const CardTheme().copyWith(
            color: kColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.primaryContainer,
            ),
          ),
          //This is setting the theme of the text in our app, 
          //Here we are affecting the text that falls under titleLarge, largest text of any given container i guess.
          textTheme: ThemeData().textTheme.copyWith(
                  titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: kColorScheme.onSecondaryContainer,
                fontSize: 14,
              ))),
              //Allow theme to switch from dark to light based on mobile setting.
      themeMode: ThemeMode.system,
      //What we are displaying when the app loads up.
      home: const Expenses(),
    ),
  );
}

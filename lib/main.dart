import 'package:flutter/material.dart';

import "home.dart";
import "board.dart" show Player, playerString;

void main() => runApp(
  MaterialApp (
    title: "Tic Tac Toe",
    home: MainPage(true, Player.O)
  )  
);

class EntryPage extends StatefulWidget {
  @override EntryState createState() => EntryState();
}

class EntryState extends State<EntryPage> {
  bool aiChoice = true;
  Player userChoice = Player.X;

  @override Widget build(BuildContext context) => Scaffold (
    appBar: AppBar (title: Text ("Tic Tac Toe")),
    body: Column (
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <RadioListTile<bool>> [
        RadioListTile<bool> (
          value: true,
          groupValue: aiChoice,
          onChanged: updateChoice,
          title: Text ("Play against the AI"),
          subtitle: Text ("Choose either X or O"),
          selected: aiChoice,
          secondary: DropdownButton (
            value: userChoice,
            onChanged: updateUser,
            items: Player.values.map(
              (Player player) => DropdownMenuItem<Player> (
                child: ListTile (title: Text (playerString (player)))
              )
            ).toList(),
          )
        ),
        RadioListTile<bool> (
          value: false,
          groupValue: aiChoice,
          selected: !aiChoice,
          title: Text ("Play against a friend"),
          subtitle: Text ("Decide between yourselves who will be X and O"),
          onChanged: updateChoice
        ),
      ]
    ),
    floatingActionButton: FloatingActionButton.extended(
      icon: const Icon (Icons.done),
      label: Text ("Start game"),
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute<void> (
          builder: (BuildContext _) => MainPage (aiChoice, userChoice)
        )
      )
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
  );

  void updateChoice(bool choice) => setState(() => aiChoice = choice);
  void updateUser(Player choice) => setState(() => userChoice = choice);
}
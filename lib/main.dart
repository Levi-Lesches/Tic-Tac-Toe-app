import 'package:flutter/material.dart';

import "home.dart";
import "board.dart" show Player;

void main() => runApp(
  MaterialApp (
    title: "Tic Tac Toe",
    home: MainPage(true, Player.X)
  )  
);

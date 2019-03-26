import "package:flutter/material.dart";

import "board.dart";

class MainPage extends StatefulWidget {
	@override MainState createState() => MainState();
}

class MainState extends State<MainPage> {
	final Board board = Board();
	Player winner;
	bool get gameFinished => winner != null;

	static BorderSide getBorder(int index, List<int> indices) => 
		!indices.contains(index) ? const BorderSide() : null;

	@override Widget build (BuildContext context) => Scaffold (
		appBar: AppBar (title: Text ("Tic Tac Toe")),
		body: GridView.count (
			crossAxisCount: 3,
			children: board.board.asMap().entries.map(  // key = index, 
				(MapEntry<int, Player> entry) => GestureDetector (
					onTap: gameFinished ? null
						: () => setState(() {
							board.move (entry.key);
							winner = board.winner;
						}),
					child: Expanded (
						child: Container (
							child: Text (toString (entry.value) ?? ""),
							decoration: BoxDecoration (
								border: Border (
									top: getBorder(entry.key, const [0, 1, 2]),
									left: getBorder(entry.key, const [0, 3, 6]),
									right: getBorder(entry.key, const [2, 5, 8]),
									bottom: getBorder(entry.key, const [6, 7, 8]),

								)
							),
						)
					)
				)
			).toList()
		)
	);
}
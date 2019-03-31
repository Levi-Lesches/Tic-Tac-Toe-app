import "package:flutter/material.dart";

import "board.dart";
import "strikethrough.dart";

class MainPage extends StatefulWidget {
	@override MainState createState() => MainState();
}

class MainState extends State<MainPage> {
	Board board = Board();
	Victory victory;
	bool get gameFinished => victory != null;

	static BorderSide getBorder(int index, List<int> indices) => 
		!indices.contains(index) ? const BorderSide() : BorderSide.none;

	@override Widget build (BuildContext context) => Scaffold (
		appBar: AppBar (title: Text ("Tic Tac Toe")),
		floatingActionButton: gameFinished
			? FloatingActionButton.extended(
				tooltip: "Restart",
				onPressed: () => setState(() {board = Board(); victory = null;}),
				icon: Icon (Icons.restore),
				label: Text ("Restart")
			)
			: null,
		body: Column  (
			mainAxisAlignment: MainAxisAlignment.center,
			children: [
				Text (gameFinished
					? victory.winner == null
						? "It's a tie"
						: "${playerString(victory.winner)} won!"
					: "${playerString (board.turn)}'s turn", 
					style: TextStyle (fontSize: 25)
				),
				SizedBox (height: 30),
				CustomPaint (
					foregroundPainter: victory?.winner != null ? Strikethrough(victory) : null,
					child: GridView.count (
						shrinkWrap: true,
						crossAxisCount: 3,
						physics: NeverScrollableScrollPhysics(),
						children: board.board.asMap().entries.map(  // key = index, 
							(MapEntry<int, Player> entry) => GestureDetector (
								onTap: gameFinished || board.board [entry.key] != null ? null
									: () => setState(() {
										board.move (entry.key);
										victory = board.victory;
									}),
								child: Container (
									child: Center (
										child: Text (
											playerString (entry.value) ?? "",
											style: TextStyle (fontSize: 50)
										)
									),
									decoration: BoxDecoration (
										border: Border (
											top: getBorder(entry.key, const [0, 1, 2]),
											left: getBorder(entry.key, const [0, 3, 6]),
											right: getBorder(entry.key, const [2, 5, 8]),
											bottom: getBorder(entry.key, const [6, 7, 8]),
										)
									)
								)
							)
						).toList()
					)
				)
			]
		)
	);
}
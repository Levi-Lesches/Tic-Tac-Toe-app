import "package:flutter/material.dart";

// backend
import "board.dart";
import "ai.dart";
// ui
import "strikethrough.dart";
import "dart:async";  // Timer to delay AI moves

class MainPage extends StatefulWidget {
	final bool ai;
	final Player user;
	MainPage(this.ai, this.user);
	@override MainState createState() => MainState();
}

class MainState extends State<MainPage> {
	static Duration aiDelay = Duration(milliseconds: 250);

	final Board board = Board();
	Victory victory;
	AI ai;

	bool get gameFinished => victory != null;

	MainState() {ai = AI (board);}

	static BorderSide getBorder(int index, List<int> indices) => 
		!indices.contains(index) ? const BorderSide() : BorderSide.none;

	void aiMove ([bool checkWinner = true, int defaultPosition]) => Timer (
		aiDelay, () => setState(() {
			board.move(defaultPosition ?? ai.bestMove);
			if (checkWinner) victory = board.victory;
		})
	);

	void Function() getMoveFunction (int index) {
		if (
			gameFinished || 
			board.board [index] != null || 
			(widget.ai && widget.user != board.turn)
		) return null;

		void move() {
			setState((){
				board.move(index);
				victory = board.victory;
			});
			if (widget.ai && victory == null) aiMove();
		}
		return move;
	}

	@override void initState() {
		super.initState();
		if (widget.ai && widget.user != Player.X)  // user wants us to go first
			aiMove(false);
	}

	@override Widget build (BuildContext context) => Scaffold (
		appBar: AppBar (title: Text ("Tic Tac Toe")),
		floatingActionButton: gameFinished
			? FloatingActionButton.extended(
				tooltip: "Restart",
				onPressed: () => setState(() {
					board.reset(); 
					victory = null;
					if (widget.ai && widget.user != Player.X) aiMove(false, 0);
				}),
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
						children: board.board.asMap().entries.map(  // entry.key = index
							(MapEntry<int, Player> entry) => GestureDetector (
								// onTap: gameFinished || board.board [entry.key] != null ? null
								// 	: () => setState(() {
								// 		board.move (entry.key);
								// 		victory = board.victory;
								// 	}),
								onTap: getMoveFunction(entry.key),
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

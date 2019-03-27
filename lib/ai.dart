import "board.dart";

class AI {
	final Board currentBoard;
	AI (this.currentBoard);

	int evaluate (Board board) {
		final Victory victory = board.victory;
		if (victory == null) return null;
		else if (victory.winner == null) return 0;
		else if (victory.winner == currentBoard.turn) return 1;
		else if (victory.winner == currentBoard.next) return -1;
		else throw "Invalid board configuration";
	} 

	// int get bestMove { return negamax ()
	// 	for (final int moveIndex in currentBoard.availableMoves) {
	// 		final Board copy = currentBoard.getDummy(moveIndex);

	// 	}
	// }

	int negamax(Board board) {
		num result = double.negativeInfinity;
		for (final int moveIndex in board.availableMoves) {
			final Board copy = board.getDummy(moveIndex);
			final int score = evaluate (copy) ?? -negamax (copy);
			if (score > result) result = score;
		}
		return result;
	}
}
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
		else throw "Invalid board configuration";  // for linting
	} 

	int get bestMove {
		num bestScore = double.negativeInfinity;
		int result;
		for (final int move in currentBoard.moves) {
			final Board dummy = currentBoard.getDummy(move);
			final num score = negamax (dummy) * -1;
			if (score > bestScore) {
				bestScore = score;
				result = move;
			}
		}
		return result;
	}

	num negamax(Board board, [int nega = -1]) {
		num result = double.negativeInfinity;
		for (final int move in board.moves) {
			final Board copy = board.getDummy(move);
			num score = evaluate (copy);
			if (score == null) score = -negamax (copy, -nega);
			else score *= nega;
			if (score > result) result = score;
		}
		return result;
	}
}

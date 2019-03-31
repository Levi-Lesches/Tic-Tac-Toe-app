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
		for (final int move in currentBoard.availableMoves) {
			final Board dummy = currentBoard.getDummy(move);
			final int score = negamax (dummy);
			if (score > bestScore) {
				bestScore = score;
				result = move;
			}
		}
		return result;
	}

	int negamax(Board board, [int nega = 1]) {
		num bestScore = double.negativeInfinity;
		for (final int move in board.availableMoves) {
			final Board copy = board.getDummy(move);
			final int score = nega * (evaluate (copy) ?? negamax (copy, -nega));
			if (score > bestScore) bestScore = score;
		}
		return bestScore;
	}
}

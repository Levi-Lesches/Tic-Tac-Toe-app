import "board.dart";

class AI {
	final Board board;
	AI (this.board);

	int evaluate (Board board) {
		final Victory victory = board.victory;
		if (victory == null) return null;
		else if (victory.winner == null) return 0;
		else if (victory.winner == this.board.turn) return 1;
		else if (victory.winner == this.board.next) return -1;
		return null;
	} 

	// int get bestMove {
	// 	for (final int moveIndex in board.availableMoves) {
	// 		final Board copy = board.getDummy(moveIndex);

	// 	}
	// }
}
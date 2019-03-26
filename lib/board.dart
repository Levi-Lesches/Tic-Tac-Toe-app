enum Player {X, O}

String toString (Player player) => player?.toString()?.substring(7);

class Board {
	static const List<List<int>> candidates = [
		[0, 1, 2],
		[3, 4, 5],
		[6, 7, 8],
		[0, 3, 6],
		[1, 4, 7],
		[2, 5, 8],
		[0, 4, 8],
		[2, 4, 6],
	];

	final List<Player> board = List.filled (9, null, growable: false);
	Player turn = Player.X;
	Player get next => turn == Player.X ? Player.O : Player.X;

	Player get winner {
		for (final Player player in Player.values) {
			for (final List<int> candidate in candidates) {
				if (candidate.every ((int index) => board [index] == player))
					return player;
			}
		}
		return null;
	}

	void move (int index) {
		board [index] = turn;
		turn = next;
	}

	bool get tie => board.every ((Player cell) => cell != null);
}

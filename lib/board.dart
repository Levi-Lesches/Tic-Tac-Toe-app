enum Player {X, O}
enum Direction {row1, row2, row3, col1, col2, col3, diagonal1, diagonal2}

String toString (Player player) => player?.toString()?.substring(7);

class Victory {
	final Direction direction;
	final Player player;
	const Victory (this.player, this.direction);
}

class Board {
	static const Map<Direction, List<int>> candidates = {
		Direction.row1: [0, 1, 2],
		Direction.row2: [3, 4, 5],
		Direction.row3: [6, 7, 8],
		Direction.col1: [0, 3, 6],
		Direction.col2: [1, 4, 7],
		Direction.col3: [2, 5, 8],
		Direction.diagonal1: [0, 4, 8],
		Direction.diagonal2: [2, 4, 6],
	};

	final List<Player> board = List.filled (9, null, growable: false);
	Player turn = Player.X;
	Player get next => turn == Player.X ? Player.O : Player.X;

	Victory get winner {
		for (final Player player in Player.values) {
			for (
				final MapEntry<Direction, List<int>> candidate
				in candidates.entries
			) {
				if (candidate.value.every (
					(int index) => board [index] == player)
				)
					return Victory (player, candidate.key);
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

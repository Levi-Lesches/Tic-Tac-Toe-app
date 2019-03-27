import "range.dart";

enum Player {X, O}
enum Direction {row1, row2, row3, col1, col2, col3, diagonal1, diagonal2}

String toString (Player player) => player?.toString()?.substring(7);

class Victory {
	final Direction direction;
	final Player winner;
	const Victory (this.winner, this.direction);
	factory Victory.tie() => Victory (null, null);
}

class Board {
	static const List<Player> start = [  // for const purposes 
		null, null, null, null, null, null, null, null, null
	];
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

	final List<Player> board;
	Board ([this.board = start]);

	Player turn = Player.X;
	Player get next => turn == Player.X ? Player.O : Player.X;

	Victory get victory {
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
		if (board.every ((Player cell) => cell != null)) return Victory.tie();
		else return null;
	}

	void move (int index) {
		board [index] = turn;
		turn = next;
	}

	Iterable<int> get availableMoves sync* {
		for (final Pair<Player> cell in enumerate<Player> (board)) {
			if (cell.value == null) yield cell.index;
		}
	}

	Board getDummy (int index) {
		final List<Player> copy = board.toList(growable: false);
		copy [index] = turn;
		return Board (copy);
	}
}

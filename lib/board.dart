import "range.dart";

enum Player {X, O}
enum Direction {row1, row2, row3, col1, col2, col3, diagonal1, diagonal2}

String playerString (Player player) => player?.toString()?.substring(7);

class Victory {
	final Direction direction;
	final Player winner;
	const Victory (this.winner, this.direction);
	factory Victory.tie() => Victory (null, null);
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

	final List<Player> board;
	Board ([entry]) : board = entry ?? List.filled (9, null, growable: false);

	Player turn = Player.X;
	Player get next => turn == Player.X ? Player.O : Player.X;

	@override String toString() => const [0, 3, 6].map (
		(int index) => " " + board.getRange (index, index + 3).map(
			(Player cell) => playerString (cell) ?? " "
		).join(" | ") + "\n"
	).join (("+---" * 3 + "\n").substring (1));

	Victory get victory {
		for (final Player player in Player.values) {
			for (
				final MapEntry<Direction, List<int>> candidate
				in candidates.entries
			) {
				if (candidate.value.every (
					(int index) => board [index] == player)
				) return Victory (player, candidate.key);
			}
		}
		if (board.every ((Player cell) => cell != null)) return Victory.tie();
		else return null;
	}

	void move (int index) {
		board [index] = turn;
		turn = next;
	}

	void reset() {
		turn = Player.X;
		for (final int index in range (board.length)) 
			board [index] = null;
	}

	Iterable<int> get moves => range (board.length).where(
		(int index) => board [index] == null
	);

	Board getDummy (int index) {
		final List<Player> copy = board.toList(growable: false);
		copy [index] = turn;
		return Board (copy)..turn = next;
	}
}

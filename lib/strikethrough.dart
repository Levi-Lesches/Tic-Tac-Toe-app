import "package:flutter/material.dart";

import "board.dart";

class Strikethrough extends CustomPainter {
	final Victory victory;
	Strikethrough(this.victory);
	@override bool shouldRepaint(_) => true;

	@override void paint (Canvas canvas, Size size) {
		final Paint paint = Paint();
		paint.strokeWidth = 4;
		final double z = size.height;
		switch (victory.direction) {
			case Direction.row1: canvas.drawLine (
				Offset (0, z / 6),
				Offset (z, z / 6),
				paint
			); break;
			case Direction.row2: canvas.drawLine (
				Offset(0, z / 2),
				Offset(z, z / 2),
				paint
			); break;
			case Direction.row3: canvas.drawLine (
				Offset(0, (5 * z) / 6),
				Offset(z, (5 * z) / 6),
				paint
			); break;
			case Direction.col1: canvas.drawLine (
				Offset(z / 6, 0),
				Offset(z / 6, z),
				paint
			); break;
			case Direction.col2: canvas.drawLine (
				Offset(z / 2, 0),
				Offset(z / 2, z),
				paint
			); break;
			case Direction.col3: canvas.drawLine (
				Offset((5 * z) / 6, 0),
				Offset((5 * z) / 6, z),
				paint
			); break;
			case Direction.diagonal1: canvas.drawLine (
				Offset(0, 0),
				Offset(z, z),
				paint
			); break;
			case Direction.diagonal2: canvas.drawLine (
				Offset(z, 0),
				Offset(0, z),
				paint
			); break;
		}
	}
}

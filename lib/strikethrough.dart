import "package:flutter/material.dart";

import "board.dart";

class Strikethrough extends CustomPainter {
	final Victory victory;
	Strikethrough(this.victory);

	// @override void bool shouldRepaint => board.victory != null;

	@override void paint (Canvas canvas, Size size) {
		final Paint paint = Paint();
		final double z = size.height;
		assert (z == size.width);
		switch (victory.direction) {
			case Direction.row1: canvas.drawLine (
				Offset (0, z / 4),
				Offset (z, z / 4),
				paint
			); break;
			case Direction.row2: canvas.drawLine (
				Offset(0, z / 2),
				Offset(z, z / 2),
				paint
			); break;
			case Direction.row3: canvas.drawLine (
				Offset(0, (3 * z) / 4),
				Offset(z, (3 * z) / 4),
				paint
			); break;
			case Direction.col1: canvas.drawLine (
				Offset(z / 4, 0),
				Offset(z / 4, z),
				paint
			); break;
			case Direction.col2: canvas.drawLine (
				Offset(z / 2, 0),
				Offset(z / 2, z),
				paint
			); break;
			case Direction.col3: canvas.drawLine (
				Offset((3 * z) / 4, 0),
				Offset((3 * z) / 4, z),
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

	@override bool shouldRepaint(_) => true;
}
import 'dart:collection';

import 'package:webspark_task/algorithms/algorithm_mixin.dart';
import 'package:webspark_task/models/point.dart';
import 'package:webspark_task/models/solution.dart';
import 'package:webspark_task/models/solution_result.dart';
import 'package:webspark_task/models/task.dart';

class BreadthFirstSearch with AlrorithmMixin {
  final List<Point> _moves = [
    Point(x: -1, y: -1), // up-left
    Point(x: -1, y: 0), // up
    Point(x: 1, y: -1), // up-right
    Point(x: 0, y: 1), // right
    Point(x: 1, y: 1), // down-right
    Point(x: 1, y: 0), // down
    Point(x: -1, y: 1), // down-left
    Point(x: 0, y: -1), // left
  ];

  @override
  Solution execute(Task task) {
    final matrix = List<List<Point>>.empty(growable: true);

    for (int i = 0; i < task.field.length; i++) {
      matrix.add(List<Point>.empty(growable: true));
      final symbols = task.field[i].split('');

      for (int j = 0; j < symbols.length; j++) {
        matrix[i].add(Point(x: i, y: j, sybmol: symbols[j]));
      }
    }

    matrix[task.start!.y][task.start!.x].symbol = 'S';
    matrix[task.end!.y][task.end!.x].symbol = 'F';

    final solution = _runAlgorithm(matrix, task.start!, task.end!);

    if (solution.length > 2) {
      for (var point in solution.sublist(1, solution.length - 1)) {
        matrix[point.y][point.x].symbol = 'P';
      }
    }

    return Solution(
        task: task,
        result: SolutionResult(
          path: solution.map((point) => point.toString()).join('->'),
          steps: solution,
          fullDesk: matrix,
        ));
  }

  bool _isValid(
      int x, int y, List<List<Point>> matrix, List<List<bool>> visited) {
    return (y >= 0 && y < matrix.length) &&
        (x >= 0 && x < matrix[0].length) &&
        matrix[y][x].symbol != 'X' &&
        !visited[y][x];
  }

  List<Point> _runAlgorithm(
      List<List<Point>> matrix, Point start, Point finish) {
    final visited = List.generate(
        matrix.length, (_) => List.filled(matrix[0].length, false));
    final pointsQueue = Queue<Point>();
    final previous = <Point, Point>{};

    pointsQueue.add(start);
    visited[start.y][start.x] = true;

    while (pointsQueue.isNotEmpty) {
      final curr = pointsQueue.removeFirst();

      if (curr.x == finish.x && curr.y == finish.y) {
        break;
      }

      for (var move in _moves) {
        final x = curr.x + move.x;
        final y = curr.y + move.y;

        if (_isValid(x, y, matrix, visited)) {
          Point nextPoint = Point(x: x, y: y);
          pointsQueue.add(Point(x: x, y: y));
          visited[y][x] = true;
          previous[nextPoint] = curr;
        }
      }
    }

    final path = List<Point>.empty(growable: true);
    Point? curr = finish;
    while (curr != null) {
      path.add(curr);
      curr = previous[curr];
    }

    return path.reversed.toList();
  }
}

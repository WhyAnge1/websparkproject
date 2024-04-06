import 'package:webspark_task/models/point.dart';

class SolutionResult {
  List<Point> steps;
  String path;
  List<List<Point>> fullDesk;

  SolutionResult({
    required this.steps,
    required this.path,
    List<List<Point>>? fullDesk,
  }) : fullDesk = fullDesk ?? [];

  factory SolutionResult.fromJson(Map<String, dynamic> json) {
    return SolutionResult(
      steps: (json['steps'] as List)
          .map((e) => Point.fromJson(e as Map<String, dynamic>))
          .toList(),
      path: json['path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'steps': steps.map((e) => e.toJson()).toList(),
      'path': path,
    };
  }
}

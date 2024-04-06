import 'package:webspark_task/models/solution_result.dart';
import 'package:webspark_task/models/task.dart';

class Solution {
  SolutionResult result;
  Task? task;

  String get id => task?.id ?? '';

  Solution({
    required this.result,
    required this.task,
  });

  factory Solution.fromJson(Map<String, dynamic> json) {
    return Solution(
      result: SolutionResult.fromJson(json['result']),
      task: null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'result': result.toJson(),
    };
  }
}

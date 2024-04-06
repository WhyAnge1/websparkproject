import 'package:webspark_task/models/task.dart';

class WebsparkResult {
  final bool error;
  final String message;
  final List<Task> data;

  WebsparkResult({
    required this.error,
    required this.message,
    required this.data,
  });

  factory WebsparkResult.fromJson(Map<String, dynamic> json) {
    return WebsparkResult(
      error: json['error'],
      message: json['message'],
      data: (json['data'] as List)
          .map((e) => Task.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'error': error,
      'message': message,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

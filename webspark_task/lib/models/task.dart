import 'package:webspark_task/models/point.dart';

class Task {
  final String id;
  final List<String> field;
  final Point? start;
  final Point? end;

  Task({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        id: json['id'],
        field: json['field'].cast<String>(),
        start: json['start'] != null ? Point.fromJson(json['start']) : null,
        end: json['end'] != null ? Point.fromJson(json['end']) : null);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'field': field,
      'start': start?.toJson(),
      'end': end?.toJson(),
    };
  }
}

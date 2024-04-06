import 'package:flutter/material.dart';
import 'package:webspark_task/main.dart';
import 'package:webspark_task/models/task.dart';
import 'package:webspark_task/services/task_service.dart';

class TaskProvider extends ChangeNotifier {
  final _taskService = getIt<TaskService>();

  List<Task> _tasks = [];
  bool _isLoading = false;
  String? _errorText;

  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;
  String? get errorText => _errorText;

  Future getAllTasks(String url) async {
    _errorText = null;
    _tasks = [];

    if (url.isEmpty) {
      _errorText = 'Url is required.';
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    final result = await _taskService.getTasks(url);

    if (result.hasResult) {
      _tasks = result.result!;
    } else {
      _errorText = 'Failed to load tasks. Check you Url and try again.';
    }

    _isLoading = false;
    notifyListeners();
  }
}

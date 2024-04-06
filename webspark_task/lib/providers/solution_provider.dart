import 'package:flutter/material.dart';
import 'package:webspark_task/main.dart';
import 'package:webspark_task/models/solution.dart';
import 'package:webspark_task/models/task.dart';
import 'package:webspark_task/services/solution_service.dart';

class SolutionProvider extends ChangeNotifier {
  final _solutionService = getIt<SolutionService>();

  List<Solution> _solutions = [];
  bool _isLoading = false;
  double _calculationsProgress = 0;
  String _errorMessage = '';

  List<Solution> get solutions => _solutions;
  bool get isLoading => _isLoading;
  double get calculationsProgress => _calculationsProgress;
  bool get hasFinishCalculations => _calculationsProgress == 100;
  String get errorMessage => _errorMessage;

  void calculateSolution(List<Task> tasks) {
    _calculationsProgress = 1;
    notifyListeners();

    _solutionService.calculateSolutions(tasks).listen(
      (event) {
        _calculationsProgress = (event.length * 100) / tasks.length;
        _solutions = event;
        notifyListeners();
      },
    );
  }

  Future sendResultsToServer() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    var result = await _solutionService.postSolutions(solutions);

    if (result.isFailed) {
      _errorMessage =
          'Something went wrong while we were sending data to the server. Please try again.';
    }

    _isLoading = false;
    notifyListeners();
  }
}

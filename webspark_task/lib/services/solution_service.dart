import 'package:webspark_task/algorithms/breadth_first_search.dart';
import 'package:webspark_task/common/resut.dart';
import 'package:webspark_task/common/user_settings.dart';
import 'package:webspark_task/main.dart';
import 'package:webspark_task/models/solution.dart';
import 'package:webspark_task/models/task.dart';
import 'package:webspark_task/network/api_client.dart';

class SolutionService {
  final _apiClient = getIt<ApiClient>();
  final _userSettings = getIt<UserSettings>();

  final _breadthFirstSearch = BreadthFirstSearch();

  Future<Result> postSolutions(List<Solution> solutions) async {
    final apiResult = await _apiClient.post(solutions, _userSettings.serverUrl);

    if (apiResult.isSucceed) {
      return Result.fromSuccess();
    } else {
      return Result.fromError(apiResult.occurredError);
    }
  }

  Stream<List<Solution>> calculateSolutions(List<Task> tasks) async* {
    final solutions = List<Solution>.empty(growable: true);

    for (final task in tasks) {
      solutions.add(_breadthFirstSearch.execute(task));
      yield solutions;
    }

    yield solutions;
  }
}

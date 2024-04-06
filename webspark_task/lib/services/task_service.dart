import 'package:webspark_task/common/resut.dart';
import 'package:webspark_task/common/user_settings.dart';
import 'package:webspark_task/main.dart';
import 'package:webspark_task/models/task.dart';
import 'package:webspark_task/models/webspark_result.dart';
import 'package:webspark_task/network/api_client.dart';

class TaskService {
  final _apiClient = getIt<ApiClient>();
  final _userSettings = getIt<UserSettings>();

  Future<Result<List<Task>>> getTasks(String url) async {
    final apiResult = await _apiClient.get(url);

    if (apiResult.isSucceed &&
        apiResult.result?.data != null &&
        apiResult.result!.data is Map<String, dynamic>) {
      final websparkResult = WebsparkResult.fromJson(apiResult.result!.data);

      _userSettings.serverUrl = url;

      return Result.fromResult(websparkResult.data);
    } else {
      return Result.fromError(apiResult.occurredError);
    }
  }
}

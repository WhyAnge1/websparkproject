import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:webspark_task/common/app_colors.dart';
import 'package:webspark_task/common/user_settings.dart';
import 'package:webspark_task/network/api_client.dart';
import 'package:webspark_task/providers/solution_provider.dart';
import 'package:webspark_task/providers/task_provider.dart';
import 'package:webspark_task/services/solution_service.dart';
import 'package:webspark_task/services/task_service.dart';

import 'pages/home_page.dart';

final getIt = GetIt.instance;

void main() {
  registerDependencies();

  runApp(const MyApp());
}

void registerDependencies() {
  getIt.registerSingleton(UserSettings());
  getIt.registerSingleton(ApiClient());
  getIt.registerSingleton(TaskService());
  getIt.registerSingleton(SolutionService());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskProvider()),
        ChangeNotifierProvider(create: (context) => SolutionProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primaryColor,
          ),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webspark_task/common/app_colors.dart';
import 'package:webspark_task/pages/process_page.dart';
import 'package:webspark_task/providers/task_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _urlFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Home screen',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textSecondaryColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Consumer<TaskProvider>(
          builder: (context, provider, child) {
            return Stack(
              children: [
                Center(
                  child: Visibility(
                    visible: provider.isLoading,
                    child: const CircularProgressIndicator(),
                  ),
                ),
                Opacity(
                  opacity: provider.isLoading ? 0.5 : 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Set valid API base URL in order to continue',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.compare_arrows),
                              const SizedBox(width: 25),
                              Expanded(
                                child: TextFormField(
                                  controller: _urlFieldController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter API base URL',
                                    errorText: provider.errorText,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: provider.isLoading
                            ? null
                            : () => _onStartCountingPressed(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.buttonBackgroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                              color: AppColors.primaryColor,
                              width: 2,
                            ),
                          ),
                        ),
                        child: const Text(
                          'Start counting process',
                          style: TextStyle(
                            color: AppColors.textPrimaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _onStartCountingPressed(BuildContext context) async {
    final provider = Provider.of<TaskProvider>(context, listen: false);

    await provider.getAllTasks(_urlFieldController.text);

    if (context.mounted && provider.tasks.isNotEmpty) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ProcessPage()));
    }
  }
}

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webspark_task/common/app_colors.dart';
import 'package:webspark_task/pages/result_list_page.dart';
import 'package:webspark_task/providers/solution_provider.dart';
import 'package:webspark_task/providers/task_provider.dart';

class ProcessPage extends StatefulWidget {
  const ProcessPage({super.key});

  @override
  State createState() => _ProcessPageState();
}

class _ProcessPageState extends State<ProcessPage>
    with AfterLayoutMixin<ProcessPage> {
  @override
  void afterFirstLayout(BuildContext context) {
    final solutionProvider =
        Provider.of<SolutionProvider>(context, listen: false);
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      solutionProvider.calculateSolution(taskProvider.tasks);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Process screen',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textSecondaryColor,
          ),
        ),
        iconTheme: const IconThemeData(
          color: AppColors.textSecondaryColor,
        ),
      ),
      body: Consumer<SolutionProvider>(
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 15),
                            child: Text(
                              provider.hasFinishCalculations
                                  ? 'All calculations have finished, you can send your results to the server'
                                  : 'Please wait until we finish all calculations',
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '${provider.calculationsProgress.toStringAsFixed(0)}%',
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 6),
                          const Divider(),
                          const SizedBox(height: 6),
                          SizedBox(
                            width: 130,
                            height: 130,
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                              value: provider.calculationsProgress / 100,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: provider.hasFinishCalculations,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: ElevatedButton(
                          onPressed: provider.isLoading
                              ? null
                              : () => _onSenResultsPressed(context),
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
                            'Send results to server',
                            style: TextStyle(
                              color: AppColors.textPrimaryColor,
                            ),
                          ),
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
    );
  }

  void _onSenResultsPressed(BuildContext context) async {
    final provider = Provider.of<SolutionProvider>(context, listen: false);

    await provider.sendResultsToServer();

    if (provider.errorMessage.isNotEmpty && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(provider.errorMessage),
        ),
      );
    } else if (context.mounted) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ResultListPage()));
    }
  }
}

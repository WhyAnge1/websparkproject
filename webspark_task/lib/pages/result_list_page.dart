import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webspark_task/common/app_colors.dart';
import 'package:webspark_task/models/solution.dart';
import 'package:webspark_task/pages/preview_page.dart';
import 'package:webspark_task/providers/solution_provider.dart';

class ResultListPage extends StatefulWidget {
  const ResultListPage({super.key});

  @override
  State createState() => _ResultListPageState();
}

class _ResultListPageState extends State<ResultListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Result list screen',
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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: provider.solutions.length,
                  itemBuilder: (context, index) {
                    final solution = provider.solutions[index];
                    return GestureDetector(
                      onTap: () => _onCellPressed(context, solution),
                      child: ListTile(
                        title: Align(
                          alignment: Alignment.center,
                          child: Text(
                            solution.result.path,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _onCellPressed(BuildContext context, Solution selectedSolution) async {
    if (context.mounted) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PreviewPage(
                    selectedSolution: selectedSolution,
                  )));
    }
  }
}

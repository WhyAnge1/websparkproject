import 'package:flutter/material.dart';
import 'package:webspark_task/common/app_colors.dart';
import 'package:webspark_task/controls/solution_table.dart';
import 'package:webspark_task/models/solution.dart';

class PreviewPage extends StatefulWidget {
  final Solution selectedSolution;

  const PreviewPage({super.key, required this.selectedSolution});

  @override
  State createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Preview screen',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textSecondaryColor,
          ),
        ),
        iconTheme: const IconThemeData(
          color: AppColors.textSecondaryColor,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: FractionallySizedBox(
              alignment: Alignment.topCenter,
              heightFactor: 1,
              child: SolutionTable(
                desk: widget.selectedSolution.result.fullDesk,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Flexible(
            child: Container(
              alignment: Alignment.topCenter,
              child: Text(
                widget.selectedSolution.result.path,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

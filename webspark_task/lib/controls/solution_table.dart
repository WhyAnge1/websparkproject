import 'package:flutter/material.dart';
import 'package:webspark_task/common/app_colors.dart';
import 'package:webspark_task/models/point.dart';

class SolutionTable extends StatelessWidget {
  final List<List<Point>> desk;

  const SolutionTable({super.key, required this.desk});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Table(
        border: TableBorder.all(),
        children: desk.map((row) {
          return TableRow(
            children: row.map((point) {
              return Container(
                height: constraints.maxHeight / desk.length,
                alignment: Alignment.center,
                color: _getCellColor(point.symbol),
                child: Text(
                  point.toString(),
                  style: TextStyle(
                    fontSize: 13,
                    color: point.symbol == 'X'
                        ? AppColors.textSecondaryColor
                        : AppColors.textPrimaryColor,
                  ),
                ),
              );
            }).toList(),
          );
        }).toList(),
      );
    });
  }

  Color _getCellColor(String symbol) {
    switch (symbol) {
      case '.':
        return AppColors.emptyPointColor;
      case 'X':
        return AppColors.disabledPointColor;
      case 'S':
        return AppColors.startPointColor;
      case 'F':
        return AppColors.finalPointColor;
      case 'P':
        return AppColors.pathPointColor;
      default:
        return Colors.white;
    }
  }
}

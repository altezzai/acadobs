import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class DashboardTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dataMap = {"Presents": 23.0, "Late": 7.0, "Absent": 3.0};
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Attendance",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 60),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: PieChart(
              dataMap: dataMap,
              chartType: ChartType.disc,
              colorList: [Colors.green, Colors.orange, Colors.red],
              legendOptions: LegendOptions(
                showLegends: true,
                legendPosition: LegendPosition.right,
              ),
              chartValuesOptions: ChartValuesOptions(
                showChartValues: true,
                showChartValuesInPercentage: true,
              ),
              ringStrokeWidth: 40,
            ),
          ),
        ],
      ),
    );
  }
}

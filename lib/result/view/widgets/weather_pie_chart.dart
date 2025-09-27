import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'legend_item.dart';

class WeatherPieChart extends StatelessWidget {
  final double temperature;
  final double humidity;
  final double rain;

  const WeatherPieChart({
    super.key,
    required this.temperature,
    required this.humidity,
    required this.rain,
  });

  @override
  Widget build(BuildContext context) {
    final total = temperature + humidity + rain;

    List<PieChartSectionData> sections = [];
    if (total > 0) {
      sections = [
        PieChartSectionData(
          value: temperature,
          color: Colors.redAccent,
          title: "${((temperature / total) * 100).toStringAsFixed(1)}%",
          radius: 60,
          titleStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        PieChartSectionData(
          value: humidity,
          color: Colors.blueAccent,
          title: "${((humidity / total) * 100).toStringAsFixed(1)}%",
          radius: 60,
          titleStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        PieChartSectionData(
          value: rain,
          color: Colors.teal,
          title: "${((rain / total) * 100).toStringAsFixed(1)}%",
          radius: 60,
          titleStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ];
    }

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                "📊 Relative Analysis (Pie Chart)",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 250,
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 4,
                    centerSpaceRadius: 40,
                    borderData: FlBorderData(show: false),
                    sections: sections,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 16,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: const [
                  LegendItem(color: Colors.redAccent, label: 'Temperature'),
                  LegendItem(color: Colors.blueAccent, label: 'Humidity'),
                  LegendItem(color: Colors.teal, label: 'Rain'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

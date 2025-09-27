import 'package:flutter/material.dart';
import 'package:terra_tech_weather_wise/data/weather_prediction.dart';
import 'package:terra_tech_weather_wise/data/weather_service.dart';
import 'package:terra_tech_weather_wise/result/view/weather_details_page.dart';

class DayAnalysis extends StatefulWidget {
  const DayAnalysis({super.key});

  @override
  State<DayAnalysis> createState() => _DayAnalysisState();
}

class _DayAnalysisState extends State<DayAnalysis> {
  final WeatherService _weatherService = WeatherService();

  WeatherPrediction? prediction;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final result = await _weatherService.fetchPredictionByDate("2025-09-26");
    setState(() {
      prediction = result;
      isLoading = false;
    });
  }

  final Map<String, dynamic> data = {
    'date': '2025-09-26',
    'pred_temperature': 29.28,
    'pred_Humidity': 47.61,
    'pred_rain_mm': 0.0262,
    'advice': '✅ مناسب للخروج',
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WeatherDetailsPage(data: data),
            ),
          );
        },
        borderRadius: BorderRadius.circular(24),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                blurRadius: 8,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          height: 200,
          width: 300,
          padding: const EdgeInsets.all(16.0),
          child:
              // (isLoading)
              //     ? const Center(child: CircularProgressIndicator())
              //     :
              // (prediction == null)
              //     ? const Center(child: Text("❌ فشل في تحميل البيانات"))
              //     :
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['date']!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.thermostat, color: Colors.redAccent),
                      const SizedBox(width: 8),
                      Text(
                        "Temperature: ${data['pred_temperature']}°",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.tips_and_updates, color: Colors.green),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          data['advice']!,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "See more →",
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                ],
              ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:terra_tech_weather_wise/data/weather_prediction.dart';
import 'package:terra_tech_weather_wise/data/weather_service.dart';
import 'package:terra_tech_weather_wise/result/view/weather_details_page.dart';

class DayAnalysis extends StatefulWidget {
  final String date; // 🟢 التاريخ اللي هيجيلنا من برّا

  const DayAnalysis({super.key, required this.date});

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
    _loadData(); // 🟡 تحميل البيانات عند التشغيل
  }

  Future<void> _loadData() async {
    final result = await _weatherService.fetchPredictionByDate(widget.date);
    setState(() {
      prediction = result;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: InkWell(
        onTap: () {
          if (prediction != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WeatherDetailsPage(
                  data: {
                    'date': prediction!.date,
                    'pred_temperature': prediction!.predTemperature,
                    'pred_Humidity': prediction!.predHumidity,
                    'pred_rain_mm': prediction!.predRainMm,
                    'advice': prediction!.advice,
                  },
                ),
              ),
            );
          }
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
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (prediction == null) {
      return const Center(child: Text("❌ فشل في تحميل البيانات"));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          prediction!.date,
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
              "Temperature: ${prediction!.predTemperature}°",
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
                prediction!.advice,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
        const Spacer(),
        const Align(
          alignment: Alignment.bottomRight,
          child: Text("See more →", style: TextStyle(color: Colors.blueAccent)),
        ),
      ],
    );
  }
}

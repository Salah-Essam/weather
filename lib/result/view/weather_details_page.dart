import 'package:flutter/material.dart';
import 'widgets/date_advice_card.dart';
import 'widgets/info_card.dart';
import 'widgets/weather_pie_chart.dart';

class WeatherDetailsPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const WeatherDetailsPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final double temperature = data['pred_temperature'];
    final double humidity = data['pred_Humidity'];
    final double rain = data['pred_rain_mm'];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather details"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF000000), Color(0xFF0549c9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              DateAdviceCard(date: data['date'], advice: data['advice']),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InfoCard(
                    icon: Icons.thermostat,
                    color: Colors.redAccent,
                    title: 'Temperature',
                    value: '$temperature°C',
                  ),
                  InfoCard(
                    icon: Icons.water_drop,
                    color: Colors.blueAccent,
                    title: 'Humidity',
                    value: '$humidity%',
                  ),
                  InfoCard(
                    icon: Icons.cloud,
                    color: Colors.teal,
                    title: 'Rain',
                    value: '${rain.toStringAsFixed(3)} mm',
                  ),
                ],
              ),

              const SizedBox(height: 24),

              WeatherPieChart(
                temperature: temperature,
                humidity: humidity,
                rain: rain,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'widgets/date_advice_card.dart';
import 'widgets/info_card.dart';
import 'widgets/weather_pie_chart.dart';

class WeatherDetailsPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const WeatherDetailsPage({super.key, required this.data});

  String _getWeatherBackground(Map<String, dynamic> data) {
    final double temp = data['pred_temperature'];
    final double humidity = data['pred_Humidity'];
    final double rain = data['pred_rain_mm'];
    final String advice = data['advice'].toString().toLowerCase();

    if (advice.contains('rain')) {
      return 'assets/rainy.jpg';
    } else if (advice.contains('cloud')) {
      return 'assets/cloudy.jpg';
    } else if (advice.contains('sunny') || advice.contains('hot')) {
      return 'assets/sunny.jpg';
    } else if (advice.contains('cold')) {
      return 'assets/cold.jpg';
    }

    if (rain > 1) {
      return 'assets/rainy.jpg';
    } else if (rain > 0.1 && rain <= 1) {
      return 'assets/cloudy.jpg';
    } else if (temp >= 25 && humidity < 60 && rain < 0.1) {
      return 'assets/sunny.jpg';
    } else if (temp < 20) {
      return 'assets/cold.jpg';
    } else {
      return 'assets/cloudy.jpg';
    }
  }

  @override
  Widget build(BuildContext context) {
    final double temperature = data['pred_temperature'];
    final double humidity = data['pred_Humidity'];
    final double rain = data['pred_rain_mm'];
    final backgroundImage = _getWeatherBackground(data);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "Weather Details",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(121, 144, 144, 144),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(backgroundImage, fit: BoxFit.cover),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 700;

              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 100, 16, 24),
                child: isWide
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          WeatherPieChart(
                            temperature: temperature,
                            humidity: humidity,
                            rain: rain,
                          ),

                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                DateAdviceCard(
                                  date: data['date'],
                                  advice: data['advice'],
                                ),
                                const SizedBox(height: 24),

                                InfoCard(
                                  icon: Icons.thermostat,
                                  color: Colors.redAccent,
                                  title: 'Temperature',
                                  value: temperature,
                                  unit: '°C',
                                  maxValue: 45,
                                ),
                                InfoCard(
                                  icon: Icons.water_drop,
                                  color: Colors.blueAccent,
                                  title: 'Humidity',
                                  value: humidity,
                                  unit: '%',
                                  maxValue: 100,
                                ),
                                InfoCard(
                                  icon: Icons.cloud,
                                  color: Colors.teal,
                                  title: 'Rain',
                                  value: rain,
                                  unit: 'mm',
                                  maxValue: 5,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            DateAdviceCard(
                              date: data['date'],
                              advice: data['advice'],
                            ),
                            const SizedBox(height: 24),
                            Wrap(
                              spacing: 16,
                              runSpacing: 16,
                              alignment: WrapAlignment.center,
                              children: [
                                InfoCard(
                                  icon: Icons.thermostat,
                                  color: Colors.redAccent,
                                  title: 'Temperature',
                                  value: temperature, // 👈 double مباشرة
                                  unit: '°C',
                                  maxValue: 45, // أقصى درجة حرارة ممكنة
                                ),
                                InfoCard(
                                  icon: Icons.water_drop,
                                  color: Colors.blueAccent,
                                  title: 'Humidity',
                                  value: humidity, // 👈 double مباشرة
                                  unit: '%',
                                  maxValue: 100, // أقصى نسبة رطوبة
                                ),
                                InfoCard(
                                  icon: Icons.cloud,
                                  color: Colors.teal,
                                  title: 'Rain',
                                  value: rain, // 👈 double مباشرة
                                  unit: 'mm',
                                  maxValue: 5, // أقصى معدل مطر متوقع
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),
                            WeatherPieChart(
                              temperature: temperature,
                              humidity: humidity,
                              rain: rain,
                            ),
                          ],
                        ),
                      ),
              );
            },
          ),
        ],
      ),
    );
  }
}

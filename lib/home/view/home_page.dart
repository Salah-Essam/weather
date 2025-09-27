import 'package:flutter/material.dart';
import 'package:terra_tech_weather_wise/data/weather_prediction.dart';
import 'package:terra_tech_weather_wise/data/weather_service.dart';
import 'package:terra_tech_weather_wise/home/view/widgets/analyze_button.dart';
import 'package:terra_tech_weather_wise/home/view/widgets/date_picker_card.dart';
import 'package:terra_tech_weather_wise/home/view/widgets/day_anlaysis.dart';
import 'package:terra_tech_weather_wise/result/view/weather_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();

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

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2005),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather Analysis',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1b2b85),
        foregroundColor: Colors.white,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF000000), Color(0xFF0549c9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Center(
            child: Column(
              children: [
                Wrap(
                  alignment: WrapAlignment.center,
                  runSpacing: 24.0,
                  spacing: 64.0,
                  children: [
                    Container(
                      height: 300,
                      width: 300,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black45,
                            blurRadius: 10,
                            offset: Offset(5, 5),
                            spreadRadius: 2,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          'assets/icon.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        DatePickerCard(
                          selectedDate: _selectedDate,
                          onSelectDate: _selectDate,
                        ),
                        const SizedBox(height: 24),
                        AnalyzeButton(
                          isLoading: false,
                          onAnalyze: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    WeatherDetailsPage(data: data),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Wrap(children: [DayAnalysis(), DayAnalysis(), DayAnalysis()]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

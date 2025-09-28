import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  bool isLoading = false;

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
    final dateFormat = DateFormat('yyyy-MM-dd');
    final today = dateFormat.format(DateTime.now());
    final tomorrow = dateFormat.format(
      DateTime.now().add(const Duration(days: 1)),
    );
    final afterTomorrow = dateFormat.format(
      DateTime.now().add(const Duration(days: 2)),
    );

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          // طبقة شفافة بسيطة فوق الخلفية
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.3)),
          child: Padding(
            padding: const EdgeInsets.only(top: 32),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
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
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(5, 5),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
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
                              isLoading: isLoading,
                              onAnalyze: () async {
                                setState(() => isLoading = true);

                                final formattedDate = DateFormat(
                                  'dd-MM-yyyy',
                                ).format(_selectedDate);
                                final result = await _weatherService
                                    .fetchPredictionByDate(formattedDate);
                                setState(() => isLoading = false);

                                if (result != null) {
                                  final data = {
                                    'date': result.date,
                                    'pred_temperature': result.predTemperature,
                                    'pred_Humidity': result.predHumidity,
                                    'pred_rain_mm': result.predRainMm,
                                    'advice': result.advice,
                                  };

                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          WeatherDetailsPage(data: data),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Can't load data, please try again.",
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        DayAnalysis(date: today),
                        DayAnalysis(date: tomorrow),
                        DayAnalysis(date: afterTomorrow),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

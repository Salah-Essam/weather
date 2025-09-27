class WeatherPrediction {
  final String date;
  final double predTemperature;
  final double predHumidity;
  final double predRainMm;
  final String advice;

  WeatherPrediction({
    required this.date,
    required this.predTemperature,
    required this.predHumidity,
    required this.predRainMm,
    required this.advice,
  });

  factory WeatherPrediction.fromJson(Map<String, dynamic> json) {
    return WeatherPrediction(
      date: json['date'] ?? '',
      predTemperature: (json['pred_temperature'] ?? 0).toDouble(),
      predHumidity: (json['pred_Humidity'] ?? 0).toDouble(),
      predRainMm: (json['pred_rain_mm'] ?? 0).toDouble(),
      advice: json['advice'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'pred_temperature': predTemperature,
      'pred_Humidity': predHumidity,
      'pred_rain_mm': predRainMm,
      'advice': advice,
    };
  }
}

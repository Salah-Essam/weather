import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../data/weather_prediction.dart';

class WeatherService {
  final String baseUrl = "https://example.com/api"; // 🟡 غيّرها لـ API الحقيقي

  Future<WeatherPrediction?> fetchPredictionByDate(String date) async {
    try {
      final url = Uri.parse('$baseUrl/weather?date=$date');
      debugPrint("🌍 Fetching from: $url");

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        debugPrint("✅ Success: $data");

        return WeatherPrediction.fromJson(data);
      } else {
        debugPrint("❌ Error: ${response.statusCode}, body: ${response.body}");
      }
    } catch (e) {
      debugPrint("⚠️ Exception: $e");
    }
    return null;
  }
}

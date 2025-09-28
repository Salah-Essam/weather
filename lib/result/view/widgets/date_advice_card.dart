import 'package:flutter/material.dart';

class DateAdviceCard extends StatelessWidget {
  final String date;
  final String advice;

  const DateAdviceCard({super.key, required this.date, required this.advice});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withAlpha(130),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          children: [
            Text(
              "📅 $date",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "💡 $advice",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

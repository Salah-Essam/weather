import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final double value;
  final String unit;
  final double maxValue;

  const InfoCard({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.value,
    required this.unit,
    required this.maxValue,
  });

  /// 🧠 دالة تحدد النص التوضيحي حسب القيمة
  String _getDescription() {
    double percent = value / maxValue;

    if (title.toLowerCase().contains('temp')) {
      if (percent >= 0.75) return "درجة حرارة مرتفعة 🔥";
      if (percent >= 0.4) return "درجة حرارة معتدلة 🌤️";
      return "درجة حرارة منخفضة ❄️";
    }

    if (title.toLowerCase().contains('humid')) {
      if (percent >= 0.75) return "رطوبة عالية 💧";
      if (percent >= 0.4) return "رطوبة معتدلة 🌫️";
      return "رطوبة منخفضة 🌵";
    }

    if (title.toLowerCase().contains('rain')) {
      if (percent >= 0.75) return "احتمال مرتفع للأمطار ⛈️";
      if (percent >= 0.4) return "احتمال متوسط للأمطار 🌦️";
      return "احتمال ضعيف للأمطار ☀️";
    }

    return "قيمة معتدلة 🌤️";
  }

  @override
  Widget build(BuildContext context) {
    double percent = (value / maxValue).clamp(0.0, 1.0);

    return Card(
      color: Colors.white.withOpacity(0.3),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: 350,
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 🔹 العمود الأول: الأيقونة + العنوان + القيمة
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: color, size: 40),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "${value.toStringAsFixed(1)} $unit",
                  style: const TextStyle(fontSize: 15, color: Colors.white70),
                ),
              ],
            ),

            const Spacer(),

            // 🔹 العمود الثاني: المؤشر + التفسير
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: percent,
                      minHeight: 10,
                      backgroundColor: Colors.white.withOpacity(0.2),
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _getDescription(),
                    style: const TextStyle(fontSize: 13, color: Colors.white70),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

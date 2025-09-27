import 'package:flutter/material.dart';

class AnalyzeButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onAnalyze;

  const AnalyzeButton({
    super.key,
    required this.isLoading,
    required this.onAnalyze,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ElevatedButton.icon(
        onPressed: isLoading ? null : onAnalyze,
        icon: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(Icons.analytics),
        label: Text(
          isLoading ? "Loading..." : "Weather analysis",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.yellow,
          foregroundColor: Colors.black,
        ),
      ),
    );
  }
}

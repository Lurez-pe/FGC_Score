import 'package:flutter/material.dart';

class ResultsDisplay extends StatelessWidget {
  final int score;
  final double distributionFactor;
  final double protectionMultiplier;
  final double coopertitionPoints;

  const ResultsDisplay({
    super.key,
    required this.score,
    required this.distributionFactor,
    required this.protectionMultiplier,
    required this.coopertitionPoints,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Color.fromARGB(75, 116, 12, 9),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'RESULTS',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 16),
            
            Center(
              child: Text(
                'Total Score: $score',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            
            const SizedBox(height: 20),
            
            const Text('Details:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Distribution Factor: ${distributionFactor.toStringAsFixed(4)}'),
            Text('Protection Multiplier: ${protectionMultiplier.toStringAsFixed(3)}'),
            Text('Cooperation Points: ${coopertitionPoints.toInt()}'),
          ],
        ),
      ),
    );
  }
}
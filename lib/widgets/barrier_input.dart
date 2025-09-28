import 'package:flutter/material.dart';

class BarrierInput extends StatelessWidget {
  final Function(int) onChanged;
  final int initialValue;

  const BarrierInput({
    super.key,
    required this.onChanged,
    required this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'BARRIERS MOVED',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text('Number of barriers moved to the mitigators'),
            const Text('Número de barreras movidas a los mitigadores'),
            const SizedBox(height: 12),
            Slider(
              value: initialValue.toDouble(),
              min: 0,
              max: 9,
              divisions: 9,
              label: initialValue.toString(),
              onChanged: (value) => onChanged(value.toInt()),
              //Perzonalización del color del slider
              activeColor: Color.fromARGB(255, 116, 12, 9),
              inactiveColor: Colors.grey[300],
              //thumbColor: Color.fromARGB(255, 116, 12, 9),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('0'),
                Text('$initialValue', style: const TextStyle(fontWeight: FontWeight.bold)),
                const Text('9'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
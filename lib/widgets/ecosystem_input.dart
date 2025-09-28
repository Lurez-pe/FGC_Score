import 'package:flutter/material.dart';

class EcosystemInput extends StatelessWidget {
  final Function(int) onFreshwaterChanged;
  final Function(int) onMarineChanged;
  final Function(int) onTerrestrialChanged;
  final int freshwaterValue;
  final int marineValue;
  final int terrestrialValue;

  const EcosystemInput({
    super.key,
    required this.onFreshwaterChanged,
    required this.onMarineChanged,
    required this.onTerrestrialChanged,
    required this.freshwaterValue,
    required this.marineValue,
    required this.terrestrialValue,
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
              'BIODIVERSITY POINTS',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text('Units added to each ecosystem at the end of the match'),
            const Text('Unidades añadidas a cada ecosistema al final del partido'),
            const SizedBox(height: 12),
            
            _buildEcosystemSlider('Fresh Water', freshwaterValue, onFreshwaterChanged),
            _buildEcosystemSlider('Marine', marineValue, onMarineChanged),
            _buildEcosystemSlider('Terrestrial', terrestrialValue, onTerrestrialChanged),
          ],
        ),
      ),
    );
  }

  Widget _buildEcosystemSlider(String label, int value, Function(int) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Slider(
          value: value.toDouble(),
          min: 0,
          max: 40,
          divisions: 40,
          label: value.toString(),
          onChanged: (val) => onChanged(val.toInt()),
          //Perzonalización del color del slider
          activeColor: Color.fromARGB(255, 116, 12, 9),
          inactiveColor: Colors.grey[300],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('0'),
            Text('$value', style: const TextStyle(fontWeight: FontWeight.bold)),
            const Text('40'),
          ],
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
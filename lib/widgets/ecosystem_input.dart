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
            
            _buildEcosystemControl('Fresh Water', freshwaterValue, onFreshwaterChanged),
            _buildEcosystemControl('Marine', marineValue, onMarineChanged),
            _buildEcosystemControl('Terrestrial', terrestrialValue, onTerrestrialChanged),
          ],
        ),
      ),
    );
  }

  Widget _buildEcosystemControl(String label, int value, Function(int) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
           label,
           style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          
          //FILA CON BOTON Y SLIDER
          Row(
            children: [

              //SLIDER
              Expanded(
                child: Slider(
                  value: value.roundToDouble(),
                  min: 0,
                  max: 40,
                  divisions: 40,
                  label: value.toString(),
                  onChanged: (value) => onChanged(value.toInt()),
                  activeColor: _getColorForEcosystem(label),
                  inactiveColor: Colors.grey[300],
                ),
              ),

              //BOTON DE RESTA
              _buildControlButton(
                icon : Icons.remove,
                onPressed: value > 0 ? () => onChanged(value - 1) : null,
                color: Colors.red[400],
              ),

              //MOSTRAR EL VALOR ACTUAL
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                  ),
                child: Center(
                  child: Text(
                    '$value',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      ),
                  ),
                )
              ),

              //BOTON DE SUMA
              _buildControlButton(
                icon: Icons.add,
                onPressed: value < 40 ? () => onChanged(value + 1) : null,
                color: Colors.green[400],
              ),

              const SizedBox(width: 2),

              
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$value',
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                    ),
                ),
                const Text(
                  '40',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                    ),
                ),
              ],
            ),
          ),
        ],
      ),
      );
  }

Widget _buildControlButton({
    required IconData icon,
    required VoidCallback? onPressed,
    required Color? color,
  }) {
    return Container(
      width: 30,
      height: 30,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: onPressed == null ? Colors.grey[300] : color,
        borderRadius: BorderRadius.circular(8),
        boxShadow: onPressed == null 
            ? null 
            : [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: IconButton(
        icon: Icon(
          icon,
          size: 18,
          color: onPressed == null ? Colors.grey[500] : Colors.white,
        ),
        onPressed: onPressed,
        padding: EdgeInsets.zero,
      ),
    );
  }

  Color _getColorForEcosystem(String ecosystem) {
    switch (ecosystem.toLowerCase()) {
      case 'freshwater':
        return Colors.blue[400]!;
      case 'marine':
        return Colors.blue[800]!;
      case 'terrestrial':
        return Colors.green[600]!;
      default:
        return Colors.blue;
    }
  }

}
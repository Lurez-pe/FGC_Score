import 'package:flutter/material.dart';

class RobotPositionSelector extends StatelessWidget {
  final Function(String) onRobotAChanged;
  final Function(String) onRobotBChanged;
  final Function(String) onRobotCChanged;
  final Function(int) onRobotsBalancedChanged;
  final String robotAPosition;
  final String robotBPosition;
  final String robotCPosition;
  final int robotsBalanced;

  const RobotPositionSelector({
    super.key,
    required this.onRobotAChanged,
    required this.onRobotBChanged,
    required this.onRobotCChanged,
    required this.onRobotsBalancedChanged,
    required this.robotAPosition,
    required this.robotBPosition,
    required this.robotCPosition,
    required this.robotsBalanced,
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
              'ROBOTS POSITION ON ROPE',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            
            _buildRobotSelector('Robot A', robotAPosition, onRobotAChanged),
            _buildRobotSelector('Robot B', robotBPosition, onRobotBChanged),
            _buildRobotSelector('Robot C', robotCPosition, onRobotCChanged),
            
            const SizedBox(height: 16),
            const Text('Number of ROBOTS BALANCED'),
            Slider(
              value: robotsBalanced.toDouble(),
              min: 0,
              max: 6,
              divisions: 6,
              label: robotsBalanced.toString(),
              onChanged: (value) => onRobotsBalancedChanged(value.toInt()),
              //Perzonalización del color del slider
              activeColor: Color.fromARGB(255, 116, 12, 9),
              inactiveColor: Colors.grey[300],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(7, (index) => Text('$index')),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRobotSelector(String label, String currentValue, Function(String) onChanged) {
    const positions = [
      'Not on ROPE',
      'LEVEL 1',
      'LEVEL 2',
      'LEVEL 3',
      'LEVEL 4',
    ];
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          DropdownButton<String>(
            value: currentValue,
            isExpanded: true,
            items: positions.map((position) {
              return DropdownMenuItem<String>(
                value: position,
                child: Text(position),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                onChanged(value);
              }
            },
          ),
        ],
      ),
    );
  }
}
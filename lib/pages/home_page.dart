import 'package:flutter/material.dart';
import '../models/scoring_model.dart';
import '../widgets/barrier_input.dart';
import '../widgets/ecosystem_input.dart';
import '../widgets/robot_position_selector.dart';
import '../widgets/results_display.dart';
import 'about_screen.dart'; 

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScoringModel _scoringModel = ScoringModel();

  void _updateBarriers(int value) {
    setState(() {
      _scoringModel.barriers = value;
    });
  }

  void _updateFreshwater(int value) {
    setState(() {
      _scoringModel.freshwaterBiodiversity = value;
    });
  }

  void _updateMarine(int value) {
    setState(() {
      _scoringModel.marineBiodiversity = value;
    });
  }

  void _updateTerrestrial(int value) {
    setState(() {
      _scoringModel.terrestrialBiodiversity = value;
    });
  }

  void _updateRobotAPosition(String position) {
    setState(() {
      _scoringModel.robotAPosition = position;
    });
  }

  void _updateRobotBPosition(String position) {
    setState(() {
      _scoringModel.robotBPosition = position;
    });
  }

  void _updateRobotCPosition(String position) {
    setState(() {
      _scoringModel.robotCPosition = position;
    });
  }

  void _updateRobotsBalanced(int count) {
    setState(() {
      _scoringModel.robotsBalanced = count;
    });
  }

  void _showPrivacyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Privacy Policy'),
          content: const SingleChildScrollView(
            child: Text(
              'This application does not collect or store any personal data. '
              'All calculations are performed locally on your device.\n\n'
              'We do not use cookies or tracking technologies.',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Understood'),
            ),
          ],
        );
      },
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Help'),
          content: const SingleChildScrollView(
            child: Text(
              'How to use the calculator:\n\n'
              '1. Adjust the number of barriers (0-9)\n'
              '2. Establishes biodiversity units for each ecosystem (0-40)\n'
              '3. Select the position of each robot\n'
              '4. Adjusts the number of balanced robots\n\n'
              'The score will be calculated automatically.\n\n'
              'For more information, visit the official FIRST Global website.',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          
          _buildDrawerHeader(),
          //_buildDrawerItem(
          //  icon: Icons.home,
          //  title: 'Home',
          //  onTap: () {
          //    Navigator.pop(context);
          //  },
          //),
          
          const Divider(),
          _buildDrawerItem(
            icon: Icons.info,
            title: 'About',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutScreen()),
              );
            },
          ),
          _buildDrawerItem(
            icon: Icons.privacy_tip,
            title: 'Privacy Policy',
            onTap: () {
              Navigator.pop(context);
              _showPrivacyDialog(context);
            },
          ),
          _buildDrawerItem(
            icon: Icons.help,
            title: 'Help',
            onTap: () {
              Navigator.pop(context);
              _showHelpDialog(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 116, 12, 9),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color.fromARGB(255, 116, 12, 9), Color.fromARGB(255, 90, 12, 9)],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Centrar verticalmente
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Imagen más pequeña
          Image.asset(
            'assets/images/eco-equilibrium.png',
            width: 60,  // Reducido de 80 a 60
            height: 60, // Reducido de 80 a 60
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.engineering,
                size: 50, // Icono más pequeño
                color: Colors.white,
              );
            },
          ),
          SizedBox(height: 10),
          Text(
            'FIRST Global',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Eco Equilibrium - 2025 Scorer',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Color.fromARGB(255, 116, 12, 9)),
      title: Text(title),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FIRST Global 2025 Scorer'
        //style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromRGBO(116, 12, 9, 0.9),
        foregroundColor: Colors.white,
      ),
      drawer: _buildDrawer(context),
      backgroundColor: Colors.grey[350],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Score Calculator\nEco Equilibrium Robotics Challenge',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            
            BarrierInput(
              onChanged: _updateBarriers,
              initialValue: _scoringModel.barriers,
            ),
            
            const SizedBox(height: 20),
            
            EcosystemInput(
              onFreshwaterChanged: _updateFreshwater,
              onMarineChanged: _updateMarine,
              onTerrestrialChanged: _updateTerrestrial,
              freshwaterValue: _scoringModel.freshwaterBiodiversity,
              marineValue: _scoringModel.marineBiodiversity,
              terrestrialValue: _scoringModel.terrestrialBiodiversity,
            ),
            
            const SizedBox(height: 20),
            
            RobotPositionSelector(
              onRobotAChanged: _updateRobotAPosition,
              onRobotBChanged: _updateRobotBPosition,
              onRobotCChanged: _updateRobotCPosition,
              onRobotsBalancedChanged: _updateRobotsBalanced,
              robotAPosition: _scoringModel.robotAPosition,
              robotBPosition: _scoringModel.robotBPosition,
              robotCPosition: _scoringModel.robotCPosition,
              robotsBalanced: _scoringModel.robotsBalanced,
            ),
            
            const SizedBox(height: 30),
            
            ResultsDisplay(
              score: _scoringModel.calculateTotalScore(),
              distributionFactor: _scoringModel.calculateDistributionFactor(),
              protectionMultiplier: _scoringModel.calculateProtectionMultiplier(),
              coopertitionPoints: ScoringModel.coopertitionPoints[_scoringModel.robotsBalanced] ?? 0.0,
            ),

            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                '© 2025 Ing. Luis Perez - v1.0.1\n TEAM PERU - FIRST Global 2025\n\n',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  String appVersion = '1.0.0';
  String appName = 'FIRST Global Scorer';

  @override
  void initState() {
    super.initState();
    _getPackageInfo();
  }

  Future<void> _getPackageInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = '${packageInfo.version} (${packageInfo.buildNumber})';
      appName = packageInfo.appName;
    });
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: SingleChildScrollView( // ¡ESTO ES LO QUE FALTABA!
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Image.asset(
            'assets/images/TEAM_PERU.png',
            width: 1800,  // Reducido de 80 a 60
            height: 180, // Reducido de 80 a 60
            fit: BoxFit.contain,),
            const SizedBox(height: 20),
            Text(
              appName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Versión: $appVersion',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Scoring Calculator\nFIRST Global Challenge 2025',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '© 2025 Team Peru\nAll rights reserved',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),
            _buildInfoCard(),
            const SizedBox(height: 20),
            _buildSocialButtons(),
            const SizedBox(height: 20),
            _buildAppInfo(),
            const SizedBox(height: 30), // Espacio adicional al final
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildInfoRow('Developer', 'Luis Enrique Pérez Pérez'),
            const Divider(),
            _buildInfoRow('Email', 'luis.perez@ucsm.edu.pe'),
            const Divider(),
            _buildInfoRow('Web', 'www.domingo-savio.edu.pe'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Flexible( // Para evitar overflow en textos largos
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButtons() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Connect with the developer',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.public, size: 30),
                  onPressed: () => _launchURL('https://domingo-savio.edu.pe/'),
                  tooltip: 'Visitar sitio web',
                ),
                IconButton(
                  icon: const Icon(Icons.email, size: 30),
                  onPressed: () => _launchURL('mailto:luis.perez@ucsm.edu.pe'),
                  tooltip: 'Enviar email',
                ),
                IconButton(
                  icon: const Icon(Icons.code, size: 30),
                  onPressed: () => _launchURL('https://github.com/Lurez-pe/FGC_Score'),
                  tooltip: 'Ver código fuente',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppInfo() {
    return const Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'App Information',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'This app is an unofficial calculator for the FIRST Global Challenge 2025. '
              'Results are approximate and should be verified with the official rules.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 10),
            Text(
              'Developed with Flutter and Dart',
              style: TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
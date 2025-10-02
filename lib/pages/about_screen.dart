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

  Future<void> _launchURL(String url, {String? fallbackUrl}) async {
    try {
      final Uri uri = Uri.parse(url);
      
      // Verificar si se puede lanzar la URL
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else if (fallbackUrl != null) {
        // Intentar con URL alternativa
        final Uri fallbackUri = Uri.parse(fallbackUrl);
        if (await canLaunchUrl(fallbackUri)) {
          await launchUrl(
            fallbackUri,
            mode: LaunchMode.externalApplication,
          );
        } else {
          _showSnackBar('No se pudo abrir el enlace. Verifica que tengas una aplicación compatible instalada.');
        }
      } else {
        _showSnackBar('No se pudo abrir el enlace. Verifica que tengas una aplicación compatible instalada.');
      }
    } catch (e) {
      _showSnackBar('Error al abrir enlace: $e');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Image.asset(
              'assets/images/TEAM PERU_2.png',
              width: 180,
              height: 180,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.flag,
                    size: 60,
                    color: Colors.grey,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Text(
              appName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Version: $appVersion',
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
            const SizedBox(height: 30),
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
            _buildInfoRow('Web', 'domingo-savio.edu.pe'),
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
          Flexible(
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
                _buildSocialButton(
                  icon: Icons.public,
                  label: 'Website',
                  onTap: () => _launchURL(
                    'https://domingo-savio.edu.pe/',
                    fallbackUrl: 'https://www.google.com/search?q=domingo+savio',
                  ),
                ),
                _buildSocialButton(
                  icon: Icons.email,
                  label: 'Email',
                  onTap: () => _launchURL(
                    'mailto:luis.perez@ucsm.edu.pe?subject=About%20FIRST%20Global%20Scorer%20App&body=Hello%20Luis,',
                    fallbackUrl: 'https://mail.google.com/mail/?view=cm&fs=1&to=luis.perez@ucsm.edu.pe&su=About FIRST Global Scorer App&body=Hello Luis,',
                  ),
                ),
                _buildSocialButton(
                  icon: Icons.code,
                  label: 'Source Code',
                  onTap: () => _launchURL(
                    'https://github.com/Lurez-pe/FGC_Score',
                    fallbackUrl: 'https://github.com',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Make sure you have a browser and email app installed',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, size: 30),
          onPressed: onTap,
          tooltip: label,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
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
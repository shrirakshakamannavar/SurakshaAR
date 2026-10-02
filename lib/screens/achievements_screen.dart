import 'package:flutter/material.dart';
import '../core/localization/app_localizations.dart';

class AchievementsScreen extends StatelessWidget {
  final String selectedLanguage;
  const AchievementsScreen({super.key, required this.selectedLanguage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.get(selectedLanguage, 'achievements'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.verified, color: Colors.amber, size: 40),
            title: Text(AppLocalizations.get(selectedLanguage, 'fire_title')),
            subtitle: const Text('Completed Module 1 with > 80% score'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shield, color: Colors.blue, size: 40),
            title: Text(AppLocalizations.get(selectedLanguage, 'gas_title')),
            subtitle: const Text('Completed Module 2 successfully'),
          ),
        ],
      ),
    );
  }
}
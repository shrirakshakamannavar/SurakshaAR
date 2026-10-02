import 'package:flutter/material.dart';
import '../core/localization/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  final String employeeId;
  final String traineeName;
  final String selectedLanguage;

  const ProfileScreen({
    super.key,
    required this.employeeId,
    required this.traineeName,
    required this.selectedLanguage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.get(selectedLanguage, 'profile'))),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const CircleAvatar(radius: 50, backgroundColor: Colors.green, child: Icon(Icons.person, size: 50, color: Colors.white)),
            const SizedBox(height: 15),
            Text(traineeName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('Badge ID: $employeeId', style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 30),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: Text(AppLocalizations.get(selectedLanguage, 'mine_location')),
              subtitle: const Text('Underground Sector - 4'),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(AppLocalizations.get(selectedLanguage, 'preferred_language')),
              subtitle: Text(selectedLanguage),
            ),
          ],
        ),
      ),
    );
  }
}
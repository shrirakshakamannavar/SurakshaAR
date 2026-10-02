import 'package:flutter/material.dart';
import '../core/localization/app_localizations.dart';
import 'module_detailed_screen.dart';

class ModulesScreen extends StatelessWidget {
  final String employeeId;
  final String selectedLanguage;

  const ModulesScreen({
    super.key,
    required this.employeeId,
    required this.selectedLanguage,
  });

  @override
  Widget build(BuildContext context) {
    final modules = [
      {'id': 'Module_1', 'title': AppLocalizations.get(selectedLanguage, 'fire_title'), 'icon': Icons.local_fire_department, 'color': Colors.orange},
      {'id': 'Module_2', 'title': AppLocalizations.get(selectedLanguage, 'gas_title'), 'icon': Icons.warning, 'color': Colors.amber},
      {'id': 'Module_3', 'title': AppLocalizations.get(selectedLanguage, 'machinery_title'), 'icon': Icons.settings, 'color': Colors.blue},
      {'id': 'Module_4', 'title': AppLocalizations.get(selectedLanguage, 'ppe_title'), 'icon': Icons.security, 'color': Colors.teal},
    ];

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.get(selectedLanguage, 'modules'))),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: modules.length,
        itemBuilder: (context, index) {
          final mod = modules[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Icon(mod['icon'] as IconData, color: mod['color'] as Color, size: 36),
              title: Text(mod['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ModuleDetailScreen(
                      employeeId: employeeId,
                      moduleId: mod['id'] as String,
                      moduleTitle: mod['title'] as String,
                      selectedLanguage: selectedLanguage,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
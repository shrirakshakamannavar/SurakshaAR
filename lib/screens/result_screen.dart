import 'package:flutter/material.dart';
import '../core/localization/app_localizations.dart';
import 'certificate_screen.dart';

class ResultScreen extends StatelessWidget {
  final String employeeId;
  final int score;
  final int correctCount;
  final int totalQuestions;
  final int timeElapsedSeconds;
  final String selectedLanguage;

  const ResultScreen({
    super.key,
    required this.employeeId,
    required this.score,
    required this.correctCount,
    required this.totalQuestions,
    required this.timeElapsedSeconds,
    required this.selectedLanguage,
  });

  String _formatTime(int seconds) {
    int mins = seconds ~/ 60;
    int secs = seconds % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    bool passed = score >= 70;

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.get(selectedLanguage, 'assessment'))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              passed ? AppLocalizations.get(selectedLanguage, 'module_completed') : 'Module Failed ❌',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: passed ? Colors.black : Colors.red),
            ),
            const SizedBox(height: 20),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(
                    value: score / 100,
                    strokeWidth: 8,
                    color: passed ? Colors.blue : Colors.red,
                    backgroundColor: Colors.grey[200],
                  ),
                ),
                Text('$score%', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              passed ? AppLocalizations.get(selectedLanguage, 'excellent') : 'Please review material and retry.',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: passed ? Colors.blue : Colors.red),
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppLocalizations.get(selectedLanguage, 'correct_answers')),
                        Text('$correctCount / $totalQuestions', style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppLocalizations.get(selectedLanguage, 'time_taken')),
                        Text(_formatTime(timeElapsedSeconds), style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            if (passed)
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.card_membership),
                label: Text(AppLocalizations.get(selectedLanguage, 'view_cert')),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CertificateScreen(
                        employeeId: employeeId,
                        name: 'Somra Murmu',
                        selectedLanguage: selectedLanguage,
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
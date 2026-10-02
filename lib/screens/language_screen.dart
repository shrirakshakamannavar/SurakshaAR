import 'package:flutter/material.dart';
import 'login_screen.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar with Skip Button
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(selectedLanguage: selectedLanguage),
                        ),
                      );
                    },
                    child: const Text('Skip >', style: TextStyle(color: Colors.grey, fontSize: 14)),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Titles
              const Center(
                child: Text(
                  'भाषा चुनें / Choose Language',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),

              // 1. English Option
              GestureDetector(
                onTap: () => setState(() => selectedLanguage = 'English'),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: selectedLanguage == 'English' ? const Color(0xFFE3F2FD) : const Color(0xFFF9F9F9),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selectedLanguage == 'English' ? Colors.blue.shade300 : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.language, color: Colors.blue),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('English', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            Text('English', style: TextStyle(fontSize: 13, color: Colors.grey)),
                          ],
                        ),
                      ),
                      Radio<String>(
                        value: 'English',
                        groupValue: selectedLanguage,
                        activeColor: Colors.blue,
                        onChanged: (val) => setState(() => selectedLanguage = val!),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // 2. Hindi Option
              GestureDetector(
                onTap: () => setState(() => selectedLanguage = 'Hindi'),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: selectedLanguage == 'Hindi' ? const Color(0xFFE8F5E9) : const Color(0xFFF9F9F9),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selectedLanguage == 'Hindi' ? Colors.green.shade300 : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.security, color: Colors.green),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('हिंदी', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            Text('Hindi', style: TextStyle(fontSize: 13, color: Colors.grey)),
                          ],
                        ),
                      ),
                      Radio<String>(
                        value: 'Hindi',
                        groupValue: selectedLanguage,
                        activeColor: Colors.green,
                        onChanged: (val) => setState(() => selectedLanguage = val!),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // 3. Santali Option
              GestureDetector(
                onTap: () => setState(() => selectedLanguage = 'Santali'),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: selectedLanguage == 'Santali' ? const Color(0xFFEDE7F6) : const Color(0xFFF9F9F9),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selectedLanguage == 'Santali' ? Colors.deepPurple.shade300 : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.shield, color: Colors.deepPurple),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('ᱥᱟᱱᱛᱟᱲᱤ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            Text('Santali', style: TextStyle(fontSize: 13, color: Colors.grey)),
                          ],
                        ),
                      ),
                      Radio<String>(
                        value: 'Santali',
                        groupValue: selectedLanguage,
                        activeColor: Colors.deepPurple,
                        onChanged: (val) => setState(() => selectedLanguage = val!),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),

              // Continue Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B5E20),
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(selectedLanguage: selectedLanguage),
                    ),
                  );
                },
                child: const Text('आगे बढ़ें / Continue', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
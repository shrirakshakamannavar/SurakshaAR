import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../core/database/database_helper.dart';
import 'result_screen.dart';

class AssessmentScreen extends StatefulWidget {
  final String employeeId;
  final String moduleId;
  final String moduleTitle;
  final String selectedLanguage;

  const AssessmentScreen({
    super.key,
    required this.employeeId,
    required this.moduleId,
    required this.moduleTitle,
    required this.selectedLanguage,
  });

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  int _currentIndex = 0;
  late Timer _timer;
  int _remainingSeconds = 600; // 10 minutes timer (10 * 60)
  late Stopwatch _stopwatch;

  late final List<Map<String, dynamic>> _questions;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch()..start();
    _startTimer();
    _loadQuestions();
  }

  void _loadQuestions() {
    if (widget.moduleId == 'Module_2') {
      // Gas Leak & Confined Space MCQs
      _questions = [
        {
          'question': '1. What should you do immediately after detecting a gas leak?',
          'options': ['Investigate it alone', 'Raise the alarm and inform the emergency team', 'Switch on electrical equipment', 'Continue working'],
          'answer': 1,
        },
        {
          'question': '2. What should be avoided during a gas leak?',
          'options': ['Moving to a safe area', 'Informing others', 'Flames, sparks, and smoking', 'Raising the alarm'],
          'answer': 2,
        },
        {
          'question': '3. How should a gas leak be located?',
          'options': ['Using a matchstick', 'Using an open flame', 'Using appropriate gas-detection equipment', 'By touching the pipeline'],
          'answer': 2,
        },
        {
          'question': '4. What should be established around a suspected gas leak?',
          'options': ['A work area', 'A safe exclusion zone', 'A storage area', 'A parking area'],
          'answer': 1,
        },
        {
          'question': '5. Why is atmospheric monitoring important in a confined space?',
          'options': ['To measure working speed', 'To detect unsafe oxygen or gas levels', 'To check employee attendance', 'To reduce paperwork'],
          'answer': 1,
        },
        {
          'question': '6. What should be in place before authorized confined-space entry?',
          'options': ['Entry permit and required safety controls', 'Personal mobile phone only', 'Food and water', 'No preparation'],
          'answer': 0,
        },
        {
          'question': '7. Who should remain outside and monitor workers during confined-space entry?',
          'options': ['Visitor', 'Standby attendant', 'Security guard only', 'Unauthorized worker'],
          'answer': 1,
        },
        {
          'question': '8. What should a worker do if a gas alarm activates inside a confined space?',
          'options': ['Continue working', 'Ignore the alarm', 'Stop work and evacuate according to the emergency procedure', 'Remove the gas detector'],
          'answer': 2,
        },
        {
          'question': '9. Why should unauthorized personnel be kept away from a confined space?',
          'options': ['To maintain cleanliness', 'To prevent unnecessary exposure to hazards', 'To reduce noise', 'To save equipment'],
          'answer': 1,
        },
        {
          'question': '10. When should workers re-enter an affected area?',
          'options': ['Immediately after the alarm stops', 'When they think it is safe', 'Only after required checks and authorization confirm it is safe', 'After 5 minutes'],
          'answer': 2,
        },
      ];
    } else if (widget.moduleId == 'Module_3') {
      // Machinery Safety MCQs
      _questions = [
        {
          'question': '1. Who should operate machinery?',
          'options': ['Anyone nearby', 'Visitors', 'Trained and authorized personnel', 'New workers without training'],
          'answer': 2,
        },
        {
          'question': '2. What should be done before starting a machine?',
          'options': ['Start it immediately', 'Perform a pre-start safety inspection', 'Remove the machine guard', 'Increase its speed'],
          'answer': 1,
        },
        {
          'question': '3. Which of the following should be kept away from moving machine parts?',
          'options': ['Loose clothing and hair', 'Safety signs', 'Machine controls', 'Fixed guards'],
          'answer': 0,
        },
        {
          'question': '4. What should be done if a machine guard is damaged or missing?',
          'options': ['Continue operating', 'Remove other guards', 'Report it and do not operate until it is made safe', 'Cover it with cloth'],
          'answer': 2,
        },
        {
          'question': '5. Why should machine guards not be bypassed?',
          'options': ['They improve machine speed', 'They help protect workers from moving parts and other hazards', 'They reduce electricity use', 'They make cleaning easier'],
          'answer': 1,
        },
        {
          'question': '6. What should be done before cleaning or maintaining machinery?',
          'options': ['Keep the machine running', 'Stop and isolate hazardous energy according to the LOTO procedure', 'Ask another worker to watch it', 'Increase the machine speed'],
          'answer': 1,
        },
        {
          'question': '7. What should you do if a machine makes an unusual noise or vibration?',
          'options': ['Ignore it', 'Continue working faster', 'Stop safely and report the problem', 'Remove the safety guard'],
          'answer': 2,
        },
        {
          'question': '8. Why should the area around machinery be kept clean?',
          'options': ['To improve appearance only', 'To prevent slips, trips, and other hazards', 'To increase machine speed', 'To reduce noise'],
          'answer': 1,
        },
        {
          'question': '9. What should workers know before operating machinery?',
          'options': ["Only the machine's color", 'Location of emergency stops and emergency equipment', "Other workers' schedules", 'Machine purchase price'],
          'answer': 1,
        },
        {
          'question': '10. What should be done after completing machine operation?',
          'options': ['Leave the machine running', 'Shut down the machine safely and leave the area safe', 'Remove all warning signs', 'Disable the emergency stop'],
          'answer': 1,
        },
      ];
    } else if (widget.moduleId == 'Module_4') {
      // Personal Protective Equipment (PPE) MCQs
      _questions = [
        {
          'question': '1. What should PPE selection be based on?',
          'options': ['Worker preference', 'Workplace hazards and task requirements', 'PPE color', 'Brand name'],
          'answer': 1,
        },
        {
          'question': '2. When should required PPE be worn?',
          'options': ['After starting work', 'Only during inspections', 'Before entering or starting work in a hazardous area', 'Only when a supervisor is present'],
          'answer': 2,
        },
        {
          'question': '3. Which of the following is an example of PPE?',
          'options': ['Safety helmet', 'Fire alarm', 'Emergency exit', 'Warning sign'],
          'answer': 0,
        },
        {
          'question': '4. What should you do before using PPE?',
          'options': ['Modify it', 'Inspect it for damage or defects', 'Remove its safety features', 'Share it immediately'],
          'answer': 1,
        },
        {
          'question': '5. What should be done with damaged PPE?',
          'options': ['Continue using it', 'Repair it with tape without approval', 'Report or replace it as required', 'Give it to another worker'],
          'answer': 2,
        },
        {
          'question': '6. Why is proper PPE fit important?',
          'options': ['For appearance', 'To ensure effective protection and safe use', 'To make the PPE heavier', 'To reduce cleaning'],
          'answer': 1,
        },
        {
          'question': '7. How should PPE be maintained?',
          'options': ['Kept dirty', 'Cleaned, maintained, and stored properly', 'Stored anywhere', 'Modified regularly'],
          'answer': 1,
        },
        {
          'question': '8. What should workers know about PPE?',
          'options': ['Only its price', 'Its limitations and correct method of use', 'Its manufacturing location', 'Its color code only'],
          'answer': 1,
        },
        {
          'question': '9. What should workers receive before using specialized PPE?',
          'options': ['Training on its proper use and maintenance', 'A different uniform', 'Permission to modify it', 'No instructions'],
          'answer': 0,
        },
        {
          'question': '10. What is the role of PPE in workplace safety?',
          'options': ['It replaces all other safety measures', 'It is the last line of defense against hazards', 'It eliminates every workplace hazard', 'It is only needed during emergencies'],
          'answer': 1,
        },
      ];
    } else {
      // Fire & Explosion Response MCQs (Default / Module_1)
      _questions = [
        {
          'question': '1. What should you do first when you notice a fire?',
          'options': ['Try to hide the fire', 'Raise the alarm and inform others', 'Collect your belongings', 'Use the lift'],
          'answer': 1,
        },
        {
          'question': '2. During a fire emergency, which route should you use?',
          'options': ['Designated emergency exit', 'Elevator', 'Window', 'Storage area'],
          'answer': 0,
        },
        {
          'question': '3. Why should lifts/elevators not be used during a fire?',
          'options': ['They may become unsafe or stop working', 'They are too slow', 'They consume electricity', 'They are reserved for staff'],
          'answer': 0,
        },
        {
          'question': '4. When should you attempt to use a fire extinguisher?',
          'options': ['For every fire', 'Only if the fire is small and you are trained', 'After the fire spreads', 'Without checking the extinguisher'],
          'answer': 1,
        },
        {
          'question': '5. What should you do if an area has a risk of explosion?',
          'options': ['Enter quickly', 'Stay away and follow emergency procedures', 'Switch on electrical equipment', 'Gather near the hazard'],
          'answer': 1,
        },
        {
          'question': '6. When should power, gas, or fuel sources be isolated?',
          'options': ['Always, regardless of the situation', 'Only when it can be done safely', 'After returning to the area', 'Only after the fire is extinguished'],
          'answer': 1,
        },
        {
          'question': '7. Where should people go after evacuating?',
          'options': ['Parking area randomly', 'Assembly point', 'Inside the building', 'Near the fire'],
          'answer': 1,
        },
        {
          'question': '8. Who should be informed about missing or injured persons?',
          'options': ['Visitors', 'Emergency response team', 'Social media', 'Nobody'],
          'answer': 1,
        },
        {
          'question': '9. Which practice helps prevent fire incidents?',
          'options': ['Blocking emergency exits', 'Storing flammable materials near ignition sources', 'Regular inspection of electrical equipment and gas lines', 'Ignoring damaged equipment'],
          'answer': 2,
        },
        {
          'question': '10. When is it safe to re-enter a building after a fire?',
          'options': ['As soon as the flames disappear', 'When you think it is safe', 'Only after authorized personnel declare it safe', 'After collecting personal belongings'],
          'answer': 2,
        },
      ];
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _timer.cancel();
        _submitQuiz();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _stopwatch.stop();
    super.dispose();
  }

  String _formatTimer(int seconds) {
    int mins = seconds ~/ 60;
    int secs = seconds % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  late final List<int?> _selectedAnswers = List.filled(10, null);

  void _nextQuestion() {
    if (_selectedAnswers[_currentIndex] == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an option before proceeding.')),
      );
      return;
    }

    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      _submitQuiz();
    }
  }

  void _submitQuiz() async {
    _timer.cancel();
    _stopwatch.stop();
    int elapsedSeconds = _stopwatch.elapsed.inSeconds;

    int correctCount = 0;
    for (int i = 0; i < _questions.length; i++) {
      if (_selectedAnswers[i] == _questions[i]['answer']) {
        correctCount++;
      }
    }

    int score = (correctCount / _questions.length * 100).round();
    bool passed = score >= 70;

    final db = await DatabaseHelper.instance.database;
    await db.insert(
      'modules',
      {
        'employeeId': widget.employeeId,
        'moduleId': widget.moduleId,
        'isCompleted': passed ? 1 : 0,
        'score': passed ? score : 0,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          employeeId: widget.employeeId,
          score: score,
          correctCount: correctCount,
          totalQuestions: _questions.length,
          timeElapsedSeconds: elapsedSeconds,
          selectedLanguage: widget.selectedLanguage,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var currentQ = _questions[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.moduleTitle),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const Icon(Icons.timer, size: 18, color: Colors.red),
                  const SizedBox(width: 4),
                  Text(
                    _formatTimer(_remainingSeconds),
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Question ${_currentIndex + 1} of ${_questions.length}',
              style: const TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Text(
              currentQ['question'],
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ...List.generate((currentQ['options'] as List).length, (index) {
              bool isSelected = _selectedAnswers[_currentIndex] == index;
              return GestureDetector(
                onTap: () => setState(() => _selectedAnswers[_currentIndex] = index),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.blue[50] : Colors.white,
                    border: Border.all(color: isSelected ? Colors.blue : Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                        color: isSelected ? Colors.blue : Colors.grey,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          currentQ['options'][index],
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              onPressed: _nextQuestion,
              child: Text(
                _currentIndex == _questions.length - 1 ? 'Submit Quiz' : 'Next Question',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
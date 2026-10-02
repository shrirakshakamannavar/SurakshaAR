import 'package:flutter/material.dart';

class ARTrainingScreen extends StatefulWidget {
  final String selectedLanguage;
  final String moduleTitle;

  const ARTrainingScreen({
    super.key,
    required this.selectedLanguage,
    required this.moduleTitle,
  });

  @override
  State<ARTrainingScreen> createState() => _ARTrainingScreenState();
}
class _ARTrainingScreenState extends State<ARTrainingScreen> with SingleTickerProviderStateMixin {
  int _currentStep = 0;
  bool _isExtinguishing = false;
  bool _isSimulationComplete = false;
  double _fireIntensity = 1.0;

  late AnimationController _pulseController;

  final List<Map<String, String>> _steps = [
    {
      'title': 'Step 1: Pull the Pin',
      'instruction': 'Tap the safety pin on the 3D extinguisher model to release the locking mechanism.',
      'action': 'Pull Safety Pin',
    },
    {
      'title': 'Step 2: Aim at Base of Fire',
      'instruction': 'Align the nozzle towards the base of the simulated underground fire hazard.',
      'action': 'Aim Nozzle',
    },
    {
      'title': 'Step 3: Squeeze Lever & Sweep',
      'instruction': 'Press and hold to discharge the extinguishing agent and sweep side-to-side.',
      'action': 'Hold to Extinguish Fire',
    },
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _onActionPressed() {
    if (_currentStep == 2) {
      setState(() {
        _isExtinguishing = true;
      });

      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() {
            _fireIntensity = 0.6;
          });
        }
      });
      Future.delayed(const Duration(milliseconds: 1200), () {
        if (mounted) {
          setState(() {
            _fireIntensity = 0.2;
          });
        }
      });
      Future.delayed(const Duration(milliseconds: 2000), () {
        if (mounted) {
          setState(() {
            _isExtinguishing = false;
            _isSimulationComplete = true;
          });
        }
      });
    } else {
      setState(() {
        _currentStep++;
      });
    }
  }

  void _resetSimulation() {
    setState(() {
      _currentStep = 0;
      _isSimulationComplete = false;
      _isExtinguishing = false;
      _fireIntensity = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentStepData = _steps[_currentStep];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          widget.moduleTitle,
          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.grid_view_rounded),
            tooltip: 'AR Surface Detected',
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Reset AR Scene',
            onPressed: _resetSimulation,
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blueGrey.shade900, Colors.black87],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: ARGridPainter(),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        if (!_isSimulationComplete) ...[
                          TweenAnimationBuilder<double>(
                            tween: Tween<double>(begin: 1.0, end: _fireIntensity),
                            duration: const Duration(milliseconds: 400),
                            builder: (context, scaleVal, child) {
                              return Transform.scale(
                                scale: scaleVal,
                                child: child,
                              );
                            },
                            child: Column(
                              children: [
                                Icon(
                                  Icons.local_fire_department,
                                  size: 130,
                                  color: Colors.orange.shade600,
                                ),
                                Container(
                                  width: 140,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.6),
                                    borderRadius: BorderRadius.circular(50),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.orange.withValues(alpha: 0.5),
                                        blurRadius: 15,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ] else ...[
                          const Icon(
                            Icons.check_circle_rounded,
                            size: 90,
                            color: Colors.greenAccent,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'HAZARD SECURED',
                            style: TextStyle(color: Colors.greenAccent, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.5),
                          ),
                        ],
                        const SizedBox(height: 40),
                        if (!_isSimulationComplete)
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 90,
                                height: 160,
                                decoration: BoxDecoration(
                                  color: Colors.red.shade700,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.red.withValues(alpha: 0.4),
                                      blurRadius: 20,
                                      spreadRadius: 5,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    Container(width: 30, height: 15, color: Colors.black87),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                                      child: const Text('CO2', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black)),
                                    ),
                                    const SizedBox(height: 16),
                                  ],
                                ),
                              ),
                              if (_isExtinguishing)
                                Positioned(
                                  left: 60,
                                  top: 20,
                                  child: Icon(
                                    Icons.cloud,
                                    size: 80,
                                    color: Colors.white.withValues(alpha: 0.8),
                                  ),
                                ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  Positioned(top: 100, left: 30, child: _buildARCornerMarker()),
                  Positioned(top: 100, right: 30, child: _buildARCornerMarker()),
                  Positioned(bottom: 220, left: 30, child: _buildARCornerMarker()),
                  Positioned(bottom: 220, right: 30, child: _buildARCornerMarker()),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF0F172A).withValues(alpha: 0.95),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                border: Border.all(color: Colors.blue.withValues(alpha: 0.2)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    blurRadius: 15,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.view_in_ar, color: Colors.orangeAccent, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            _isSimulationComplete ? 'Simulation Completed' : 'Interactive AR Step ${_currentStep + 1} of 3',
                            style: const TextStyle(color: Colors.orangeAccent, fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.blue.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text('Mine Safety AR', style: TextStyle(color: Colors.blueAccent, fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _isSimulationComplete ? 'Fire Extinguished Successfully! 🏅' : (currentStepData['title'] ?? ''),
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _isSimulationComplete
                        ? 'You have successfully completed the fire safety protocol.'
                        : (currentStepData['instruction'] ?? ''),
                    style: const TextStyle(fontSize: 13, color: Colors.white70),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isSimulationComplete ? Colors.green : Colors.orange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: _isExtinguishing
                          ? null
                          : (_isSimulationComplete ? _resetSimulation : _onActionPressed),
                      child: Text(
                        _isSimulationComplete ? 'Restart 3D AR Simulation' : (currentStepData['action'] ?? ''),
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildARCornerMarker() {
    return Container(
      width: 24,
      height: 24,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.orangeAccent, width: 2),
          left: BorderSide(color: Colors.orangeAccent, width: 2),
        ),
      ),
    );
  }
}
class ARGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue.withValues(alpha: 0.08)
      ..strokeWidth = 1.0;

    const double spacing = 40.0;
    for (double i = 0; i < size.width; i += spacing) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += spacing) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
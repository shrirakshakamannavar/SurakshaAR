import 'package:flutter/material.dart';

class AdminDashboardScreen extends StatefulWidget {
  final String adminId;
  final String selectedLanguage;

  const AdminDashboardScreen({
    super.key,
    required this.adminId,
    required this.selectedLanguage,
  });

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Track current active view ('dashboard' or 'workers')
  String _selectedView = 'dashboard';

  // List of 25 worker names
  final List<String> _workerNames = const [
    'Aarav Sharma', 'Vivaan Gupta', 'Aditya Kumar', 'Vihaan Singh', 'Arjun Verma',
    'Sai Reddy', 'Reyansh Mishra', 'Ayaan Joshi', 'Krishna Iyer', 'Ishaan Pillai',
    'Dhruv Nair', 'Kian Mehta', 'Rudra Patel', 'Kabir Sen', 'Ritvik Das',
    'Darsh Chawla', 'Kabeer Kulkarni', 'Veer Sharma', 'Shaurya Rao', 'Onkar Patil',
    'Malhar Joshi', 'Tanmay Deshmukh', 'Yash Kadam', 'Sarthak Shinde', 'Pranav More'
  ];

  final List<Map<String, dynamic>> _navItems = const [
    {'icon': Icons.dashboard, 'label': 'Dashboard'},
    {'icon': Icons.people, 'label': 'Workers'},
    {'icon': Icons.school, 'label': 'Training Modules'},
    {'icon': Icons.assessment, 'label': 'Assessments'},
    {'icon': Icons.card_membership, 'label': 'Certificates'},
    {'icon': Icons.bar_chart, 'label': 'Reports'},
    {'icon': Icons.chat_bubble_outline, 'label': 'Feedback'},
    {'type': 'header', 'label': 'SYSTEM'},
    {'icon': Icons.admin_panel_settings, 'label': 'Roles & Permissions'},
    {'icon': Icons.history, 'label': 'Audit Logs'},
    {'icon': Icons.notifications_none, 'label': 'Notifications'},
    {'icon': Icons.settings, 'label': 'Settings'},
  ];

  Widget _buildSidebarContent() {
    return Container(
      width: 240,
      color: const Color(0xFF0A192F),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade700,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.shield, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SURAKSHAAR',
                      style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 1.1),
                    ),
                    Text(
                      'Safety Training System',
                      style: TextStyle(color: Colors.white60, fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white12, height: 1),
          Expanded(
            child: ListView.builder(
              itemCount: _navItems.length,
              itemBuilder: (context, index) {
                final item = _navItems[index];

                if (item['type'] == 'header') {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                    child: Text(
                      item['label'],
                      style: const TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                    ),
                  );
                }

                final label = item['label'] as String;
                final bool isSelected = (_selectedView == 'dashboard' && label == 'Dashboard') ||
                    (_selectedView == 'workers' && label == 'Workers');

                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.blue.shade700 : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    dense: true,
                    leading: Icon(
                      item['icon'],
                      color: isSelected ? Colors.white : Colors.white70,
                      size: 18,
                    ),
                    title: Text(
                      label,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.white70,
                        fontSize: 13,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        if (label == 'Dashboard') {
                          _selectedView = 'dashboard';
                        } else if (label == 'Workers') {
                          _selectedView = 'workers';
                        }
                      });
                      if (!MediaQuery.of(context).size.width.isFinite || MediaQuery.of(context).size.width < 900) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width >= 900;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF4F6F9),
      drawer: isDesktop ? null : Drawer(child: _buildSidebarContent()),
      body: Row(
        children: [
          if (isDesktop) _buildSidebarContent(),
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 70,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: BorderSide(color: Color(0xFFE5E9F0))),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.menu, color: Colors.black54, size: 22),
                        onPressed: () {
                          if (!isDesktop) {
                            _scaffoldKey.currentState?.openDrawer();
                          }
                        },
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _selectedView == 'dashboard' ? 'Dashboard' : 'Workers (25)',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      const Spacer(),
                      const Icon(Icons.notifications_outlined, color: Colors.black54, size: 22),
                      const SizedBox(width: 12),
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.more_vert, color: Colors.black54),
                        onSelected: (value) {
                          setState(() {
                            if (value == 'dashboard') {
                              _selectedView = 'dashboard';
                            } else if (value == 'workers') {
                              _selectedView = 'workers';
                            } else if (value == 'logout') {
                              Navigator.pop(context);
                            }
                          });
                        },
                        itemBuilder: (BuildContext context) => const <PopupMenuEntry<String>>[
                          PopupMenuItem<String>(
                            value: 'dashboard',
                            child: Row(
                              children: [
                                Icon(Icons.dashboard, size: 18, color: Colors.blue),
                                SizedBox(width: 8),
                                Text('Dashboard'),
                              ],
                            ),
                          ),
                          PopupMenuItem<String>(
                            value: 'workers',
                            child: Row(
                              children: [
                                Icon(Icons.people, size: 18, color: Colors.blue),
                                SizedBox(width: 8),
                                Text('Workers (25)'),
                              ],
                            ),
                          ),
                          PopupMenuDivider(),
                          PopupMenuItem<String>(
                            value: 'profile',
                            child: Text('View Profile'),
                          ),
                          PopupMenuItem<String>(
                            value: 'settings',
                            child: Text('Admin Settings'),
                          ),
                          PopupMenuDivider(),
                          PopupMenuItem<String>(
                            value: 'logout',
                            child: Text(
                              'Logout',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: _selectedView == 'dashboard'
                      ? _buildDashboardContent(context)
                      : _buildWorkersContent(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardContent(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome back, Admin User! 👋',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          const SizedBox(height: 4),
          const Text(
            "Here's what's happening with your training platform.",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.3,
            children: [
              _buildStatCard('Total Workers', '25', Icons.people_outline, Colors.blue, 'Active Team'),
              _buildStatCard('Completed', '10', Icons.school_outlined, Colors.green, 'Finished'),
              _buildStatCard('Assessments', '4', Icons.assignment_outlined, Colors.purple, 'Pending/Done'),
              _buildStatCard('Certificates', '10', Icons.card_membership, Colors.orange, 'Issued'),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Training Progress', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Row(
                        children: [
                          Text('This Month', style: TextStyle(fontSize: 11)),
                          Icon(Icons.arrow_drop_down, size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Row(
                  children: [
                    Icon(Icons.circle, size: 8, color: Colors.blue),
                    SizedBox(width: 4),
                    Text('Assigned', style: TextStyle(fontSize: 10, color: Colors.grey)),
                    SizedBox(width: 12),
                    Icon(Icons.circle, size: 8, color: Colors.green),
                    SizedBox(width: 4),
                    Text('Completed', style: TextStyle(fontSize: 10, color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 180,
                  child: CustomPaint(
                    size: const Size(double.infinity, 180),
                    painter: DualLineChartPainter(),
                  ),
                ),
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('1 May', style: TextStyle(fontSize: 10, color: Colors.grey)),
                    Text('8 May', style: TextStyle(fontSize: 10, color: Colors.grey)),
                    Text('16 May', style: TextStyle(fontSize: 10, color: Colors.grey)),
                    Text('24 May', style: TextStyle(fontSize: 10, color: Colors.grey)),
                    Text('31 May', style: TextStyle(fontSize: 10, color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Completion Rate', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                SizedBox(height: 16),
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: 120,
                        width: 120,
                        child: CircularProgressIndicator(
                          value: 0.40,
                          strokeWidth: 12,
                          backgroundColor: Color(0xFFE5E9F0),
                          color: Colors.green,
                        ),
                      ),
                      Text('40%', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Center(child: Text('Overall Completion (10 / 25 Workers)', style: TextStyle(color: Colors.grey, fontSize: 11))),
                SizedBox(height: 4),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.arrow_upward, color: Colors.green, size: 12),
                      SizedBox(width: 4),
                      Text('8.6% from last month', style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Training Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 16),
                _buildStatusRow(Colors.green, 'Completed', '10 - 40%'),
                const Divider(height: 20),
                _buildStatusRow(Colors.blue, 'In Progress', '11 - 44%'),
                const Divider(height: 20),
                _buildStatusRow(Colors.orange, 'Not Started', '4 - 16%'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkersContent() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _workerNames.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue.shade100,
              child: Text(
                '${index + 1}',
                style: TextStyle(color: Colors.blue.shade800, fontWeight: FontWeight.bold),
              ),
            ),
            title: Text(
              _workerNames[index],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            subtitle: const Text('Safety Training Worker', style: TextStyle(fontSize: 12, color: Colors.grey)),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: index < 10 ? Colors.green.shade50.withValues(alpha: 0.5) : Colors.orange.shade50.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: index < 10 ? Colors.green.shade200 : Colors.orange.shade200),
              ),
              child: Text(
                index < 10 ? 'Completed' : 'In Progress',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: index < 10 ? Colors.green.shade700 : Colors.orange.shade700,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color, String growth) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(title, style: const TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis)),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6)),
                child: Icon(icon, color: color, size: 14),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 4),
          const Row(
            children: [
              Icon(Icons.arrow_upward, color: Colors.green, size: 10),
              SizedBox(width: 2),
              Expanded(child: Text('Active Team', style: TextStyle(color: Colors.grey, fontSize: 10), overflow: TextOverflow.ellipsis)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRow(Color dotColor, String label, String countValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(width: 8, height: 8, decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle)),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.w500)),
          ],
        ),
        Text(countValue, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87)),
      ],
    );
  }
}

class DualLineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintBlue = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final paintGreen = Paint()
      ..color = Colors.green
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final pathBlue = Path();
    pathBlue.moveTo(0, size.height * 0.7);
    pathBlue.lineTo(size.width * 0.25, size.height * 0.55);
    pathBlue.lineTo(size.width * 0.5, size.height * 0.4);
    pathBlue.lineTo(size.width * 0.75, size.height * 0.3);
    pathBlue.lineTo(size.width, size.height * 0.15);

    final pathGreen = Path();
    pathGreen.moveTo(0, size.height * 0.85);
    pathGreen.lineTo(size.width * 0.25, size.height * 0.7);
    pathGreen.lineTo(size.width * 0.5, size.height * 0.55);
    pathGreen.lineTo(size.width * 0.75, size.height * 0.45);
    pathGreen.lineTo(size.width, size.height * 0.3);

    canvas.drawPath(pathBlue, paintBlue);
    canvas.drawPath(pathGreen, paintGreen);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
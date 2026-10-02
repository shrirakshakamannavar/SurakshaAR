import 'package:flutter/material.dart';
import 'assesment_screen.dart';

class ModuleDetailScreen extends StatelessWidget {
  final String employeeId;
  final String moduleId;
  final String moduleTitle;
  final String selectedLanguage;

  const ModuleDetailScreen({
    super.key,
    required this.employeeId,
    required this.moduleId,
    required this.moduleTitle,
    required this.selectedLanguage,
  });

  @override
  Widget build(BuildContext context) {
    bool isFireModule = moduleId == 'Module_1';
    bool isGasModule = moduleId == 'Module_2';
    bool isMachineryModule = moduleId == 'Module_3';
    bool isPpeModule = moduleId == 'Module_4';

    String content = '1. Always inspect your workspace and personal protective equipment (PPE) before commencing work.\n\n'
        '2. In case of an emergency or hazard alarm, immediately raise the alarm and follow designated evacuation routes upwind.\n\n'
        '3. Never enter confined areas alone; always use the buddy system and ensure multi-gas detector levels are verified.\n\n'
        '4. Maintain safety clearances around heavy machinery and ensure emergency stop controls are clear and operational.';

    if (isFireModule) {
      content = '🔥 Fire & Explosion Response\n\n'
          '• Raise the alarm immediately and inform the emergency response team.\n'
          '• Evacuate through designated emergency exits and move to the assembly point.\n'
          '• Do not use lifts during a fire emergency.\n'
          '• Isolate power/gas/fuel sources only if it is safe to do so.\n'
          '• Use the appropriate fire extinguisher only for a small, manageable fire and if trained.\n'
          '• Keep away from smoke, flames, and areas at risk of explosion.\n'
          '• Do not re-enter the affected area until it is declared safe by authorized personnel.\n'
          '• Report missing or injured persons to the emergency response team.\n\n'
          '📋 Safety Guidelines & SOPs\n\n'
          '• Follow site-specific emergency procedures and safety signage.\n'
          '• Keep fire exits, extinguishers, alarms, and emergency equipment accessible.\n'
          '• Conduct regular fire drills and emergency-response training.\n'
          '• Store flammable materials safely and away from ignition sources.\n'
          '• Inspect electrical equipment, gas lines, and machinery regularly.\n'
          '• Maintain clear emergency communication and reporting procedures.\n'
          '• Record and investigate incidents to prevent recurrence.';
    } else if (isGasModule) {
      content = '🟡 Gas Leak & Confined Space Response — Additional Guidelines\n\n'
          '• Identify and report unusual gas smells, hissing sounds, or alarm indications immediately.\n'
          '• Establish a safe exclusion zone around the suspected leak.\n'
          '• Do not attempt to locate a gas leak using a flame or other ignition source.\n'
          '• Ensure adequate ventilation only when it can be done safely and according to the site SOP.\n'
          '• Use appropriate gas detection equipment to check oxygen levels and hazardous gases before and during confined-space entry.\n'
          '• Maintain a valid confined-space entry permit where required.\n'
          '• Ensure workers understand the hazards, communication method, and emergency procedure before entry.\n'
          '• Keep unauthorized personnel away from confined spaces and gas-leak areas.\n'
          '• Provide suitable rescue arrangements and emergency equipment before confined-space work begins.\n'
          '• Never rely on smell alone to determine whether a gas hazard is present.\n'
          '• Stop work immediately if gas alarms activate or atmospheric conditions become unsafe.\n'
          '• Report all gas leaks, near misses, and unsafe conditions for investigation and corrective action.\n'
          '• Conduct regular inspection and maintenance of gas pipelines, valves, detectors, and ventilation systems.\n'
          '• Provide workers with regular gas-safety and confined-space training.\n'
          '• Keep emergency contact information and rescue procedures readily available.';
    } else if (isMachineryModule) {
      content = '⚙️ Machinery Safety — Safety Guidelines & SOPs\n\n'
          '• Only trained and authorized personnel should operate machinery.\n'
          '• Read and follow the manufacturer’s instructions and site-specific SOPs before operation.\n'
          '• Perform a pre-start inspection of guards, controls, emergency stops, cables, and moving parts.\n'
          '• Ensure all required PPE is worn before operating the machine.\n'
          '• Keep hands, clothing, hair, and loose objects away from moving parts.\n'
          '• Never remove, bypass, or disable machine guards or safety interlocks.\n'
          '• Keep the work area clean, well-lit, and free from obstructions.\n'
          '• Use the correct tools and attachments for the specific machine and task.\n'
          '• Before maintenance, cleaning, or clearing a jam, stop the machine and isolate hazardous energy according to the site’s Lockout/Tagout (LOTO) procedure.\n'
          '• Do not operate machinery if you notice damage, unusual noise, vibration, or malfunction; report it immediately.\n'
          '• Keep unauthorized persons away from operating machinery and hazardous zones.\n'
          '• Know the location of emergency stops, first-aid equipment, and emergency exits.\n'
          '• Carry out regular inspection, maintenance, and safety checks as specified by the SOP.\n'
          '• After completing work, shut down the machine safely and leave the area in a safe condition.';
    } else if (isPpeModule) {
      content = '🦺 Personal Protective Equipment (PPE) — Safety Guidelines & SOPs\n\n'
          '• Select PPE based on the hazards of the task and workplace.\n'
          '• Wear the required PPE before entering or starting work in a designated hazardous area.\n'
          '• Common PPE includes safety helmets, safety glasses/goggles, gloves, safety footwear, hearing protection, and respiratory protection where required.\n'
          '• Ensure PPE fits correctly and is comfortable enough for the task.\n'
          '• Inspect PPE before use for damage, wear, contamination, or defects.\n'
          '• Do not use damaged or defective PPE; replace or report it.\n'
          '• Keep PPE clean, properly maintained, and stored in the designated location.\n'
          '• Use PPE according to the manufacturer\'s instructions and site SOPs.\n'
          '• Do not modify, misuse, or share PPE unless it is designed and properly sanitized for shared use.\n'
          '• Know the limitations of each type of PPE; PPE is the last line of defense and does not replace hazard controls.\n'
          '• Remove PPE safely after work and dispose of single-use PPE appropriately.\n'
          '• Report any PPE-related problems or exposure incidents to the responsible supervisor.\n'
          '• Workers should receive training on selecting, wearing, removing, maintaining, and storing PPE.\n'
          '• Conduct regular PPE inspections and replacement according to workplace requirements.';
    }

    return Scaffold(
      appBar: AppBar(title: Text(moduleTitle)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              moduleTitle,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 15),
            const Text(
              'Safety Guidelines & Standard Operating Procedures:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  content,
                  style: const TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AssessmentScreen(
                      employeeId: employeeId,
                      moduleId: moduleId,
                      moduleTitle: moduleTitle,
                      selectedLanguage: selectedLanguage,
                    ),
                  ),
                );
              },
              child: const Text('Proceed to Assessment Quiz', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
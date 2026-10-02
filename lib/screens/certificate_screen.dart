import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../core/localization/app_localizations.dart';

class CertificateScreen extends StatelessWidget {
  final String employeeId;
  final String name;
  final String selectedLanguage;

  const CertificateScreen({
    super.key,
    required this.employeeId,
    required this.name,
    required this.selectedLanguage,
  });

  @override
  Widget build(BuildContext context) {
    String certId = 'CERT-$employeeId-2026';
    String verificationUrl = 'https://minesafety.gov.in/verify/$certId';

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.get(selectedLanguage, 'cert_title'))),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.verified, size: 60, color: Colors.green),
                  const SizedBox(height: 10),
                  Text(
                    AppLocalizations.get(selectedLanguage, 'cert_heading'),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  Text('${AppLocalizations.get(selectedLanguage, 'awarded_to')}: $name', style: const TextStyle(fontSize: 16)),
                  Text('ID: $employeeId', style: const TextStyle(fontSize: 14, color: Colors.grey)),
                  const SizedBox(height: 15),
                  Text(
                    AppLocalizations.get(selectedLanguage, 'modules_passed'),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: QrImageView(
                      data: verificationUrl,
                      version: QrVersions.auto,
                      size: 150.0,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text('ID: $certId', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
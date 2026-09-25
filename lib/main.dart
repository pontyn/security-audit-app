import 'package:flutter/material.dart';

import 'package:security_audit_app/pages/login_page.dart';
import 'package:security_audit_app/services/auth_service.dart';
import 'package:security_audit_app/theme/app_theme.dart';
import 'package:security_audit_app/pages/dashboard_page.dart';

void main() {
  runApp(const SecurityAuditApp());
}

class SecurityAuditApp extends StatelessWidget {
  const SecurityAuditApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Audit Sécurité',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: AuthService.instance.isAuthenticated
          ? const DashboardPage()
          : const LoginPage(),
    );
  }
}

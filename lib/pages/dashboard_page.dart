import 'package:flutter/material.dart';

import 'package:security_audit_app/pages/assets_page.dart';
import 'package:security_audit_app/pages/login_page.dart';
import 'package:security_audit_app/pages/scan_results_page.dart';
import 'package:security_audit_app/services/auth_service.dart';
import 'package:security_audit_app/theme/app_theme.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool _isScanning = false;
  String _statusText = 'Système stable';
  String _riskLevel = 'Faible';
  int _alerts = 2;

  Future<void> _runScan() async {
    setState(() {
      _isScanning = true;
      _statusText = 'Analyse en cours...';
      _riskLevel = 'Vérification';
    });

    await Future<void>.delayed(const Duration(seconds: 1));

    if (!mounted) {
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (_) => const ScanResultsPage()),
    );

    setState(() {
      _isScanning = false;
      _statusText = 'Aucun incident critique détecté';
      _riskLevel = 'Faible';
      _alerts = 2;
    });
  }

  Future<void> _logout() async {
    await AuthService.instance.logout();

    if (!mounted) {
      return;
    }

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute<void>(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cards = [
      _MetricCard(
        title: 'Périmètre',
        value: '96%',
        subtitle: 'Couverture réseau',
        color: AppColors.secondary,
      ),
      _MetricCard(
        title: 'Vulnérabilités',
        value: '03',
        subtitle: 'À corriger',
        color: AppColors.warning,
      ),
      _MetricCard(
        title: 'Incidents',
        value: '$_alerts',
        subtitle: 'Alertes actives',
        color: AppColors.danger,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tableau de bord'),
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: AppColors.panel,
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.shield_rounded, size: 42, color: Colors.white),
                    SizedBox(height: 12),
                    Text(
                      'Audit Sécurité',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.dashboard_rounded, color: AppColors.secondary),
                title: const Text('Tableau de bord'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.router_rounded, color: AppColors.secondary),
                title: const Text('Actifs réseau'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(builder: (_) => const NetworkAssetsPage()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.search_rounded, color: AppColors.secondary),
                title: const Text('Résultats du scan'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(builder: (_) => const ScanResultsPage()),
                  );
                },
              ),
              const Divider(color: Color(0xFF4A4F58)),
              ListTile(
                leading: const Icon(Icons.logout_rounded, color: AppColors.danger),
                title: const Text('Déconnexion'),
                onTap: () async {
                  Navigator.pop(context);
                  await _logout();
                },
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.panel,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'État du réseau',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _statusText,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.mutedText,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.secondary.withAlpha(35),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              'Niveau de risque : $_riskLevel',
                              style: const TextStyle(
                                color: AppColors.secondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.security_rounded,
                      size: 54,
                      color: AppColors.secondary,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cards.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.4,
                ),
                itemBuilder: (context, index) => cards[index],
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _isScanning ? null : _runScan,
                  icon: _isScanning
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Icon(Icons.search_rounded),
                  label: Text(_isScanning ? 'Scan en cours...' : 'Scanner maintenant'),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Recommandations',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              const _RecommendationTile(
                title: 'Mise à jour du pare-feu',
                description: 'Valider les règles récents et activer la surveillance avancée.',
              ),
              const _RecommendationTile(
                title: 'Vérification MFA',
                description: 'Renforcer la protection des comptes administrateurs.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.color,
  });

  final String title;
  final String value;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.panel,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.mutedText,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(
              color: AppColors.mutedText,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _RecommendationTile extends StatelessWidget {
  const _RecommendationTile({
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.panel,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: const BoxDecoration(
              color: AppColors.secondary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: AppColors.mutedText,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

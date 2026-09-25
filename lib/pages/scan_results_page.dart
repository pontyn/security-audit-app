import 'package:flutter/material.dart';

import 'package:security_audit_app/theme/app_theme.dart';

class ScanResultsPage extends StatelessWidget {
  const ScanResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final issues = [
      const _Issue(
        title: 'Authentification multifactorielle inactive',
        severity: 'Élevée',
        asset: 'Comptes administrateurs',
        description: 'Les comptes privilégiés ne configurent pas la MFA, ce qui augmente le risque d’usurpation d’identité.',
      ),
      const _Issue(
        title: 'Pare-feu interne non conforme',
        severity: 'Moyenne',
        asset: 'Zone DMZ',
        description: 'Des règles de filtrage permissives laissent passer des ports non nécessaires vers les services critiques.',
      ),
      const _Issue(
        title: 'Mises à jour système retardées',
        severity: 'Moyenne',
        asset: 'Serveurs de production',
        description: 'Plusieurs nœuds sont en retard sur les correctifs de sécurité rédig��s par les éditeurs.',
      ),
      const _Issue(
        title: 'Journalisation centralisée insuffisante',
        severity: 'Faible',
        asset: 'Périmètre WAN',
        description: 'Les événements de connexion et d’accès ne sont pas entièrement centralisés pour analyses et alertes.',
      ),
    ];

    final severityCounts = <String, int>{
      'Élevée': 1,
      'Moyenne': 2,
      'Faible': 1,
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Résultats du scan'),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Résumé de sécurité',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _SummaryTile(
                            label: 'Élevée',
                            value: '${severityCounts['Élevée']}',
                            color: AppColors.danger,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _SummaryTile(
                            label: 'Moyenne',
                            value: '${severityCounts['Moyenne']}',
                            color: AppColors.warning,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _SummaryTile(
                            label: 'Faible',
                            value: '${severityCounts['Faible']}',
                            color: AppColors.success,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Vulnérabilités détectées',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.separated(
                  itemCount: issues.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final issue = issues[index];
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.panel,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  issue.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              _SeverityBadge(label: issue.severity),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Actif : ${issue.asset}',
                            style: const TextStyle(
                              color: AppColors.mutedText,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            issue.description,
                            style: const TextStyle(
                              color: AppColors.text,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryTile extends StatelessWidget {
  const _SummaryTile({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.text,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _SeverityBadge extends StatelessWidget {
  const _SeverityBadge({required this.label});

  final String label;

  Color get color {
    switch (label) {
      case 'Élevée':
        return AppColors.danger;
      case 'Moyenne':
        return AppColors.warning;
      default:
        return AppColors.success;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}

class _Issue {
  const _Issue({
    required this.title,
    required this.severity,
    required this.asset,
    required this.description,
  });

  final String title;
  final String severity;
  final String asset;
  final String description;
}

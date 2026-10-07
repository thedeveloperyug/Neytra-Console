/*
Copyright (c) 2026 Neytra Intelligence Platform. All rights reserved.

This software and its source code are proprietary and confidential.

No permission is granted to copy, modify, distribute, sublicense, sell, or otherwise use this software without prior written permission from the copyright holder.

Unauthorized use, reproduction, or distribution is prohibited.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.
*/

import 'dart:ui';

import 'package:flutter/material.dart';

class ProcurementWorkspaceBody extends StatelessWidget {
  const ProcurementWorkspaceBody({
    required this.section,
    super.key,
  });

  final String section;

  @override
  Widget build(BuildContext context) {
    final page = switch (section) {
      'overview' => const _ProcurementOverviewPage(),
      'solutions' => const _SolutionsPage(),
      'workflows' => const _WorkflowsPage(),
      'configurations' => const _ConfigurationsPage(),
      'connectors' => const _ConnectorsPage(),
      'approvals' => const _ApprovalsPage(),
      'evidence' => const _EvidencePage(),
      'analytics' => const _AnalyticsPage(),
      'users' => const _UsersPage(),
      'billing' => const _BillingPage(),
      _ => const _ProcurementOverviewPage(),
    };

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 180),
      child: KeyedSubtree(
        key: ValueKey<String>(section),
        child: page,
      ),
    );
  }
}

class _ProcurementOverviewPage extends StatelessWidget {
  const _ProcurementOverviewPage();

  @override
  Widget build(BuildContext context) {
    return _ScrollablePage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _PageTitle(
            title: 'Procurement & Supply Chain',
            subtitle:
                'Manage enterprise spend, suppliers, planning, inventory, logistics, fulfillment, and supply risk.',
            trailing: _HeaderActions(),
          ),
          const SizedBox(height: 18),
          const _LifecycleStrip(),
          const SizedBox(height: 18),
          const _ExecutiveMetricGrid(),
          const SizedBox(height: 18),
          LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth >= 1080;
              if (wide) {
                return const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(flex: 7, child: _ControlTowerPanel()),
                    SizedBox(width: 16),
                    Expanded(flex: 5, child: _SupplierHealthPanel()),
                  ],
                );
              }
              return const Column(
                children: <Widget>[
                  _ControlTowerPanel(),
                  SizedBox(height: 16),
                  _SupplierHealthPanel(),
                ],
              );
            },
          ),
          const SizedBox(height: 18),
          LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth >= 1080;
              if (wide) {
                return const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(flex: 7, child: _OperationsConfigurationCard()),
                    SizedBox(width: 16),
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: <Widget>[
                          _ConnectedSystemsSummary(),
                          SizedBox(height: 16),
                          _PlanningPolicyCard(),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return const Column(
                children: <Widget>[
                  _OperationsConfigurationCard(),
                  SizedBox(height: 16),
                  _ConnectedSystemsSummary(),
                  SizedBox(height: 16),
                  _PlanningPolicyCard(),
                ],
              );
            },
          ),
          const SizedBox(height: 18),
          LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth >= 1080;
              if (wide) {
                return const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(flex: 7, child: _LiveOperationsPanel()),
                    SizedBox(width: 16),
                    Expanded(flex: 5, child: _SelectedOperationPanel()),
                  ],
                );
              }
              return const Column(
                children: <Widget>[
                  _LiveOperationsPanel(),
                  SizedBox(height: 16),
                  _SelectedOperationPanel(),
                ],
              );
            },
          ),
          const SizedBox(height: 18),
          const _CapabilityMatrix(),
        ],
      ),
    );
  }
}

class _LifecycleStrip extends StatelessWidget {
  const _LifecycleStrip();

  @override
  Widget build(BuildContext context) {
    const steps = <(String, IconData)>[
      ('Sense Demand', Icons.insights_outlined),
      ('Plan Supply', Icons.timeline_rounded),
      ('Source', Icons.travel_explore_rounded),
      ('Contract', Icons.description_outlined),
      ('Buy', Icons.shopping_cart_outlined),
      ('Receive & Store', Icons.inventory_2_outlined),
      ('Move & Deliver', Icons.local_shipping_outlined),
      ('Measure', Icons.query_stats_outlined),
    ];

    return _GlassSurface(
      radius: 22,
      padding: const EdgeInsets.all(15),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 940) {
            return Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List<Widget>.generate(
                steps.length,
                (index) => _LifecycleStep(
                  number: index + 1,
                  label: steps[index].$1,
                  icon: steps[index].$2,
                ),
              ),
            );
          }

          return Row(
            children: List<Widget>.generate(
              steps.length,
              (index) => Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: _LifecycleStep(
                        number: index + 1,
                        label: steps[index].$1,
                        icon: steps[index].$2,
                      ),
                    ),
                    if (index < steps.length - 1)
                      const Icon(
                        Icons.arrow_forward_rounded,
                        size: 16,
                        color: Color(0xFF9BAABC),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _LifecycleStep extends StatelessWidget {
  const _LifecycleStep({
    required this.number,
    required this.label,
    required this.icon,
  });

  final int number;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 31,
          height: 31,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: <Color>[
                Color(0xFF4DEAF2),
                Color(0xFF0878FF),
                Color(0xFF173BE8),
              ],
            ),
          ),
          child: Text(
            '$number',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 7),
        Icon(icon, size: 16, color: const Color(0xFF287DDF)),
        const SizedBox(width: 5),
        Flexible(
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF314762),
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class _ExecutiveMetricGrid extends StatelessWidget {
  const _ExecutiveMetricGrid();

  @override
  Widget build(BuildContext context) {
    const metrics = <_MetricData>[
      _MetricData(
        label: 'Spend under management',
        value: '₹184.6 Cr',
        note: '92.4% of addressable spend',
        icon: Icons.account_balance_wallet_outlined,
      ),
      _MetricData(
        label: 'Savings realized',
        value: '₹8.42 Cr',
        note: '₹12.7 Cr pipeline',
        icon: Icons.savings_outlined,
      ),
      _MetricData(
        label: 'Supplier OTIF',
        value: '94.8%',
        note: '+1.9% vs last month',
        icon: Icons.verified_outlined,
      ),
      _MetricData(
        label: 'Forecast accuracy',
        value: '87.3%',
        note: '+4.1% this quarter',
        icon: Icons.insights_outlined,
      ),
      _MetricData(
        label: 'Inventory at risk',
        value: '₹3.6 Cr',
        note: 'Shortage + excess exposure',
        icon: Icons.inventory_2_outlined,
      ),
      _MetricData(
        label: 'Late shipments',
        value: '28',
        note: '9 high-priority',
        icon: Icons.local_shipping_outlined,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 1200
            ? 6
            : constraints.maxWidth >= 760
            ? 3
            : 2;
        const spacing = 12.0;
        final width =
            (constraints.maxWidth - spacing * (columns - 1)) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: metrics
              .map(
                (metric) => SizedBox(
                  width: width,
                  child: _MetricCard(data: metric),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _MetricData {
  const _MetricData({
    required this.label,
    required this.value,
    required this.note,
    required this.icon,
  });

  final String label;
  final String value;
  final String note;
  final IconData icon;
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.data});

  final _MetricData data;

  @override
  Widget build(BuildContext context) {
    return _GlassSurface(
      radius: 18,
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _GradientIcon(icon: data.icon),
          const SizedBox(height: 13),
          Text(
            data.value,
            style: const TextStyle(
              color: Color(0xFF0A1733),
              fontSize: 20,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.35,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            data.label,
            style: const TextStyle(
              color: Color(0xFF53667F),
              fontSize: 11.2,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            data.note,
            style: const TextStyle(
              color: Color(0xFF7D8B9E),
              fontSize: 10.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _ControlTowerPanel extends StatelessWidget {
  const _ControlTowerPanel();

  @override
  Widget build(BuildContext context) {
    return _Panel(
      title: 'Supply Chain Control Tower',
      subtitle: 'Priority exceptions across demand, supply, suppliers, and logistics.',
      child: Column(
        children: const <Widget>[
          _AlertRow(
            icon: Icons.warning_amber_rounded,
            title: 'Component shortage risk',
            detail: 'SKU RM-8821 · Pune plant · 2.4 days cover',
            impact: '₹1.2 Cr',
            tone: _Tone.warning,
          ),
          _PanelDivider(),
          _AlertRow(
            icon: Icons.local_shipping_outlined,
            title: 'Inbound shipment delay',
            detail: 'PO-880214 · Ocean · ETA +3.1 days',
            impact: 'High',
            tone: _Tone.warning,
          ),
          _PanelDivider(),
          _AlertRow(
            icon: Icons.storefront_outlined,
            title: 'Supplier performance deterioration',
            detail: 'Omega Components · OTIF down to 81%',
            impact: 'Watch',
            tone: _Tone.warning,
          ),
          _PanelDivider(),
          _AlertRow(
            icon: Icons.price_change_outlined,
            title: 'Purchase price variance',
            detail: 'Copper category · +6.8% vs contract baseline',
            impact: '₹42L',
            tone: _Tone.neutral,
          ),
          _PanelDivider(),
          _AlertRow(
            icon: Icons.description_outlined,
            title: 'Contract renewal window',
            detail: '18 contracts expire within 60 days',
            impact: '18',
            tone: _Tone.neutral,
          ),
        ],
      ),
    );
  }
}

class _AlertRow extends StatelessWidget {
  const _AlertRow({
    required this.icon,
    required this.title,
    required this.detail,
    required this.impact,
    required this.tone,
  });

  final IconData icon;
  final String title;
  final String detail;
  final String impact;
  final _Tone tone;

  @override
  Widget build(BuildContext context) {
    final color = tone == _Tone.warning
        ? const Color(0xFFD58D1F)
        : const Color(0xFF287DDF);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF213A59),
                    fontSize: 11.8,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  detail,
                  style: const TextStyle(
                    color: Color(0xFF76869A),
                    fontSize: 10.2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            impact,
            style: TextStyle(
              color: color,
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _SupplierHealthPanel extends StatelessWidget {
  const _SupplierHealthPanel();

  @override
  Widget build(BuildContext context) {
    const suppliers = <(String, double, String)>[
      ('Nova Electronics', 0.98, 'Low risk'),
      ('Apex Packaging', 0.94, 'Low risk'),
      ('Omega Components', 0.81, 'Watch'),
      ('Kinetic Metals', 0.89, 'Medium'),
      ('Prime Logistics', 0.96, 'Low risk'),
    ];

    return _Panel(
      title: 'Supplier Health',
      subtitle: 'Delivery, quality, risk, and responsiveness.',
      child: Column(
        children: suppliers
            .map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 13),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            item.$1,
                            style: const TextStyle(
                              color: Color(0xFF52667F),
                              fontSize: 10.8,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          item.$3,
                          style: TextStyle(
                            color: item.$2 < 0.85
                                ? const Color(0xFFD58D1F)
                                : const Color(0xFF19A86B),
                            fontSize: 9.8,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        value: item.$2,
                        minHeight: 7,
                        backgroundColor: const Color(0xFFE5EDF5),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          item.$2 < 0.85
                              ? const Color(0xFFD58D1F)
                              : const Color(0xFF19A86B),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _OperationsConfigurationCard extends StatefulWidget {
  const _OperationsConfigurationCard();

  @override
  State<_OperationsConfigurationCard> createState() =>
      _OperationsConfigurationCardState();
}

class _OperationsConfigurationCardState
    extends State<_OperationsConfigurationCard> {
  String _strategy = 'Balanced Cost + Service + Resilience';
  String _approval = 'Required for Awards & PO Writes';
  String _region = 'India / APAC';
  String _retry = 'Conservative (3 retries)';
  String _evidence = 'Strict';
  String _risk = 'Medium';
  bool _openAi = true;
  bool _anthropic = true;
  bool _gemini = true;
  bool _localModels = false;
  bool _supplierFollowUp = true;
  bool _draftPoChanges = true;
  bool _autoAward = false;
  bool _autoExpedite = false;

  @override
  Widget build(BuildContext context) {
    return _Panel(
      title: 'Procurement & Supply Configuration',
      subtitle: 'Adjust operating policies for this business category.',
      trailing: TextButton.icon(
        onPressed: () {
          setState(() {
            _strategy = 'Balanced Cost + Service + Resilience';
            _approval = 'Required for Awards & PO Writes';
            _region = 'India / APAC';
            _retry = 'Conservative (3 retries)';
            _evidence = 'Strict';
            _risk = 'Medium';
            _openAi = true;
            _anthropic = true;
            _gemini = true;
            _localModels = false;
            _supplierFollowUp = true;
            _draftPoChanges = true;
            _autoAward = false;
            _autoExpedite = false;
          });
        },
        icon: const Icon(Icons.restart_alt_rounded, size: 17),
        label: const Text('Reset'),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final twoColumns = constraints.maxWidth >= 720;

          final left = Column(
            children: <Widget>[
              _ConfigDropdown(
                label: 'Intelligence Strategy',
                value: _strategy,
                values: const <String>[
                  'Balanced Cost + Service + Resilience',
                  'Maximize Service Level',
                  'Maximize Savings',
                  'Minimize Working Capital',
                  'Resilience First',
                  'Private / Local First',
                ],
                onChanged: (value) => setState(() => _strategy = value!),
              ),
              const SizedBox(height: 12),
              const _ConfigLabel(label: 'Approved AI Providers'),
              const SizedBox(height: 7),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <Widget>[
                  _CheckPill(
                    label: 'OpenAI',
                    value: _openAi,
                    onChanged: (value) => setState(() => _openAi = value),
                  ),
                  _CheckPill(
                    label: 'Anthropic',
                    value: _anthropic,
                    onChanged: (value) => setState(() => _anthropic = value),
                  ),
                  _CheckPill(
                    label: 'Gemini',
                    value: _gemini,
                    onChanged: (value) => setState(() => _gemini = value),
                  ),
                  _CheckPill(
                    label: 'Local Models',
                    value: _localModels,
                    onChanged: (value) => setState(() => _localModels = value),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const _ConfigTextField(
                label: 'Maximum Cost per Workflow',
                prefix: '₹',
                value: '400.00',
                suffix: 'per run',
              ),
              const SizedBox(height: 12),
              _ConfigDropdown(
                label: 'Data Region',
                value: _region,
                values: const <String>[
                  'India / APAC',
                  'United States',
                  'European Union',
                  'United Kingdom',
                ],
                onChanged: (value) => setState(() => _region = value!),
              ),
            ],
          );

          final right = Column(
            children: <Widget>[
              _ConfigDropdown(
                label: 'Human Approval',
                value: _approval,
                values: const <String>[
                  'Required for Awards & PO Writes',
                  'Required for All External Writes',
                  'Required for High-Risk Actions',
                  'Manual Only',
                ],
                onChanged: (value) => setState(() => _approval = value!),
              ),
              const SizedBox(height: 12),
              const _ConfigLabel(label: 'Auto Actions'),
              const SizedBox(height: 7),
              _ToggleRow(
                label: 'Supplier follow-up drafts',
                value: _supplierFollowUp,
                onChanged: (value) => setState(() => _supplierFollowUp = value),
              ),
              _ToggleRow(
                label: 'Draft PO change proposals',
                value: _draftPoChanges,
                onChanged: (value) => setState(() => _draftPoChanges = value),
              ),
              _ToggleRow(
                label: 'Automatic sourcing award',
                value: _autoAward,
                onChanged: (value) => setState(() => _autoAward = value),
              ),
              _ToggleRow(
                label: 'Automatic expedite commitment',
                value: _autoExpedite,
                onChanged: (value) => setState(() => _autoExpedite = value),
              ),
              const SizedBox(height: 10),
              _ConfigDropdown(
                label: 'Supplier Risk Threshold',
                value: _risk,
                values: const <String>['Low', 'Medium', 'High'],
                onChanged: (value) => setState(() => _risk = value!),
              ),
              const SizedBox(height: 12),
              _ConfigDropdown(
                label: 'Retry Policy',
                value: _retry,
                values: const <String>[
                  'Conservative (3 retries)',
                  'Standard (2 retries)',
                  'Fast Fail',
                ],
                onChanged: (value) => setState(() => _retry = value!),
              ),
              const SizedBox(height: 12),
              _ConfigDropdown(
                label: 'Evidence Level',
                value: _evidence,
                values: const <String>['Strict', 'Standard', 'Compact'],
                onChanged: (value) => setState(() => _evidence = value!),
              ),
            ],
          );

          if (twoColumns) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(child: left),
                const SizedBox(width: 14),
                Expanded(child: right),
              ],
            );
          }

          return Column(
            children: <Widget>[
              left,
              const SizedBox(height: 14),
              right,
            ],
          );
        },
      ),
    );
  }
}

class _PlanningPolicyCard extends StatefulWidget {
  const _PlanningPolicyCard();

  @override
  State<_PlanningPolicyCard> createState() => _PlanningPolicyCardState();
}

class _PlanningPolicyCardState extends State<_PlanningPolicyCard> {
  bool _shortage = true;
  bool _lateShipment = true;
  bool _priceVariance = true;
  bool _contractLeakage = true;

  @override
  Widget build(BuildContext context) {
    return _Panel(
      title: 'Exception Policies',
      subtitle: 'Alerts and human attention thresholds.',
      child: Column(
        children: <Widget>[
          _ToggleRow(
            label: 'Material shortage alerts',
            value: _shortage,
            onChanged: (value) => setState(() => _shortage = value),
          ),
          _ToggleRow(
            label: 'Late shipment alerts',
            value: _lateShipment,
            onChanged: (value) => setState(() => _lateShipment = value),
          ),
          _ToggleRow(
            label: 'Purchase price variance alerts',
            value: _priceVariance,
            onChanged: (value) => setState(() => _priceVariance = value),
          ),
          _ToggleRow(
            label: 'Off-contract spend alerts',
            value: _contractLeakage,
            onChanged: (value) => setState(() => _contractLeakage = value),
          ),
        ],
      ),
    );
  }
}

class _ConnectedSystemsSummary extends StatelessWidget {
  const _ConnectedSystemsSummary();

  @override
  Widget build(BuildContext context) {
    const connectors = <(String, IconData)>[
      ('SAP S/4HANA', Icons.account_balance_rounded),
      ('SAP Ariba', Icons.shopping_bag_outlined),
      ('Coupa', Icons.shopping_cart_outlined),
      ('Kinaxis', Icons.timeline_rounded),
      ('project44', Icons.local_shipping_outlined),
      ('Local Bridge', Icons.computer_rounded),
    ];

    return _Panel(
      title: 'Connected Systems',
      subtitle: 'Key procurement and supply chain data sources.',
      child: Wrap(
        spacing: 9,
        runSpacing: 9,
        children: connectors
            .map(
              (item) => SizedBox(
                width: 178,
                child: _ConnectorMini(
                  title: item.$1,
                  icon: item.$2,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _ConnectorMini extends StatelessWidget {
  const _ConnectorMini({
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: const Color(0xA9FFFFFF),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: const Color(0xDCE6EFF5)),
      ),
      child: Row(
        children: <Widget>[
          _GradientIcon(icon: icon),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF1F3653),
                fontSize: 10.3,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Icon(
            Icons.circle,
            size: 7,
            color: Color(0xFF19A86B),
          ),
        ],
      ),
    );
  }
}

class _LiveOperationsPanel extends StatelessWidget {
  const _LiveOperationsPanel();

  @override
  Widget build(BuildContext context) {
    const rows = <List<String>>[
      ['PO-880214', 'Inbound PO', 'Delayed', '₹42.8L', 'Priya R.'],
      ['SRC-1048', 'Sourcing Event', 'Evaluating', '₹3.4Cr', 'Amit S.'],
      ['PLN-7712', 'Supply Plan', 'Running', '12 plants', 'Neha K.'],
      ['INV-3380', 'Inventory Rebalance', 'Review', '₹1.1Cr', 'John D.'],
      ['SHP-2291', 'Ocean Shipment', 'In Transit', '18 containers', 'Lisa T.'],
    ];

    return const _Panel(
      title: 'Live Operations',
      subtitle: 'Recent procurement and supply chain activity.',
      child: _SimpleTable(
        headers: <String>['ID', 'Operation', 'Status', 'Value', 'Owner'],
        rows: rows,
      ),
    );
  }
}

class _SelectedOperationPanel extends StatelessWidget {
  const _SelectedOperationPanel();

  @override
  Widget build(BuildContext context) {
    return _Panel(
      title: 'Selected Operation',
      subtitle: 'PO-880214 · Inbound purchase order',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Row(
            children: <Widget>[
              _StatusChip(label: 'Needs Action', tone: _Tone.warning),
              Spacer(),
              Text(
                'Exposure',
                style: TextStyle(
                  color: Color(0xFF7B899C),
                  fontSize: 10.5,
                ),
              ),
              SizedBox(width: 6),
              Text(
                '₹42.8L',
                style: TextStyle(
                  color: Color(0xFF0A1733),
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const _CheckLine(label: 'Supplier confirmation received'),
          const _CheckLine(label: 'Purchase terms checked'),
          const _CheckLine(label: 'Material requirement confirmed'),
          const _CheckLine(label: 'Shipment ETA evaluated'),
          const _CheckLine(
            label: 'Expedite decision required',
            pending: true,
          ),
          const SizedBox(height: 14),
          _PrimaryButton(
            label: 'Review Operation',
            icon: Icons.open_in_new_rounded,
            onPressed: () => _toast(context, 'Operation opened in demo mode.'),
          ),
        ],
      ),
    );
  }
}

class _CapabilityMatrix extends StatelessWidget {
  const _CapabilityMatrix();

  @override
  Widget build(BuildContext context) {
    const capabilities = <(String, IconData, String)>[
      ('Procurement Intake', Icons.inbox_outlined, 'Capture requests, triage demand, route approvals'),
      ('Spend Analytics', Icons.analytics_outlined, 'Classify spend, leakage, consolidation, savings'),
      ('Category Management', Icons.category_outlined, 'Strategies, initiatives, market and supplier plans'),
      ('Strategic Sourcing', Icons.travel_explore_rounded, 'RFx, bids, e-auctions, scenario awards'),
      ('Supplier Discovery', Icons.person_search_outlined, 'Identify and shortlist suppliers'),
      ('Supplier Qualification', Icons.verified_user_outlined, 'Questionnaires, certifications, qualification'),
      ('Supplier Onboarding', Icons.person_add_alt_rounded, 'Registration, master data, validation'),
      ('Supplier Risk', Icons.shield_outlined, 'Operational, financial, geopolitical, cyber, ESG'),
      ('Supplier Performance', Icons.speed_rounded, 'OTIF, quality, responsiveness, scorecards'),
      ('Contract Lifecycle', Icons.description_outlined, 'Authoring, obligations, renewals, compliance'),
      ('Guided Buying', Icons.shopping_cart_outlined, 'Catalogs, policy-aware buying, punchout'),
      ('Requisition to PO', Icons.receipt_long_outlined, 'Requisitions, approvals, purchase orders'),
      ('PO Change Management', Icons.edit_note_rounded, 'Confirmations, changes, cancellations, exceptions'),
      ('Supplier Collaboration', Icons.handshake_outlined, 'Forecasts, commits, ASN, order collaboration'),
      ('Direct Materials', Icons.precision_manufacturing_outlined, 'BOM-linked sourcing and material procurement'),
      ('Services Procurement', Icons.engineering_outlined, 'SOW, milestones, service receipt, supplier work'),
      ('Tail Spend', Icons.filter_alt_outlined, 'Low-value fragmented spend optimization'),
      ('Demand Planning', Icons.insights_outlined, 'Forecasting, demand sensing, consensus planning'),
      ('S&OP / IBP', Icons.groups_outlined, 'Demand, supply, finance, scenarios, executive review'),
      ('Supply Planning', Icons.timeline_rounded, 'MRP, capacity, constraints, material balancing'),
      ('Production Scheduling', Icons.factory_outlined, 'Finite scheduling, sequencing, change impact'),
      ('Inventory Optimization', Icons.inventory_2_outlined, 'Safety stock, MEIO, replenishment, allocation'),
      ('Order Promising', Icons.event_available_outlined, 'ATP/CTP, allocation, fulfillment choice'),
      ('Shortage Management', Icons.warning_amber_rounded, 'Material gaps, substitutions, expedite options'),
      ('Warehouse Operations', Icons.warehouse_outlined, 'Receiving, put-away, pick, pack, ship, cycle count'),
      ('Yard & Dock', Icons.location_on_outlined, 'Appointments, trailer/asset location, dock flow'),
      ('Transportation', Icons.local_shipping_outlined, 'Rates, routing, tendering, load planning, freight'),
      ('Shipment Visibility', Icons.radar_rounded, 'Multimode tracking, milestones, predictive ETA'),
      ('Trade & Customs', Icons.public_rounded, 'Screening, classification, customs and duty workflows'),
      ('Quality & Cold Chain', Icons.thermostat_outlined, 'Inspection, temperature, certificates, quarantine'),
      ('Network Design', Icons.hub_outlined, 'Scenario modeling, sites, lanes, capacity, cost'),
      ('Returns & Reverse Logistics', Icons.assignment_return_outlined, 'Returns, disposition, recovery, repair'),
      ('Supply Chain Control Tower', Icons.monitor_heart_outlined, 'Cross-network exceptions, impact, response'),
      ('Sustainability', Icons.eco_outlined, 'Supplier ESG, emissions, logistics and sourcing signals'),
      ('Maintenance & Spares', Icons.build_outlined, 'Critical spares, maintenance demand, service inventory'),
      ('Master Data Quality', Icons.data_object_outlined, 'Supplier, item, location, contract and lane quality'),
    ];

    return _Panel(
      title: 'Procurement & Supply Chain Solutions',
      subtitle: 'Coverage across source-to-pay, planning, execution, logistics, and resilience.',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final columns = constraints.maxWidth >= 1180
              ? 4
              : constraints.maxWidth >= 760
              ? 3
              : 1;
          const spacing = 12.0;
          final width =
              (constraints.maxWidth - spacing * (columns - 1)) / columns;

          return Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: capabilities
                .map(
                  (item) => SizedBox(
                    width: width,
                    child: _OperationTile(
                      title: item.$1,
                      icon: item.$2,
                      subtitle: item.$3,
                    ),
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}

class _SolutionsPage extends StatelessWidget {
  const _SolutionsPage();

  @override
  Widget build(BuildContext context) {
    const groups = <(String, List<(String, IconData, String)>)>[
      (
        'Procurement & Suppliers',
        <(String, IconData, String)>[
          ('Procurement Intake', Icons.inbox_outlined, 'Active'),
          ('Spend Analytics', Icons.analytics_outlined, 'Active'),
          ('Category Management', Icons.category_outlined, 'Configured'),
          ('Strategic Sourcing', Icons.travel_explore_rounded, 'Active'),
          ('eAuctions & Bid Optimization', Icons.gavel_outlined, 'Configured'),
          ('Supplier Discovery', Icons.person_search_outlined, 'Configured'),
          ('Supplier Qualification', Icons.verified_user_outlined, 'Active'),
          ('Supplier Onboarding', Icons.person_add_alt_rounded, 'Active'),
          ('Supplier Risk & Resilience', Icons.shield_outlined, 'Active'),
          ('Supplier Performance', Icons.speed_rounded, 'Active'),
          ('Contract Lifecycle', Icons.description_outlined, 'Active'),
          ('Guided Buying & Catalogs', Icons.shopping_cart_outlined, 'Active'),
          ('Requisition to PO', Icons.receipt_long_outlined, 'Active'),
          ('PO Change Management', Icons.edit_note_rounded, 'Active'),
          ('Supplier Collaboration', Icons.handshake_outlined, 'Active'),
          ('Direct Material Procurement', Icons.precision_manufacturing_outlined, 'Configured'),
          ('Services Procurement', Icons.engineering_outlined, 'Configured'),
          ('Tail Spend Optimization', Icons.filter_alt_outlined, 'Configured'),
        ],
      ),
      (
        'Planning & Supply',
        <(String, IconData, String)>[
          ('Demand Planning', Icons.insights_outlined, 'Active'),
          ('Demand Sensing', Icons.sensors_outlined, 'Configured'),
          ('S&OP / IBP', Icons.groups_outlined, 'Active'),
          ('Supply Planning', Icons.timeline_rounded, 'Active'),
          ('Capacity Planning', Icons.factory_outlined, 'Configured'),
          ('Production Scheduling', Icons.event_note_outlined, 'Configured'),
          ('Inventory Optimization', Icons.inventory_2_outlined, 'Active'),
          ('Order Promising', Icons.event_available_outlined, 'Configured'),
          ('Shortage Management', Icons.warning_amber_rounded, 'Active'),
          ('Allocation & Replenishment', Icons.swap_horiz_rounded, 'Configured'),
          ('Multi-Echelon Inventory', Icons.account_tree_outlined, 'Configured'),
          ('Scenario Planning', Icons.alt_route_rounded, 'Active'),
        ],
      ),
      (
        'Logistics & Execution',
        <(String, IconData, String)>[
          ('Warehouse Operations', Icons.warehouse_outlined, 'Active'),
          ('Yard & Dock Management', Icons.location_on_outlined, 'Configured'),
          ('Transportation Management', Icons.local_shipping_outlined, 'Active'),
          ('Freight Procurement', Icons.price_check_outlined, 'Configured'),
          ('Shipment Visibility', Icons.radar_rounded, 'Active'),
          ('Predictive ETA', Icons.schedule_rounded, 'Active'),
          ('Global Trade & Customs', Icons.public_rounded, 'Configured'),
          ('Quality Management', Icons.fact_check_outlined, 'Configured'),
          ('Cold Chain Monitoring', Icons.thermostat_outlined, 'Configured'),
          ('Returns & Reverse Logistics', Icons.assignment_return_outlined, 'Configured'),
          ('Network Design', Icons.hub_outlined, 'Configured'),
          ('Supply Chain Control Tower', Icons.monitor_heart_outlined, 'Active'),
          ('Sustainability & Emissions', Icons.eco_outlined, 'Configured'),
          ('Maintenance & Spares', Icons.build_outlined, 'Configured'),
        ],
      ),
    ];

    return _ScrollablePage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _PageTitle(
            title: 'Procurement & Supply Chain Solutions',
            subtitle:
                'Configure business capabilities independently while keeping a consistent enterprise workspace.',
          ),
          const SizedBox(height: 18),
          ...groups.expand(
            (group) => <Widget>[
              Text(
                group.$1,
                style: const TextStyle(
                  color: Color(0xFF172A46),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              _SolutionGrid(items: group.$2),
              const SizedBox(height: 22),
            ],
          ),
        ],
      ),
    );
  }
}

class _SolutionGrid extends StatelessWidget {
  const _SolutionGrid({required this.items});

  final List<(String, IconData, String)> items;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 1180
            ? 4
            : constraints.maxWidth >= 760
            ? 3
            : 1;
        const spacing = 12.0;
        final width =
            (constraints.maxWidth - spacing * (columns - 1)) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: items
              .map(
                (item) => SizedBox(
                  width: width,
                  child: _SolutionCard(
                    title: item.$1,
                    icon: item.$2,
                    status: item.$3,
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _SolutionCard extends StatelessWidget {
  const _SolutionCard({
    required this.title,
    required this.icon,
    required this.status,
  });

  final String title;
  final IconData icon;
  final String status;

  @override
  Widget build(BuildContext context) {
    return _GlassSurface(
      radius: 19,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              _GradientIcon(icon: icon),
              const Spacer(),
              _StatusChip(
                label: status,
                tone: status == 'Active' ? _Tone.success : _Tone.neutral,
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF1D3552),
              fontSize: 13.2,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 15),
          OutlinedButton(
            onPressed: () => _toast(context, '$title opened in demo mode.'),
            child: const Text('Open Solution'),
          ),
        ],
      ),
    );
  }
}

class _WorkflowsPage extends StatelessWidget {
  const _WorkflowsPage();

  @override
  Widget build(BuildContext context) {
    const rows = <List<String>>[
      ['Supplier Risk Watch', 'Supplier Risk', 'Hourly', 'Active', '1,284 suppliers'],
      ['Demand Forecast Refresh', 'Demand Planning', 'Daily 05:00', 'Active', '18,420 SKUs'],
      ['Supply Plan Rebalance', 'Supply Planning', 'Every 2 hours', 'Active', '12 plants'],
      ['Material Shortage Review', 'Shortage Management', 'Every 30 min', 'Active', '64 alerts'],
      ['Purchase Requisition Triage', 'Procurement Intake', 'On request', 'Active', '212 today'],
      ['Sourcing Event Evaluation', 'Strategic Sourcing', 'On bid close', 'Active', '7 events'],
      ['Supplier Onboarding Review', 'Supplier Management', 'On submission', 'Active', '18 pending'],
      ['PO Confirmation Follow-up', 'PO Management', 'Every 4 hours', 'Active', '83 open'],
      ['ASN & Inbound Exception', 'Supplier Collaboration', 'On event', 'Active', '29 today'],
      ['Inventory Rebalance', 'Inventory Optimization', 'Daily 04:00', 'Active', '38 locations'],
      ['Warehouse Backlog Watch', 'Warehouse', 'Every 15 min', 'Active', '6 sites'],
      ['Transport Tender Review', 'Transportation', 'On tender', 'Active', '48 loads'],
      ['Late Shipment Watch', 'Visibility', 'Every 15 min', 'Active', '28 late'],
      ['Trade Compliance Check', 'Global Trade', 'On shipment', 'Active', '156 today'],
      ['Contract Renewal Watch', 'Contracts', 'Daily', 'Active', '18 due'],
      ['Savings Validation', 'Spend Analytics', 'Weekly', 'Scheduled', '₹12.7 Cr pipeline'],
    ];

    return const _StandardTablePage(
      title: 'Procurement & Supply Workflows',
      subtitle: 'Schedules, triggers, and operational runs across the supply network.',
      headers: <String>['Workflow', 'Solution', 'Schedule', 'Status', 'Scope'],
      rows: rows,
      actionLabel: 'Create Workflow',
    );
  }
}

class _ConfigurationsPage extends StatelessWidget {
  const _ConfigurationsPage();

  @override
  Widget build(BuildContext context) {
    return _ScrollablePage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _PageTitle(
            title: 'Configurations',
            subtitle:
                'Manage intelligence strategy, approvals, cost limits, sourcing controls, planning thresholds, and evidence settings.',
          ),
          const SizedBox(height: 18),
          const _OperationsConfigurationCard(),
          const SizedBox(height: 18),
          LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth >= 900;
              if (wide) {
                return const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(child: _ProcurementPolicyCard()),
                    SizedBox(width: 16),
                    Expanded(child: _SupplyPolicyCard()),
                  ],
                );
              }
              return const Column(
                children: <Widget>[
                  _ProcurementPolicyCard(),
                  SizedBox(height: 16),
                  _SupplyPolicyCard(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ProcurementPolicyCard extends StatefulWidget {
  const _ProcurementPolicyCard();

  @override
  State<_ProcurementPolicyCard> createState() =>
      _ProcurementPolicyCardState();
}

class _ProcurementPolicyCardState extends State<_ProcurementPolicyCard> {
  bool _award = true;
  bool _poChange = true;
  bool _supplierOnboarding = true;
  bool _contract = true;

  @override
  Widget build(BuildContext context) {
    return _Panel(
      title: 'Procurement Controls',
      subtitle: 'Approval boundaries for high-impact procurement activity.',
      child: Column(
        children: <Widget>[
          _ToggleRow(
            label: 'Require approval for sourcing awards',
            value: _award,
            onChanged: (value) => setState(() => _award = value),
          ),
          _ToggleRow(
            label: 'Require approval for PO changes',
            value: _poChange,
            onChanged: (value) => setState(() => _poChange = value),
          ),
          _ToggleRow(
            label: 'Require supplier onboarding approval',
            value: _supplierOnboarding,
            onChanged: (value) => setState(() => _supplierOnboarding = value),
          ),
          _ToggleRow(
            label: 'Require contract deviation approval',
            value: _contract,
            onChanged: (value) => setState(() => _contract = value),
          ),
        ],
      ),
    );
  }
}

class _SupplyPolicyCard extends StatefulWidget {
  const _SupplyPolicyCard();

  @override
  State<_SupplyPolicyCard> createState() => _SupplyPolicyCardState();
}

class _SupplyPolicyCardState extends State<_SupplyPolicyCard> {
  String _service = '98%';
  String _forecast = 'Weekly';
  String _planning = 'Constraint-aware';
  String _inventory = 'Multi-echelon';

  @override
  Widget build(BuildContext context) {
    return _Panel(
      title: 'Planning & Inventory Policies',
      subtitle: 'Targets used by planning and exception workflows.',
      child: Column(
        children: <Widget>[
          _ConfigDropdown(
            label: 'Service Level Target',
            value: _service,
            values: const <String>['95%', '97%', '98%', '99%'],
            onChanged: (value) => setState(() => _service = value!),
          ),
          const SizedBox(height: 10),
          _ConfigDropdown(
            label: 'Forecast Review Cadence',
            value: _forecast,
            values: const <String>['Daily', 'Weekly', 'Monthly'],
            onChanged: (value) => setState(() => _forecast = value!),
          ),
          const SizedBox(height: 10),
          _ConfigDropdown(
            label: 'Supply Planning Mode',
            value: _planning,
            values: const <String>[
              'Constraint-aware',
              'Service-first',
              'Cost-first',
              'Resilience-first',
            ],
            onChanged: (value) => setState(() => _planning = value!),
          ),
          const SizedBox(height: 10),
          _ConfigDropdown(
            label: 'Inventory Policy',
            value: _inventory,
            values: const <String>[
              'Multi-echelon',
              'Safety stock',
              'Days of supply',
              'Min / Max',
            ],
            onChanged: (value) => setState(() => _inventory = value!),
          ),
        ],
      ),
    );
  }
}

class _ConnectorsPage extends StatelessWidget {
  const _ConnectorsPage();

  @override
  Widget build(BuildContext context) {
    const groups = <(String, List<(String, IconData, String, String)>)>[
      (
        'ERP, Source-to-Pay & Supplier',
        <(String, IconData, String, String)>[
          ('SAP S/4HANA', Icons.account_balance_rounded, 'ERP', 'Connected'),
          ('SAP Ariba', Icons.shopping_bag_outlined, 'Source-to-Pay', 'Connected'),
          ('Oracle Fusion', Icons.business_center_outlined, 'ERP / Procurement', 'Available'),
          ('Coupa', Icons.shopping_cart_outlined, 'Spend Management', 'Connected'),
          ('Ivalua', Icons.hub_outlined, 'Source-to-Pay', 'Available'),
          ('JAGGAER', Icons.account_tree_outlined, 'Source-to-Pay', 'Available'),
          ('Dynamics 365 SCM', Icons.window_rounded, 'ERP / SCM', 'Available'),
          ('NetSuite', Icons.apps_outlined, 'ERP', 'Connected'),
          ('Infor', Icons.factory_outlined, 'ERP / SCM', 'Available'),
          ('Workday', Icons.badge_outlined, 'Supplier / Finance', 'Available'),
        ],
      ),
      (
        'Planning, Warehouse & Execution',
        <(String, IconData, String, String)>[
          ('SAP IBP', Icons.timeline_rounded, 'Planning', 'Available'),
          ('Kinaxis', Icons.insights_outlined, 'Planning', 'Connected'),
          ('o9 Solutions', Icons.alt_route_rounded, 'IBP / Planning', 'Available'),
          ('Blue Yonder', Icons.grid_view_rounded, 'Planning / WMS / TMS', 'Available'),
          ('Manhattan Active', Icons.warehouse_outlined, 'WMS / TMS', 'Available'),
          ('Oracle WMS / TMS', Icons.inventory_2_outlined, 'Execution', 'Available'),
          ('e2open', Icons.public_rounded, 'Supply / Logistics / Trade', 'Available'),
          ('project44', Icons.radar_rounded, 'Visibility / TMS', 'Connected'),
          ('FourKites', Icons.location_on_outlined, 'Visibility / Yard', 'Available'),
          ('Descartes', Icons.route_outlined, 'Logistics / Trade', 'Available'),
        ],
      ),
      (
        'Commerce, Carriers & Network',
        <(String, IconData, String, String)>[
          ('Salesforce', Icons.cloud_outlined, 'CRM / Orders', 'Connected'),
          ('Shopify', Icons.storefront_outlined, 'Commerce', 'Available'),
          ('Amazon Seller Central', Icons.shopping_basket_outlined, 'Marketplace', 'Available'),
          ('FedEx', Icons.local_shipping_outlined, 'Carrier', 'Available'),
          ('UPS', Icons.local_shipping_outlined, 'Carrier', 'Available'),
          ('DHL', Icons.flight_takeoff_rounded, 'Carrier / Freight', 'Available'),
          ('Maersk', Icons.directions_boat_outlined, 'Ocean Carrier', 'Available'),
          ('EDI / AS2', Icons.swap_horiz_rounded, 'B2B Exchange', 'Available'),
          ('SFTP / FTP', Icons.folder_shared_outlined, 'File Exchange', 'Available'),
          ('Generic REST API', Icons.api_rounded, 'API', 'Available'),
        ],
      ),
      (
        'Data, Documents & Collaboration',
        <(String, IconData, String, String)>[
          ('Microsoft 365', Icons.mail_outline_rounded, 'Email / Files', 'Connected'),
          ('Google Workspace', Icons.alternate_email_rounded, 'Email / Files', 'Connected'),
          ('SharePoint', Icons.folder_copy_outlined, 'Documents', 'Connected'),
          ('OneDrive', Icons.cloud_queue_rounded, 'Files', 'Available'),
          ('Google Drive', Icons.add_to_drive_outlined, 'Files', 'Available'),
          ('Box', Icons.inventory_2_outlined, 'Files', 'Available'),
          ('Slack', Icons.chat_bubble_outline_rounded, 'Collaboration', 'Available'),
          ('Microsoft Teams', Icons.groups_outlined, 'Collaboration', 'Available'),
          ('Snowflake', Icons.ac_unit_rounded, 'Data Warehouse', 'Available'),
          ('Databricks', Icons.data_object_outlined, 'Lakehouse', 'Available'),
          ('PostgreSQL', Icons.storage_rounded, 'Database', 'Connected'),
          ('SQL Server', Icons.dns_outlined, 'Database', 'Available'),
          ('MySQL', Icons.storage_outlined, 'Database', 'Available'),
          ('Amazon S3', Icons.cloud_outlined, 'Object Storage', 'Available'),
          ('Azure Blob', Icons.cloud_queue_rounded, 'Object Storage', 'Available'),
          ('Google Cloud Storage', Icons.cloud_circle_outlined, 'Object Storage', 'Available'),
        ],
      ),
      (
        'Local Machine & Private Network',
        <(String, IconData, String, String)>[
          ('Neytra Local Bridge', Icons.computer_rounded, 'Local workspace access', 'Connected'),
          ('Local Folder', Icons.folder_outlined, 'Files / Watch Folder', 'Available'),
          ('Network Share', Icons.folder_shared_outlined, 'SMB / NFS', 'Available'),
          ('Desktop Application', Icons.desktop_windows_outlined, 'Local App', 'Available'),
          ('Local Database', Icons.storage_rounded, 'ODBC / JDBC', 'Available'),
          ('Local REST / HTTP', Icons.api_rounded, 'Private API', 'Available'),
          ('Local SFTP / FTP', Icons.swap_vert_rounded, 'File Transfer', 'Available'),
          ('CSV / Excel Watch Folder', Icons.table_chart_outlined, 'Local Files', 'Available'),
          ('Printer / Scanner', Icons.print_outlined, 'Local Device', 'Available'),
          ('On-Prem ERP Adapter', Icons.apartment_rounded, 'Private ERP', 'Available'),
        ],
      ),
    ];

    return _ScrollablePage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _PageTitle(
            title: 'Connectors',
            subtitle:
                'Connect enterprise systems, planning platforms, logistics networks, cloud data, and approved local resources.',
          ),
          const SizedBox(height: 18),
          ...groups.expand(
            (group) => <Widget>[
              Text(
                group.$1,
                style: const TextStyle(
                  color: Color(0xFF172A46),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              _ConnectorGrid(items: group.$2),
              const SizedBox(height: 22),
            ],
          ),
        ],
      ),
    );
  }
}

class _ConnectorGrid extends StatelessWidget {
  const _ConnectorGrid({required this.items});

  final List<(String, IconData, String, String)> items;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 1180
            ? 4
            : constraints.maxWidth >= 760
            ? 3
            : 1;
        const spacing = 12.0;
        final width =
            (constraints.maxWidth - spacing * (columns - 1)) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: items
              .map(
                (item) => SizedBox(
                  width: width,
                  child: _ConnectorCard(
                    title: item.$1,
                    icon: item.$2,
                    category: item.$3,
                    status: item.$4,
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _ConnectorCard extends StatelessWidget {
  const _ConnectorCard({
    required this.title,
    required this.icon,
    required this.category,
    required this.status,
  });

  final String title;
  final IconData icon;
  final String category;
  final String status;

  @override
  Widget build(BuildContext context) {
    final connected = status == 'Connected';

    return _GlassSurface(
      radius: 18,
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              _GradientIcon(icon: icon),
              const Spacer(),
              _StatusChip(
                label: status,
                tone: connected ? _Tone.success : _Tone.neutral,
              ),
            ],
          ),
          const SizedBox(height: 13),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF1E3553),
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            category,
            style: const TextStyle(
              color: Color(0xFF75859A),
              fontSize: 10.3,
            ),
          ),
          const SizedBox(height: 13),
          OutlinedButton(
            onPressed: () => _toast(
              context,
              connected ? '$title settings opened.' : '$title connection started.',
            ),
            child: Text(connected ? 'Manage' : 'Connect'),
          ),
        ],
      ),
    );
  }
}

class _ApprovalsPage extends StatelessWidget {
  const _ApprovalsPage();

  @override
  Widget build(BuildContext context) {
    const rows = <List<String>>[
      ['APR-2208', 'Sourcing Award', '₹3.4 Cr', 'Amit S.', 'High', 'Pending'],
      ['APR-2207', 'PO Increase', '₹42.8 L', 'Priya R.', 'High', 'Pending'],
      ['APR-2205', 'New Supplier', 'Omega Components', 'Neha K.', 'Medium', 'Pending'],
      ['APR-2202', 'Expedite Shipment', '₹8.6 L freight', 'Lisa T.', 'Medium', 'Pending'],
      ['APR-2197', 'Contract Deviation', '12-month term', 'John D.', 'Medium', 'Approved'],
      ['APR-2190', 'Inventory Write-off', '₹4.2 L', 'Arjun K.', 'Low', 'Approved'],
    ];

    return const _StandardTablePage(
      title: 'Approvals',
      subtitle: 'Sourcing, supplier, purchasing, inventory, and logistics decisions waiting for review.',
      headers: <String>['Approval', 'Type', 'Value', 'Owner', 'Risk', 'Status'],
      rows: rows,
      actionLabel: 'Review Queue',
    );
  }
}

class _EvidencePage extends StatelessWidget {
  const _EvidencePage();

  @override
  Widget build(BuildContext context) {
    const rows = <List<String>>[
      ['EV-11042', 'SRC-1048', 'RFQ + bids + award model', 'Complete', 'Today 10:42'],
      ['EV-11040', 'PO-880214', 'PO + confirmation + ASN', 'Complete', 'Today 10:19'],
      ['EV-11037', 'SHP-2291', 'BOL + tracking + ETA', 'Complete', 'Today 09:54'],
      ['EV-11031', 'SUP-4402', 'Qualification + certificates', 'Review', 'Today 09:08'],
      ['EV-11024', 'PLN-7712', 'Demand + supply + constraint inputs', 'Complete', 'Today 08:16'],
      ['EV-11017', 'TRD-0082', 'HS code + customs + screening', 'Complete', 'Yesterday'],
    ];

    return const _StandardTablePage(
      title: 'Evidence',
      subtitle: 'Supplier, sourcing, purchasing, planning, logistics, and trade records.',
      headers: <String>['Evidence', 'Operation', 'Contents', 'Status', 'Created'],
      rows: rows,
      actionLabel: 'Export Evidence',
    );
  }
}

class _AnalyticsPage extends StatelessWidget {
  const _AnalyticsPage();

  @override
  Widget build(BuildContext context) {
    return _ScrollablePage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _PageTitle(
            title: 'Procurement & Supply Analytics',
            subtitle:
                'Spend, savings, supplier performance, service, inventory, forecast, logistics, and risk.',
          ),
          const SizedBox(height: 18),
          const _ExecutiveMetricGrid(),
          const SizedBox(height: 18),
          LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth >= 900;
              const left = _BarAnalyticsCard(
                title: 'Spend by category',
                items: <(String, double, String)>[
                  ('Direct materials', 0.92, '₹86 Cr'),
                  ('Logistics', 0.61, '₹34 Cr'),
                  ('Packaging', 0.46, '₹26 Cr'),
                  ('IT & services', 0.36, '₹20 Cr'),
                  ('MRO', 0.29, '₹16 Cr'),
                ],
              );
              const right = _BarAnalyticsCard(
                title: 'Operational performance',
                items: <(String, double, String)>[
                  ('Supplier OTIF', 0.948, '94.8%'),
                  ('Forecast accuracy', 0.873, '87.3%'),
                  ('PO confirmation', 0.962, '96.2%'),
                  ('Inventory availability', 0.931, '93.1%'),
                  ('On-time transport', 0.905, '90.5%'),
                ],
              );
              return wide
                  ? const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(child: left),
                        SizedBox(width: 16),
                        Expanded(child: right),
                      ],
                    )
                  : const Column(
                      children: <Widget>[
                        left,
                        SizedBox(height: 16),
                        right,
                      ],
                    );
            },
          ),
          const SizedBox(height: 18),
          const _Panel(
            title: 'Savings & Risk Portfolio',
            subtitle: 'Sample initiatives and exposure',
            child: _SimpleTable(
              headers: <String>['Initiative', 'Category', 'Opportunity', 'Risk', 'Status'],
              rows: <List<String>>[
                ['Copper re-source', 'Metals', '₹2.4 Cr', 'Medium', 'Negotiation'],
                ['Ocean lane consolidation', 'Logistics', '₹1.8 Cr', 'Low', 'Approved'],
                ['Packaging standardization', 'Packaging', '₹1.2 Cr', 'Low', 'Execution'],
                ['Dual-source component A17', 'Electronics', '₹86 L', 'High', 'Qualification'],
                ['Tail-spend catalog', 'Indirect', '₹72 L', 'Low', 'Design'],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BarAnalyticsCard extends StatelessWidget {
  const _BarAnalyticsCard({
    required this.title,
    required this.items,
  });

  final String title;
  final List<(String, double, String)> items;

  @override
  Widget build(BuildContext context) {
    return _Panel(
      title: title,
      subtitle: 'Last 30 days',
      child: Column(
        children: items
            .map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 13),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            item.$1,
                            style: const TextStyle(
                              color: Color(0xFF52667F),
                              fontSize: 10.8,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          item.$3,
                          style: const TextStyle(
                            color: Color(0xFF0A1733),
                            fontSize: 10.8,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        value: item.$2,
                        minHeight: 8,
                        backgroundColor: const Color(0xFFE5EDF5),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF0878FF),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _UsersPage extends StatelessWidget {
  const _UsersPage();

  @override
  Widget build(BuildContext context) {
    const rows = <List<String>>[
      ['Sarah Roy', 'CPO / Admin', 'All Procurement & Supply', 'Active', 'Today'],
      ['Amit Shah', 'Strategic Sourcing Manager', 'Sourcing & Contracts', 'Active', 'Today'],
      ['Priya Raman', 'Buyer', 'Purchasing & Suppliers', 'Active', 'Today'],
      ['Neha Kulkarni', 'Supply Planner', 'Planning & Inventory', 'Active', 'Today'],
      ['Lisa Thomas', 'Logistics Manager', 'Transport & Visibility', 'Active', 'Yesterday'],
      ['John Davis', 'Warehouse Manager', 'Warehouse & Yard', 'Active', 'Yesterday'],
      ['Arjun Kumar', 'Risk & Compliance', 'Suppliers & Trade', 'Active', '2 days ago'],
      ['Mark Gupta', 'Auditor', 'Read Only', 'Active', '4 days ago'],
    ];

    return const _StandardTablePage(
      title: 'Users & Roles',
      subtitle: 'Manage procurement, planning, supplier, logistics, and warehouse access.',
      headers: <String>['User', 'Role', 'Scope', 'Status', 'Last active'],
      rows: rows,
      actionLabel: 'Invite User',
    );
  }
}

class _BillingPage extends StatelessWidget {
  const _BillingPage();

  @override
  Widget build(BuildContext context) {
    return _ScrollablePage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _PageTitle(
            title: 'Billing & Usage',
            subtitle:
                'Review workflow volume, solution spend, and budgets across procurement and supply chain.',
          ),
          const SizedBox(height: 18),
          const _Panel(
            title: 'Solution Usage',
            subtitle: 'Sample monthly allocation',
            child: _SimpleTable(
              headers: <String>['Solution', 'Runs', 'Spend', 'Budget', 'Status'],
              rows: <List<String>>[
                ['Procurement Intake', '4,218', '₹1.14L', '₹1.80L', 'Within budget'],
                ['Supplier Risk', '2,684', '₹96K', '₹1.40L', 'Within budget'],
                ['Demand Planning', '1,292', '₹1.84L', '₹2.20L', 'Within budget'],
                ['Supply Planning', '1,148', '₹1.72L', '₹2.10L', 'Within budget'],
                ['Shipment Visibility', '8,442', '₹1.26L', '₹1.50L', 'Watch'],
                ['Sourcing', '618', '₹88K', '₹1.20L', 'Within budget'],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StandardTablePage extends StatelessWidget {
  const _StandardTablePage({
    required this.title,
    required this.subtitle,
    required this.headers,
    required this.rows,
    required this.actionLabel,
  });

  final String title;
  final String subtitle;
  final List<String> headers;
  final List<List<String>> rows;
  final String actionLabel;

  @override
  Widget build(BuildContext context) {
    return _ScrollablePage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _PageTitle(
            title: title,
            subtitle: subtitle,
            trailing: _PrimaryButton(
              label: actionLabel,
              icon: Icons.add_rounded,
              onPressed: () => _toast(
                context,
                '$actionLabel opened in demo mode.',
              ),
            ),
          ),
          const SizedBox(height: 18),
          _Panel(
            title: title,
            subtitle: 'Demo data',
            child: _SimpleTable(
              headers: headers,
              rows: rows,
            ),
          ),
        ],
      ),
    );
  }
}

class _PageTitle extends StatelessWidget {
  const _PageTitle({
    required this.title,
    required this.subtitle,
    this.trailing,
  });

  final String title;
  final String subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final narrow = MediaQuery.sizeOf(context).width < 720;

    final copy = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: const Color(0xFF0A1733),
            fontSize: narrow ? 24 : 29,
            height: 1.12,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.65,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          subtitle,
          style: const TextStyle(
            color: Color(0xFF6C7B91),
            fontSize: 12.5,
            height: 1.45,
          ),
        ),
      ],
    );

    if (narrow || trailing == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          copy,
          if (trailing != null) ...<Widget>[
            const SizedBox(height: 12),
            trailing!,
          ],
        ],
      );
    }

    return Row(
      children: <Widget>[
        Expanded(child: copy),
        const SizedBox(width: 16),
        trailing!,
      ],
    );
  }
}

class _HeaderActions extends StatelessWidget {
  const _HeaderActions();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 8,
      children: <Widget>[
        OutlinedButton.icon(
          onPressed: () => _toast(context, 'Procurement request created.'),
          icon: const Icon(Icons.add_circle_outline_rounded, size: 17),
          label: const Text('New Request'),
        ),
        _PrimaryButton(
          label: 'Run Scenario',
          icon: Icons.play_arrow_rounded,
          onPressed: () => _toast(context, 'Scenario started in demo mode.'),
        ),
      ],
    );
  }
}

class _ConfigLabel extends StatelessWidget {
  const _ConfigLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF30445F),
          fontSize: 10.6,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _ConfigDropdown extends StatelessWidget {
  const _ConfigDropdown({
    required this.label,
    required this.value,
    required this.values,
    required this.onChanged,
  });

  final String label;
  final String value;
  final List<String> values;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _ConfigLabel(label: label),
        const SizedBox(height: 6),
        Container(
          height: 42,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xE7FFFFFF),
            borderRadius: BorderRadius.circular(11),
            border: Border.all(color: const Color(0xFFDFE7F0)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              style: const TextStyle(
                color: Color(0xFF1E3553),
                fontSize: 11.2,
                fontWeight: FontWeight.w600,
              ),
              items: values
                  .map(
                    (item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}

class _ConfigTextField extends StatelessWidget {
  const _ConfigTextField({
    required this.label,
    required this.prefix,
    required this.value,
    required this.suffix,
  });

  final String label;
  final String prefix;
  final String value;
  final String suffix;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _ConfigLabel(label: label),
        const SizedBox(height: 6),
        Container(
          height: 42,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xE7FFFFFF),
            borderRadius: BorderRadius.circular(11),
            border: Border.all(color: const Color(0xFFDFE7F0)),
          ),
          child: Row(
            children: <Widget>[
              Text(
                prefix,
                style: const TextStyle(
                  color: Color(0xFF51657E),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 7),
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF1E3553),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                suffix,
                style: const TextStyle(
                  color: Color(0xFF7C8B9E),
                  fontSize: 10.2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CheckPill extends StatelessWidget {
  const _CheckPill({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
        decoration: BoxDecoration(
          color: value ? const Color(0x150878FF) : const Color(0x96FFFFFF),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: value
                ? const Color(0x520878FF)
                : const Color(0xFFDDE6EF),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              value
                  ? Icons.check_box_rounded
                  : Icons.check_box_outline_blank_rounded,
              size: 17,
              color: value
                  ? const Color(0xFF0878FF)
                  : const Color(0xFF8C9AAD),
            ),
            const SizedBox(width: 5),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF314762),
                fontSize: 10.3,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  const _ToggleRow({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: Color(0xFF4C6078),
              fontSize: 10.7,
            ),
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: const Color(0xFF0878FF),
        ),
      ],
    );
  }
}

class _GradientIcon extends StatelessWidget {
  const _GradientIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF56F7F4),
            Color(0xFF0878FF),
            Color(0xFF1826E8),
          ],
        ),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x220878FF),
            blurRadius: 13,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Icon(icon, size: 18, color: Colors.white),
    );
  }
}

class _OperationTile extends StatelessWidget {
  const _OperationTile({
    required this.title,
    required this.icon,
    required this.subtitle,
  });

  final String title;
  final IconData icon;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xA8FFFFFF),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xDCE6EFF5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _GradientIcon(icon: icon),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF1E3553),
                    fontSize: 11.7,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF748398),
                    fontSize: 10.1,
                    height: 1.35,
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

class _CheckLine extends StatelessWidget {
  const _CheckLine({
    required this.label,
    this.pending = false,
  });

  final String label;
  final bool pending;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          Icon(
            pending ? Icons.schedule_rounded : Icons.check_circle_rounded,
            size: 17,
            color: pending
                ? const Color(0xFFD99524)
                : const Color(0xFF19A86B),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF53677F),
                fontSize: 10.7,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SimpleTable extends StatelessWidget {
  const _SimpleTable({
    required this.headers,
    required this.rows,
  });

  final List<String> headers;
  final List<List<String>> rows;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowHeight: 39,
        dataRowMinHeight: 42,
        dataRowMaxHeight: 47,
        columnSpacing: 24,
        dividerThickness: 0.65,
        headingTextStyle: const TextStyle(
          color: Color(0xFF65758A),
          fontSize: 10.2,
          fontWeight: FontWeight.w700,
        ),
        dataTextStyle: const TextStyle(
          color: Color(0xFF30445F),
          fontSize: 10.5,
          fontWeight: FontWeight.w500,
        ),
        columns: headers
            .map((header) => DataColumn(label: Text(header)))
            .toList(),
        rows: rows
            .map(
              (row) => DataRow(
                cells: row
                    .map(
                      (cell) => DataCell(
                        Text(
                          cell,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                    .toList(),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _Panel extends StatelessWidget {
  const _Panel({
    required this.title,
    required this.subtitle,
    required this.child,
    this.trailing,
  });

  final String title;
  final String subtitle;
  final Widget child;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return _GlassSurface(
      radius: 22,
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: const TextStyle(
                        color: Color(0xFF172A46),
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xFF7B899D),
                        fontSize: 10.5,
                      ),
                    ),
                  ],
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
          const SizedBox(height: 15),
          child,
        ],
      ),
    );
  }
}

class _ScrollablePage extends StatelessWidget {
  const _ScrollablePage({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        MediaQuery.sizeOf(context).width >= 1080 ? 24 : 16,
        14,
        MediaQuery.sizeOf(context).width >= 1080 ? 24 : 16,
        34,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1440),
          child: child,
        ),
      ),
    );
  }
}

class _PanelDivider extends StatelessWidget {
  const _PanelDivider();

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 1,
      color: Color(0x84DCE6F0),
    );
  }
}

enum _Tone { success, warning, neutral }

class _StatusChip extends StatelessWidget {
  const _StatusChip({
    required this.label,
    required this.tone,
  });

  final String label;
  final _Tone tone;

  @override
  Widget build(BuildContext context) {
    final colors = switch (tone) {
      _Tone.success => (
          const Color(0xFF19A86B),
          const Color(0x1419A86B),
          const Color(0x3519A86B),
        ),
      _Tone.warning => (
          const Color(0xFFD99020),
          const Color(0x14D99020),
          const Color(0x35D99020),
        ),
      _Tone.neutral => (
          const Color(0xFF526B89),
          const Color(0x14526B89),
          const Color(0x35526B89),
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: colors.$2,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: colors.$3),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: colors.$1,
          fontSize: 9.3,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: <Color>[
            Color(0xFF27DFF0),
            Color(0xFF0878FF),
            Color(0xFF1839E8),
          ],
        ),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x260878FF),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: FilledButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 17),
        label: Text(label),
        style: FilledButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.white,
          minimumSize: const Size(0, 42),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}

class _GlassSurface extends StatelessWidget {
  const _GlassSurface({
    required this.radius,
    required this.padding,
    required this.child,
  });

  final double radius;
  final EdgeInsets padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(radius);

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x11173A66),
            blurRadius: 28,
            offset: Offset(0, 13),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Color(0xE8FFFFFF),
                  Color(0xC9F9FBFE),
                  Color(0xB8F0F7FD),
                ],
              ),
              border: Border.all(
                color: const Color(0xEFFFFFFF),
                width: 1.1,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

void _toast(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF0A1733),
      ),
    );
}

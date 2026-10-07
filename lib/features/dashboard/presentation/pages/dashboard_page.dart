/*
Copyright (c) 2026 Neytra Intelligence Platform. All rights reserved.

This software and its source code are proprietary and confidential.

No permission is granted to copy, modify, distribute, sublicense, sell, or otherwise use this software without prior written permission from the copyright holder.

Unauthorized use, reproduction, or distribution is prohibited.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.
*/

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../procurement_supply_chain/presentation/pages/procurement_workspace_body.dart';

enum _WorkspaceSection {
  overview,
  solutions,
  workflows,
  configurations,
  connectors,
  approvals,
  evidence,
  analytics,
  users,
  billing,
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  _WorkspaceSection _section = _WorkspaceSection.overview;
  String _businessArea = 'Finance & Accounting';
  String _environment = 'Production';

  void _selectSection(_WorkspaceSection section) {
    setState(() => _section = section);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= 1080;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          const _WorkspaceBackground(),
          SafeArea(
            child: isDesktop
                ? Row(
                    children: <Widget>[
                      _DesktopSidebar(
                        selected: _section,
                        onSelected: _selectSection,
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            _TopBar(
                              businessArea: _businessArea,
                              environment: _environment,
                              onBusinessAreaChanged: (value) {
                                if (value != null) {
                                  setState(() => _businessArea = value);
                                }
                              },
                              onEnvironmentChanged: (value) {
                                if (value != null) {
                                  setState(() => _environment = value);
                                }
                              },
                            ),
                            Expanded(
                              child: _WorkspaceBody(
                                section: _section,
                                businessArea: _businessArea,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: <Widget>[
                      _MobileHeader(
                        businessArea: _businessArea,
                        onBusinessAreaChanged: (value) {
                          if (value != null) {
                            setState(() => _businessArea = value);
                          }
                        },
                      ),
                      Expanded(
                        child: _WorkspaceBody(
                          section: _section,
                          businessArea: _businessArea,
                        ),
                      ),
                      _MobileNavigation(
                        selected: _section,
                        onSelected: _selectSection,
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class _WorkspaceBackground extends StatelessWidget {
  const _WorkspaceBackground();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFFFFFCF8),
            Color(0xFFF7F9FC),
            Color(0xFFEEF5FB),
            Color(0xFFF9FBFD),
          ],
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned(
            left: -180,
            top: -170,
            child: _AmbientOrb(
              size: 540,
              colors: <Color>[
                Color(0x2456F7F4),
                Color(0x0B0878FF),
                Color(0x00FFFFFF),
              ],
            ),
          ),
          Positioned(
            right: -160,
            bottom: -210,
            child: _AmbientOrb(
              size: 620,
              colors: <Color>[
                Color(0x230878FF),
                Color(0x091826E8),
                Color(0x00FFFFFF),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AmbientOrb extends StatelessWidget {
  const _AmbientOrb({
    required this.size,
    required this.colors,
  });

  final double size;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: SizedBox(
        width: size,
        height: size,
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(colors: colors),
          ),
        ),
      ),
    );
  }
}

class _DesktopSidebar extends StatelessWidget {
  const _DesktopSidebar({
    required this.selected,
    required this.onSelected,
  });

  final _WorkspaceSection selected;
  final ValueChanged<_WorkspaceSection> onSelected;

  @override
  Widget build(BuildContext context) {
    const items = <(_WorkspaceSection, IconData, String)>[
      (_WorkspaceSection.overview, Icons.grid_view_rounded, 'Overview'),
      (
        _WorkspaceSection.solutions,
        Icons.auto_awesome_mosaic_outlined,
        'Solutions',
      ),
      (_WorkspaceSection.workflows, Icons.account_tree_outlined, 'Workflows'),
      (
        _WorkspaceSection.configurations,
        Icons.tune_rounded,
        'Configurations',
      ),
      (_WorkspaceSection.connectors, Icons.hub_outlined, 'Connectors'),
      (_WorkspaceSection.approvals, Icons.approval_outlined, 'Approvals'),
      (_WorkspaceSection.evidence, Icons.fact_check_outlined, 'Evidence'),
      (_WorkspaceSection.analytics, Icons.query_stats_outlined, 'Analytics'),
      (_WorkspaceSection.users, Icons.group_outlined, 'Users & Roles'),
      (_WorkspaceSection.billing, Icons.credit_card_outlined, 'Billing'),
    ];

    return Container(
      width: 252,
      margin: const EdgeInsets.fromLTRB(16, 16, 0, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xF30A1E3A),
            Color(0xF20A284C),
            Color(0xF10B315A),
          ],
        ),
        border: Border.all(color: const Color(0x2EFFFFFF)),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x2C071B33),
            blurRadius: 42,
            offset: Offset(0, 20),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          children: <Widget>[
            const Positioned(
              top: -80,
              right: -100,
              child: _AmbientOrb(
                size: 260,
                colors: <Color>[
                  Color(0x3856F7F4),
                  Color(0x140878FF),
                  Color(0x00000000),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 22, 18, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const _SidebarBrand(),
                  const SizedBox(height: 24),
                  const Text(
                    'WORKSPACE',
                    style: TextStyle(
                      color: Color(0xFF8CA7C2),
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.4,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: items
                          .map(
                            (item) => _SidebarNavItem(
                              icon: item.$2,
                              label: item.$3,
                              selected: item.$1 == selected,
                              onTap: () => onSelected(item.$1),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const Divider(color: Color(0x24FFFFFF)),
                  const SizedBox(height: 8),
                  _SidebarNavItem(
                    icon: Icons.logout_rounded,
                    label: 'Sign out',
                    selected: false,
                    onTap: () => context.go('/login'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SidebarBrand extends StatelessWidget {
  const _SidebarBrand();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Image.asset(
          'assets/branding/logo/neytra_n.png',
          height: 38,
          filterQuality: FilterQuality.high,
        ),
        const SizedBox(width: 11),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'NEYTRA',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2.8,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Business Console',
                style: TextStyle(
                  color: Color(0xFFA9BDD2),
                  fontSize: 10.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SidebarNavItem extends StatelessWidget {
  const _SidebarNavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient: selected
                  ? const LinearGradient(
                      colors: <Color>[
                        Color(0x4A21DDF2),
                        Color(0x4A0878FF),
                      ],
                    )
                  : null,
              border: selected
                  ? Border.all(color: const Color(0x3DFFFFFF))
                  : null,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              child: Row(
                children: <Widget>[
                  Icon(
                    icon,
                    size: 19,
                    color: selected
                        ? const Color(0xFF67F1F6)
                        : const Color(0xFF9FB4CA),
                  ),
                  const SizedBox(width: 11),
                  Text(
                    label,
                    style: TextStyle(
                      color: selected
                          ? Colors.white
                          : const Color(0xFFD2DEEA),
                      fontSize: 13,
                      fontWeight: selected
                          ? FontWeight.w700
                          : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.businessArea,
    required this.environment,
    required this.onBusinessAreaChanged,
    required this.onEnvironmentChanged,
  });

  final String businessArea;
  final String environment;
  final ValueChanged<String?> onBusinessAreaChanged;
  final ValueChanged<String?> onEnvironmentChanged;

  static const _areas = <String>[
    'Finance & Accounting',
    'Procurement & Supply Chain',
    'Customer Support & Success',
    'Sales & Revenue',
    'HR & People Operations',
    'IT & Operations',
    'Legal, Compliance & Risk',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
      child: Row(
        children: <Widget>[
          _TopDropdown(
            icon: Icons.apartment_rounded,
            value: 'Acme Corporation',
            values: const <String>[
              'Acme Corporation',
              'Northstar Holdings',
              'Demo Organization',
            ],
            onChanged: (_) {},
            width: 190,
          ),
          const SizedBox(width: 10),
          _TopDropdown(
            icon: Icons.business_center_outlined,
            value: businessArea,
            values: _areas,
            onChanged: onBusinessAreaChanged,
            width: 220,
          ),
          const SizedBox(width: 10),
          _TopDropdown(
            icon: Icons.circle,
            value: environment,
            values: const <String>['Production', 'Sandbox'],
            onChanged: onEnvironmentChanged,
            width: 140,
          ),
          const SizedBox(width: 18),
          const Expanded(child: _SearchBox()),
          const SizedBox(width: 12),
          const _TopIcon(icon: Icons.help_outline_rounded),
          const SizedBox(width: 8),
          const _TopIcon(icon: Icons.notifications_none_rounded),
          const SizedBox(width: 12),
          const CircleAvatar(
            radius: 19,
            backgroundColor: Color(0xFF315E9F),
            child: Text(
              'SR',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopDropdown extends StatelessWidget {
  const _TopDropdown({
    required this.icon,
    required this.value,
    required this.values,
    required this.onChanged,
    required this.width,
  });

  final IconData icon;
  final String value;
  final List<String> values;
  final ValueChanged<String?> onChanged;
  final double width;

  @override
  Widget build(BuildContext context) {
    return _GlassSurface(
      radius: 14,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: SizedBox(
        width: width,
        height: 44,
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              size: icon == Icons.circle ? 10 : 18,
              color: icon == Icons.circle
                  ? const Color(0xFF18A66B)
                  : const Color(0xFF526B89),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: value,
                  isExpanded: true,
                  style: const TextStyle(
                    color: Color(0xFF152742),
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 18,
                    color: Color(0xFF60748F),
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
        ),
      ),
    );
  }
}

class _SearchBox extends StatelessWidget {
  const _SearchBox();

  @override
  Widget build(BuildContext context) {
    return _GlassSurface(
      radius: 14,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: const SizedBox(
        height: 44,
        child: TextField(
          decoration: InputDecoration(
            filled: false,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            prefixIcon: Icon(
              Icons.search_rounded,
              color: Color(0xFF71839B),
              size: 20,
            ),
            hintText: 'Search outcomes, workflows, evidence...',
            hintStyle: TextStyle(
              color: Color(0xFF93A0B1),
              fontSize: 12.5,
            ),
          ),
        ),
      ),
    );
  }
}

class _TopIcon extends StatelessWidget {
  const _TopIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return _GlassSurface(
      radius: 999,
      padding: const EdgeInsets.all(10),
      child: Icon(
        icon,
        size: 20,
        color: const Color(0xFF526B89),
      ),
    );
  }
}

class _MobileHeader extends StatelessWidget {
  const _MobileHeader({
    required this.businessArea,
    required this.onBusinessAreaChanged,
  });

  final String businessArea;
  final ValueChanged<String?> onBusinessAreaChanged;

  @override
  Widget build(BuildContext context) {
    const areas = <String>[
      'Finance & Accounting',
      'Procurement & Supply Chain',
      'Customer Support & Success',
      'Sales & Revenue',
      'HR & People Operations',
      'IT & Operations',
      'Legal, Compliance & Risk',
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
      child: Row(
        children: <Widget>[
          Image.asset(
            'assets/branding/logo/neytra_n.png',
            height: 34,
            filterQuality: FilterQuality.high,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: businessArea,
                isExpanded: true,
                style: const TextStyle(
                  color: Color(0xFF0A1733),
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
                items: areas
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
                onChanged: onBusinessAreaChanged,
              ),
            ),
          ),
          _RoundAction(
            icon: Icons.logout_rounded,
            onTap: () => context.go('/login'),
          ),
        ],
      ),
    );
  }
}

class _RoundAction extends StatelessWidget {
  const _RoundAction({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xB8FFFFFF),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(
            icon,
            size: 20,
            color: const Color(0xFF526B89),
          ),
        ),
      ),
    );
  }
}

class _MobileNavigation extends StatelessWidget {
  const _MobileNavigation({
    required this.selected,
    required this.onSelected,
  });

  final _WorkspaceSection selected;
  final ValueChanged<_WorkspaceSection> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xF2FFFFFF),
        border: Border(
          top: BorderSide(color: Color(0x8FDDE6EF)),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 12),
      child: Row(
        children: <Widget>[
          _MobileNavItem(
            icon: Icons.grid_view_rounded,
            label: 'Overview',
            selected: selected == _WorkspaceSection.overview,
            onTap: () => onSelected(_WorkspaceSection.overview),
          ),
          _MobileNavItem(
            icon: Icons.auto_awesome_mosaic_outlined,
            label: 'Solutions',
            selected: selected == _WorkspaceSection.solutions,
            onTap: () => onSelected(_WorkspaceSection.solutions),
          ),
          _MobileNavItem(
            icon: Icons.approval_outlined,
            label: 'Approvals',
            selected: selected == _WorkspaceSection.approvals,
            onTap: () => onSelected(_WorkspaceSection.approvals),
          ),
          _MobileNavItem(
            icon: Icons.more_horiz_rounded,
            label: 'More',
            selected: !{
              _WorkspaceSection.overview,
              _WorkspaceSection.solutions,
              _WorkspaceSection.approvals,
            }.contains(selected),
            onTap: () => _showMobileMenu(context),
          ),
        ],
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        final items = <(_WorkspaceSection, IconData, String)>[
          (_WorkspaceSection.workflows, Icons.account_tree_outlined, 'Workflows'),
          (_WorkspaceSection.configurations, Icons.tune_rounded, 'Configurations'),
          (_WorkspaceSection.connectors, Icons.hub_outlined, 'Connectors'),
          (_WorkspaceSection.evidence, Icons.fact_check_outlined, 'Evidence'),
          (_WorkspaceSection.analytics, Icons.query_stats_outlined, 'Analytics'),
          (_WorkspaceSection.users, Icons.group_outlined, 'Users & Roles'),
          (_WorkspaceSection.billing, Icons.credit_card_outlined, 'Billing'),
        ];

        return Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.fromLTRB(14, 16, 14, 18),
          decoration: BoxDecoration(
            color: const Color(0xF7FFFFFF),
            borderRadius: BorderRadius.circular(26),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: items
                .map(
                  (item) => ListTile(
                    leading: Icon(item.$2, color: const Color(0xFF287DDF)),
                    title: Text(item.$3),
                    onTap: () {
                      Navigator.of(sheetContext).pop();
                      onSelected(item.$1);
                    },
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}

class _MobileNavItem extends StatelessWidget {
  const _MobileNavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected
        ? const Color(0xFF0878FF)
        : const Color(0xFF738196);

    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, size: 21, color: color),
              const SizedBox(height: 3),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 10,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WorkspaceBody extends StatelessWidget {
  const _WorkspaceBody({
    required this.section,
    required this.businessArea,
  });

  final _WorkspaceSection section;
  final String businessArea;

  @override
  Widget build(BuildContext context) {
    if (businessArea == 'Procurement & Supply Chain') {
      return ProcurementWorkspaceBody(section: section.name);
    }

    if (businessArea != 'Finance & Accounting') {
      return _CategoryPlaceholder(
        businessArea: businessArea,
        section: section,
      );
    }

    final page = switch (section) {
      _WorkspaceSection.overview => const _FinanceOverviewPage(),
      _WorkspaceSection.solutions => const _SolutionsPage(),
      _WorkspaceSection.workflows => const _WorkflowsPage(),
      _WorkspaceSection.configurations => const _ConfigurationsPage(),
      _WorkspaceSection.connectors => const _ConnectorsPage(),
      _WorkspaceSection.approvals => const _ApprovalsPage(),
      _WorkspaceSection.evidence => const _EvidencePage(),
      _WorkspaceSection.analytics => const _AnalyticsPage(),
      _WorkspaceSection.users => const _UsersPage(),
      _WorkspaceSection.billing => const _BillingPage(),
    };

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 180),
      child: KeyedSubtree(
        key: ValueKey<_WorkspaceSection>(section),
        child: page,
      ),
    );
  }
}

class _CategoryPlaceholder extends StatelessWidget {
  const _CategoryPlaceholder({
    required this.businessArea,
    required this.section,
  });

  final String businessArea;
  final _WorkspaceSection section;

  @override
  Widget build(BuildContext context) {
    return _ScrollablePage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _PageTitle(
            title: businessArea,
            subtitle:
                'This category is ready for its own solutions, policies, metrics, and workflows.',
          ),
          const SizedBox(height: 20),
          _GlassSurface(
            radius: 24,
            padding: const EdgeInsets.all(24),
            child: Column(
              children: <Widget>[
                const Icon(
                  Icons.dashboard_customize_outlined,
                  size: 42,
                  color: Color(0xFF0878FF),
                ),
                const SizedBox(height: 14),
                Text(
                  _sectionTitle(section),
                  style: const TextStyle(
                    color: Color(0xFF0A1733),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Category-specific sample content can be added here without changing the application shell.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF6B7B91),
                    fontSize: 13,
                    height: 1.5,
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

String _sectionTitle(_WorkspaceSection section) {
  return switch (section) {
    _WorkspaceSection.overview => 'Overview',
    _WorkspaceSection.solutions => 'Solutions',
    _WorkspaceSection.workflows => 'Workflows',
    _WorkspaceSection.configurations => 'Configurations',
    _WorkspaceSection.connectors => 'Connectors',
    _WorkspaceSection.approvals => 'Approvals',
    _WorkspaceSection.evidence => 'Evidence',
    _WorkspaceSection.analytics => 'Analytics',
    _WorkspaceSection.users => 'Users & Roles',
    _WorkspaceSection.billing => 'Billing',
  };
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

class _FinanceOverviewPage extends StatelessWidget {
  const _FinanceOverviewPage();

  @override
  Widget build(BuildContext context) {
    return _ScrollablePage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _PageTitle(
            title: 'Finance & Accounting',
            subtitle:
                'Monitor cash, payables, receivables, close, controls, and financial activity in one workspace.',
            trailing: _HeaderActions(),
          ),
          const SizedBox(height: 18),
          const _FinanceJourneyBar(),
          const SizedBox(height: 18),
          const _FinanceMetricGrid(),
          const SizedBox(height: 18),
          LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth >= 1060;
              if (wide) {
                return const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(flex: 7, child: _SolutionConfigurationCard()),
                    SizedBox(width: 16),
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: <Widget>[
                          _ConnectorSummaryCard(),
                          SizedBox(height: 16),
                          _GovernanceCard(),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return const Column(
                children: <Widget>[
                  _SolutionConfigurationCard(),
                  SizedBox(height: 16),
                  _ConnectorSummaryCard(),
                  SizedBox(height: 16),
                  _GovernanceCard(),
                ],
              );
            },
          ),
          const SizedBox(height: 18),
          LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth >= 1060;
              if (wide) {
                return const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(flex: 7, child: _LiveFinanceOutcomes()),
                    SizedBox(width: 16),
                    Expanded(flex: 5, child: _VerifiedFinanceOutcome()),
                  ],
                );
              }
              return const Column(
                children: <Widget>[
                  _LiveFinanceOutcomes(),
                  SizedBox(height: 16),
                  _VerifiedFinanceOutcome(),
                ],
              );
            },
          ),
          const SizedBox(height: 18),
          const _FinanceOperationsMatrix(),
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
            fontSize: narrow ? 25 : 30,
            height: 1.12,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.7,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          subtitle,
          style: const TextStyle(
            color: Color(0xFF6C7B91),
            fontSize: 13,
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(child: copy),
        const SizedBox(width: 18),
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
          onPressed: () => _toast(context, 'Demo outcome created.'),
          icon: const Icon(Icons.add_circle_outline_rounded, size: 18),
          label: const Text('Create Outcome'),
        ),
        _PrimaryButton(
          label: 'Publish Config',
          icon: Icons.publish_rounded,
          onPressed: () => _toast(context, 'Configuration published in demo mode.'),
        ),
      ],
    );
  }
}

class _FinanceJourneyBar extends StatelessWidget {
  const _FinanceJourneyBar();

  @override
  Widget build(BuildContext context) {
    const steps = <(String, IconData)>[
      ('Connect Systems', Icons.storage_rounded),
      ('Choose Solution', Icons.apps_rounded),
      ('Adjust Config', Icons.tune_rounded),
      ('Launch Workflow', Icons.play_arrow_rounded),
      ('Review Evidence', Icons.fact_check_outlined),
      ('Track Impact', Icons.query_stats_outlined),
    ];

    return _GlassSurface(
      radius: 22,
      padding: const EdgeInsets.all(16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 850;
          if (compact) {
            return Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List<Widget>.generate(
                steps.length,
                (index) => _JourneyStep(
                  number: index + 1,
                  label: steps[index].$1,
                  icon: steps[index].$2,
                ),
              ),
            );
          }

          return Row(
            children: List<Widget>.generate(steps.length, (index) {
              return Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: _JourneyStep(
                        number: index + 1,
                        label: steps[index].$1,
                        icon: steps[index].$2,
                      ),
                    ),
                    if (index < steps.length - 1)
                      const Icon(
                        Icons.arrow_forward_rounded,
                        size: 18,
                        color: Color(0xFF9AABBD),
                      ),
                  ],
                ),
              );
            }),
          );
        },
      ),
    );
  }
}

class _JourneyStep extends StatelessWidget {
  const _JourneyStep({
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
          width: 34,
          height: 34,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: <Color>[
                Color(0xFF42EAF3),
                Color(0xFF0878FF),
                Color(0xFF173BE8),
              ],
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            '$number',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Icon(icon, size: 17, color: const Color(0xFF287DDF)),
        const SizedBox(width: 5),
        Flexible(
          child: Text(
            label,
            style: const TextStyle(
              color: Color(0xFF243B5B),
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class _FinanceMetricGrid extends StatelessWidget {
  const _FinanceMetricGrid();

  @override
  Widget build(BuildContext context) {
    const metrics = <_MetricData>[
      _MetricData(
        label: 'Cash position',
        value: '₹12.84 Cr',
        note: '+4.2% this month',
        icon: Icons.account_balance_wallet_outlined,
      ),
      _MetricData(
        label: 'Accounts payable',
        value: '₹3.18 Cr',
        note: '₹84L due in 7 days',
        icon: Icons.receipt_long_outlined,
      ),
      _MetricData(
        label: 'Accounts receivable',
        value: '₹4.72 Cr',
        note: '18.6% overdue',
        icon: Icons.request_quote_outlined,
      ),
      _MetricData(
        label: 'Operating spend',
        value: '₹2.41 Cr',
        note: '3.1% under budget',
        icon: Icons.payments_outlined,
      ),
      _MetricData(
        label: 'Close readiness',
        value: '86%',
        note: '12 items remaining',
        icon: Icons.task_alt_rounded,
      ),
      _MetricData(
        label: 'Exceptions',
        value: '23',
        note: '7 require review',
        icon: Icons.warning_amber_rounded,
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
              fontSize: 21,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            data.label,
            style: const TextStyle(
              color: Color(0xFF53667F),
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            data.note,
            style: const TextStyle(
              color: Color(0xFF7E8DA0),
              fontSize: 10.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _GradientIcon extends StatelessWidget {
  const _GradientIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
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
            color: Color(0x240878FF),
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Icon(icon, size: 19, color: Colors.white),
    );
  }
}

class _SolutionConfigurationCard extends StatefulWidget {
  const _SolutionConfigurationCard();

  @override
  State<_SolutionConfigurationCard> createState() =>
      _SolutionConfigurationCardState();
}

class _SolutionConfigurationCardState
    extends State<_SolutionConfigurationCard> {
  String _strategy = 'Balanced (Quality + Cost)';
  String _review = 'Required for Payments';
  String _region = 'India / APAC';
  String _retry = 'Conservative (3 retries)';
  String _evidence = 'Strict';
  bool _openAi = true;
  bool _anthropic = true;
  bool _gemini = true;
  bool _local = false;
  bool _autoPay = false;
  bool _autoReport = true;

  @override
  Widget build(BuildContext context) {
    return _Panel(
      title: 'Accounts Payable Configuration',
      subtitle: 'Adjust controls for this solution.',
      trailing: TextButton.icon(
        onPressed: () {
          setState(() {
            _strategy = 'Balanced (Quality + Cost)';
            _review = 'Required for Payments';
            _region = 'India / APAC';
            _retry = 'Conservative (3 retries)';
            _evidence = 'Strict';
            _openAi = true;
            _anthropic = true;
            _gemini = true;
            _local = false;
            _autoPay = false;
            _autoReport = true;
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
                label: 'AI Strategy',
                value: _strategy,
                values: const <String>[
                  'Balanced (Quality + Cost)',
                  'Highest Quality',
                  'Lowest Cost',
                  'Lowest Latency',
                  'Private / Local First',
                ],
                onChanged: (value) => setState(() => _strategy = value!),
              ),
              const SizedBox(height: 12),
              const _ConfigLabel(label: 'Approved Providers'),
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
                    value: _local,
                    onChanged: (value) => setState(() => _local = value),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const _ConfigTextField(
                label: 'Maximum Cost per Workflow',
                prefix: '₹',
                value: '250.00',
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
                label: 'Human Review',
                value: _review,
                values: const <String>[
                  'Required for Payments',
                  'Required for Exceptions',
                  'Required for All Writes',
                  'Manual Only',
                ],
                onChanged: (value) => setState(() => _review = value!),
              ),
              const SizedBox(height: 12),
              const _ConfigLabel(label: 'Auto Actions'),
              const SizedBox(height: 7),
              _ToggleRow(
                label: 'Enable automatic payments',
                value: _autoPay,
                onChanged: (value) => setState(() => _autoPay = value),
              ),
              _ToggleRow(
                label: 'Enable report generation',
                value: _autoReport,
                onChanged: (value) => setState(() => _autoReport = value),
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
                values: const <String>[
                  'Strict',
                  'Standard',
                  'Compact',
                ],
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
          fontSize: 11,
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
            color: const Color(0xE6FFFFFF),
            borderRadius: BorderRadius.circular(11),
            border: Border.all(color: const Color(0xFFDFE7F0)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              style: const TextStyle(
                color: Color(0xFF1E3553),
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
              ),
              items: values
                  .map(
                    (item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
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
            color: const Color(0xE6FFFFFF),
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
                  fontSize: 10.5,
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
                fontSize: 10.5,
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
              fontSize: 11,
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

class _ConnectorSummaryCard extends StatelessWidget {
  const _ConnectorSummaryCard();

  @override
  Widget build(BuildContext context) {
    const connectors = <(String, IconData, String)>[
      ('SAP S/4HANA', Icons.account_balance_rounded, 'Connected'),
      ('Microsoft 365', Icons.mail_outline_rounded, 'Connected'),
      ('Salesforce', Icons.cloud_outlined, 'Connected'),
      ('SharePoint', Icons.folder_copy_outlined, 'Connected'),
      ('PostgreSQL', Icons.storage_rounded, 'Connected'),
      ('Document Storage', Icons.folder_outlined, 'Connected'),
    ];

    return _Panel(
      title: 'Connectors',
      subtitle: 'Common business systems and data sources.',
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: connectors
            .map(
              (item) => SizedBox(
                width: 180,
                child: _ConnectorMini(
                  title: item.$1,
                  icon: item.$2,
                  status: item.$3,
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
    required this.status,
  });

  final String title;
  final IconData icon;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xA8FFFFFF),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: const Color(0xDCE6EFF5)),
      ),
      child: Row(
        children: <Widget>[
          _GradientIcon(icon: icon),
          const SizedBox(width: 9),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF1E3553),
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.circle,
                      size: 7,
                      color: Color(0xFF19A86B),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      status,
                      style: const TextStyle(
                        color: Color(0xFF5D728B),
                        fontSize: 9.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GovernanceCard extends StatefulWidget {
  const _GovernanceCard();

  @override
  State<_GovernanceCard> createState() => _GovernanceCardState();
}

class _GovernanceCardState extends State<_GovernanceCard> {
  bool _erpWrite = true;
  bool _emailApproval = true;
  bool _readOnlyDocs = true;
  bool _retainEvidence = true;

  @override
  Widget build(BuildContext context) {
    return _Panel(
      title: 'Governance & Approvals',
      subtitle: 'Control high-impact actions and retention.',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth >= 500;
          final left = Column(
            children: <Widget>[
              _ToggleRow(
                label: 'Require approval for ERP writes',
                value: _erpWrite,
                onChanged: (value) => setState(() => _erpWrite = value),
              ),
              _ToggleRow(
                label: 'Require approval for outbound email',
                value: _emailApproval,
                onChanged: (value) => setState(() => _emailApproval = value),
              ),
            ],
          );
          final right = Column(
            children: <Widget>[
              _ToggleRow(
                label: 'Allow read-only document access',
                value: _readOnlyDocs,
                onChanged: (value) => setState(() => _readOnlyDocs = value),
              ),
              _ToggleRow(
                label: 'Retain evidence for 90 days',
                value: _retainEvidence,
                onChanged: (value) => setState(() => _retainEvidence = value),
              ),
            ],
          );

          return wide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(child: left),
                    const SizedBox(width: 12),
                    Expanded(child: right),
                  ],
                )
              : Column(
                  children: <Widget>[
                    left,
                    right,
                  ],
                );
        },
      ),
    );
  }
}

class _LiveFinanceOutcomes extends StatelessWidget {
  const _LiveFinanceOutcomes();

  @override
  Widget build(BuildContext context) {
    const rows = <List<String>>[
      ['AP-2026-001248', 'Accounts Payable', 'Completed', '₹112', 'John D.'],
      ['AP-2026-001247', 'Accounts Payable', 'Needs Review', '₹208', 'Priya R.'],
      ['RC-2026-000892', 'Reconciliation', 'Running', '₹74', 'Arjun K.'],
      ['AR-2026-000445', 'Collections', 'Completed', '₹96', 'Lisa T.'],
      ['CL-2026-000191', 'Month-End Close', 'Completed', '₹148', 'Mark G.'],
    ];

    return _Panel(
      title: 'Live Finance Outcomes',
      subtitle: 'Recent finance operations.',
      child: _SimpleTable(
        headers: const <String>[
          'Outcome',
          'Operation',
          'Status',
          'Cost',
          'Owner',
        ],
        rows: rows,
      ),
    );
  }
}

class _VerifiedFinanceOutcome extends StatelessWidget {
  const _VerifiedFinanceOutcome();

  @override
  Widget build(BuildContext context) {
    return _Panel(
      title: 'Selected Outcome',
      subtitle: 'AP-2026-001247 · Accounts Payable',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              const _StatusChip(
                label: 'Needs Review',
                tone: _Tone.warning,
              ),
              const Spacer(),
              const Text(
                'Total cost',
                style: TextStyle(
                  color: Color(0xFF7B899C),
                  fontSize: 10.5,
                ),
              ),
              const SizedBox(width: 6),
              const Text(
                '₹208',
                style: TextStyle(
                  color: Color(0xFF0A1733),
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          const _CheckLine(label: 'Source documents checked'),
          const _CheckLine(label: 'Amounts and totals validated'),
          const _CheckLine(label: 'Policy rules applied'),
          const _CheckLine(label: 'Summary available'),
          const _CheckLine(
            label: 'Finance manager approval required',
            pending: true,
          ),
          const SizedBox(height: 14),
          _PrimaryButton(
            label: 'Open Evidence',
            icon: Icons.open_in_new_rounded,
            onPressed: () => _toast(context, 'Opening sample evidence.'),
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
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FinanceOperationsMatrix extends StatelessWidget {
  const _FinanceOperationsMatrix();

  @override
  Widget build(BuildContext context) {
    const operations = <(String, IconData, String)>[
      ('Accounts Payable', Icons.receipt_long_outlined, 'Invoice intake, matching, exceptions, approvals'),
      ('Accounts Receivable', Icons.request_quote_outlined, 'Billing, collections, aging, cash application'),
      ('Cash & Treasury', Icons.account_balance_wallet_outlined, 'Cash position, liquidity, transfers, forecasting'),
      ('Bank Reconciliation', Icons.account_balance_outlined, 'Statement matching, breaks, daily reconciliation'),
      ('Expense Management', Icons.wallet_outlined, 'Employee spend, policy checks, reimbursement review'),
      ('Financial Close', Icons.task_alt_rounded, 'Close checklist, journals, reconciliations, review'),
      ('Budgeting & Forecasting', Icons.insights_outlined, 'Budget variance, scenario planning, forecast updates'),
      ('Tax Operations', Icons.percent_rounded, 'Indirect tax checks, filing support, variance review'),
      ('Payroll Review', Icons.badge_outlined, 'Payroll checks, variance detection, approval routing'),
      ('Revenue Assurance', Icons.trending_up_rounded, 'Revenue checks, leakage detection, contract variance'),
      ('Audit & Controls', Icons.policy_outlined, 'Control tests, evidence, exception follow-up'),
      ('Vendor Management', Icons.storefront_outlined, 'Vendor master review, duplicates, payment risk'),
    ];

    return _Panel(
      title: 'Finance Operations',
      subtitle: 'Coverage across core finance and accounting activities.',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final columns = constraints.maxWidth >= 1100
              ? 4
              : constraints.maxWidth >= 700
              ? 3
              : 1;
          const spacing = 12.0;
          final width =
              (constraints.maxWidth - spacing * (columns - 1)) / columns;

          return Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: operations
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
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xA6FFFFFF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xDCE6EFF5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _GradientIcon(icon: icon),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF1E3553),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF748398),
                    fontSize: 10.5,
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

class _SolutionsPage extends StatelessWidget {
  const _SolutionsPage();

  @override
  Widget build(BuildContext context) {
    const solutions = <(String, IconData, String, String)>[
      ('Accounts Payable', Icons.receipt_long_outlined, 'Active', '342 outcomes today'),
      ('Accounts Receivable', Icons.request_quote_outlined, 'Active', '184 open items'),
      ('Cash & Treasury', Icons.account_balance_wallet_outlined, 'Active', '₹12.84 Cr cash position'),
      ('Bank Reconciliation', Icons.account_balance_outlined, 'Active', '96.2% matched'),
      ('Expense Management', Icons.wallet_outlined, 'Active', '48 items pending'),
      ('Month-End Close', Icons.task_alt_rounded, 'Active', '86% complete'),
      ('Budget & Forecasting', Icons.insights_outlined, 'Configured', 'Q4 forecast'),
      ('Tax Operations', Icons.percent_rounded, 'Configured', '7 reviews due'),
      ('Payroll Review', Icons.badge_outlined, 'Configured', 'Next run Friday'),
      ('Revenue Assurance', Icons.trending_up_rounded, 'Configured', '3 leakage alerts'),
      ('Audit & Controls', Icons.policy_outlined, 'Active', '12 controls tested'),
      ('Vendor Management', Icons.storefront_outlined, 'Active', '1,284 vendors'),
    ];

    return _ScrollablePage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _PageTitle(
            title: 'Finance Solutions',
            subtitle:
                'Configure finance operations independently while keeping a consistent workspace.',
          ),
          const SizedBox(height: 18),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth >= 1150
                  ? 4
                  : constraints.maxWidth >= 720
                  ? 3
                  : 1;
              const spacing = 14.0;
              final width =
                  (constraints.maxWidth - spacing * (columns - 1)) / columns;

              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: solutions
                    .map(
                      (item) => SizedBox(
                        width: width,
                        child: _SolutionCard(
                          title: item.$1,
                          icon: item.$2,
                          status: item.$3,
                          metric: item.$4,
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SolutionCard extends StatelessWidget {
  const _SolutionCard({
    required this.title,
    required this.icon,
    required this.status,
    required this.metric,
  });

  final String title;
  final IconData icon;
  final String status;
  final String metric;

  @override
  Widget build(BuildContext context) {
    return _GlassSurface(
      radius: 20,
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              _GradientIcon(icon: icon),
              const Spacer(),
              _StatusChip(label: status, tone: _Tone.success),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF172A46),
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            metric,
            style: const TextStyle(
              color: Color(0xFF718096),
              fontSize: 11.5,
            ),
          ),
          const SizedBox(height: 16),
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
      ['Invoice Review', 'Accounts Payable', 'Every 15 min', 'Active', '128'],
      ['Collections Prioritization', 'Accounts Receivable', 'Daily 08:00', 'Active', '42'],
      ['Bank Reconciliation', 'Reconciliation', 'Daily 06:00', 'Active', '18'],
      ['Cash Position Update', 'Treasury', 'Hourly', 'Active', '24'],
      ['Expense Policy Review', 'Expenses', 'On submission', 'Active', '67'],
      ['Month-End Close Checklist', 'Close', 'Monthly', 'Scheduled', '12'],
      ['Tax Variance Review', 'Tax', 'Weekly', 'Scheduled', '7'],
      ['Vendor Duplicate Scan', 'Vendor Management', 'Daily 02:00', 'Active', '5'],
    ];

    return _StandardTablePage(
      title: 'Finance Workflows',
      subtitle: 'Schedules, triggers, and operational runs.',
      headers: const <String>[
        'Workflow',
        'Solution',
        'Schedule',
        'Status',
        'Runs',
      ],
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
                'Manage solution-level policies, cost limits, providers, review thresholds, and evidence settings.',
          ),
          const SizedBox(height: 18),
          const _SolutionConfigurationCard(),
          const SizedBox(height: 18),
          const _GovernanceCard(),
        ],
      ),
    );
  }
}

class _ConnectorsPage extends StatelessWidget {
  const _ConnectorsPage();

  @override
  Widget build(BuildContext context) {
    const connectors = <(String, IconData, String, String)>[
      ('SAP S/4HANA', Icons.account_balance_rounded, 'ERP', 'Connected'),
      ('Oracle Fusion', Icons.business_center_outlined, 'ERP', 'Available'),
      ('NetSuite', Icons.apps_outlined, 'ERP', 'Connected'),
      ('Microsoft Dynamics 365', Icons.window_rounded, 'ERP / CRM', 'Available'),
      ('Salesforce', Icons.cloud_outlined, 'CRM', 'Connected'),
      ('Workday', Icons.badge_outlined, 'HR / Finance', 'Available'),
      ('QuickBooks', Icons.calculate_outlined, 'Accounting', 'Available'),
      ('Xero', Icons.currency_exchange_rounded, 'Accounting', 'Available'),
      ('Microsoft 365', Icons.mail_outline_rounded, 'Email / Files', 'Connected'),
      ('Google Workspace', Icons.alternate_email_rounded, 'Email / Files', 'Connected'),
      ('SharePoint', Icons.folder_copy_outlined, 'Documents', 'Connected'),
      ('OneDrive', Icons.cloud_queue_rounded, 'Files', 'Available'),
      ('Google Drive', Icons.add_to_drive_outlined, 'Files', 'Available'),
      ('Slack', Icons.chat_bubble_outline_rounded, 'Collaboration', 'Available'),
      ('Microsoft Teams', Icons.groups_outlined, 'Collaboration', 'Available'),
      ('PostgreSQL', Icons.storage_rounded, 'Database', 'Connected'),
      ('MySQL', Icons.dns_outlined, 'Database', 'Available'),
      ('Snowflake', Icons.ac_unit_rounded, 'Data Warehouse', 'Available'),
      ('Amazon S3', Icons.inventory_2_outlined, 'Object Storage', 'Available'),
      ('Stripe', Icons.credit_card_outlined, 'Payments', 'Connected'),
      ('Razorpay', Icons.currency_rupee_rounded, 'Payments', 'Available'),
      ('Plaid', Icons.account_balance_outlined, 'Banking Data', 'Available'),
    ];

    return _ScrollablePage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _PageTitle(
            title: 'Connectors',
            subtitle:
                'Connect business systems, databases, documents, collaboration tools, and payment services.',
          ),
          const SizedBox(height: 18),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth >= 1150
                  ? 4
                  : constraints.maxWidth >= 720
                  ? 3
                  : 1;
              const spacing = 12.0;
              final width =
                  (constraints.maxWidth - spacing * (columns - 1)) / columns;

              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: connectors
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
          ),
        ],
      ),
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
                tone: connected ? _Tone.success : _Tone.neutral,
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF1E3553),
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            category,
            style: const TextStyle(
              color: Color(0xFF76869A),
              fontSize: 10.5,
            ),
          ),
          const SizedBox(height: 14),
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
      ['APR-1042', 'Vendor Payment', '₹18,42,000', 'Priya R.', 'High', 'Pending'],
      ['APR-1041', 'Journal Entry', '₹6,75,000', 'Arjun K.', 'Medium', 'Pending'],
      ['APR-1039', 'Supplier Credit', '₹2,18,000', 'Lisa T.', 'Medium', 'Pending'],
      ['APR-1034', 'Tax Adjustment', '₹84,000', 'Mark G.', 'Low', 'Approved'],
      ['APR-1028', 'Expense Reimbursement', '₹42,600', 'John D.', 'Low', 'Approved'],
    ];

    return _StandardTablePage(
      title: 'Approvals',
      subtitle: 'Finance actions waiting for human review.',
      headers: const <String>[
        'Approval',
        'Type',
        'Amount',
        'Owner',
        'Risk',
        'Status',
      ],
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
      ['EV-9021', 'AP-2026-001247', 'Invoice + PO + Receipt', 'Complete', 'Apr 22, 09:19'],
      ['EV-9020', 'RC-2026-000892', 'Bank statement + Ledger', 'Complete', 'Apr 22, 08:56'],
      ['EV-9018', 'AR-2026-000445', 'Invoice + Email + Aging', 'Complete', 'Apr 22, 08:31'],
      ['EV-9015', 'CL-2026-000191', 'Journal + Reconciliation', 'Complete', 'Apr 21, 18:04'],
      ['EV-9011', 'TX-2026-000072', 'Tax workbook + Ledger', 'Review', 'Apr 21, 16:20'],
    ];

    return _StandardTablePage(
      title: 'Evidence',
      subtitle: 'Documents, checks, summaries, and review records.',
      headers: const <String>[
        'Evidence',
        'Outcome',
        'Contents',
        'Status',
        'Created',
      ],
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
            title: 'Finance Analytics',
            subtitle:
                'Operational performance, exception trends, cycle times, spend, and control coverage.',
          ),
          const SizedBox(height: 18),
          const _FinanceMetricGrid(),
          const SizedBox(height: 18),
          LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth >= 900;
              const left = _BarAnalyticsCard(
                title: 'Volume by operation',
                items: <(String, double, String)>[
                  ('Accounts Payable', 0.92, '1,284'),
                  ('Accounts Receivable', 0.76, '1,056'),
                  ('Reconciliation', 0.58, '802'),
                  ('Expenses', 0.43, '594'),
                  ('Close', 0.24, '326'),
                ],
              );
              const right = _BarAnalyticsCard(
                title: 'Exception rate',
                items: <(String, double, String)>[
                  ('AP exceptions', 0.34, '3.4%'),
                  ('AR exceptions', 0.22, '2.2%'),
                  ('Reconciliation breaks', 0.18, '1.8%'),
                  ('Expense policy', 0.27, '2.7%'),
                  ('Close blockers', 0.12, '1.2%'),
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
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          item.$3,
                          style: const TextStyle(
                            color: Color(0xFF0A1733),
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        value: item.$2,
                        minHeight: 8,
                        backgroundColor: const Color(0xFFE6EEF6),
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
      ['Sarah Roy', 'Finance Admin', 'Finance & Accounting', 'Active', 'Today'],
      ['Priya Raman', 'AP Manager', 'Accounts Payable', 'Active', 'Today'],
      ['Arjun Kumar', 'Controller', 'Close & Reconciliation', 'Active', 'Yesterday'],
      ['Lisa Thomas', 'Analyst', 'Accounts Receivable', 'Active', '2 days ago'],
      ['Mark Gupta', 'Auditor', 'Read Only', 'Active', '4 days ago'],
    ];

    return _StandardTablePage(
      title: 'Users & Roles',
      subtitle: 'Manage workspace access and finance responsibilities.',
      headers: const <String>[
        'User',
        'Role',
        'Scope',
        'Status',
        'Last active',
      ],
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
                'Review workspace usage, solution spend, budgets, and plan information.',
          ),
          const SizedBox(height: 18),
          const _FinanceMetricGrid(),
          const SizedBox(height: 18),
          const _Panel(
            title: 'Solution Spend',
            subtitle: 'Sample monthly allocation',
            child: _SimpleTable(
              headers: <String>['Solution', 'Runs', 'Spend', 'Budget', 'Status'],
              rows: <List<String>>[
                ['Accounts Payable', '1,284', '₹82,400', '₹1,20,000', 'Within budget'],
                ['Accounts Receivable', '1,056', '₹61,700', '₹95,000', 'Within budget'],
                ['Reconciliation', '802', '₹48,900', '₹75,000', 'Within budget'],
                ['Month-End Close', '326', '₹31,400', '₹40,000', 'Watch'],
                ['Audit & Controls', '214', '₹22,100', '₹35,000', 'Within budget'],
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
              onPressed: () => _toast(context, '$actionLabel opened in demo mode.'),
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
        headingRowHeight: 40,
        dataRowMinHeight: 44,
        dataRowMaxHeight: 48,
        columnSpacing: 26,
        dividerThickness: 0.7,
        headingTextStyle: const TextStyle(
          color: Color(0xFF65758A),
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
        ),
        dataTextStyle: const TextStyle(
          color: Color(0xFF30445F),
          fontSize: 10.8,
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
                        fontSize: 15.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xFF7B899D),
                        fontSize: 10.8,
                      ),
                    ),
                  ],
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
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
          fontSize: 9.5,
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
            blurRadius: 30,
            offset: Offset(0, 14),
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

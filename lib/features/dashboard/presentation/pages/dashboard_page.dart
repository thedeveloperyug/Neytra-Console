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

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= 1024;
    final isTablet = width >= 700 && width < 1024;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          const _DashboardBackground(),
          SafeArea(
            child: isDesktop
                ? Row(
                    children: <Widget>[
                      const _DesktopSidebar(),
                      Expanded(
                        child: _DashboardContent(
                          columns: 4,
                          horizontalPadding: 30,
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: <Widget>[
                      const _MobileTopBar(),
                      Expanded(
                        child: _DashboardContent(
                          columns: isTablet ? 2 : 1,
                          horizontalPadding: isTablet ? 24 : 16,
                        ),
                      ),
                      if (!isTablet) const _MobileBottomNav(),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class _DashboardBackground extends StatelessWidget {
  const _DashboardBackground();

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
            Color(0xFFF8FAFC),
          ],
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned(
            left: -180,
            top: -160,
            child: _AmbientOrb(
              size: 520,
              colors: <Color>[
                Color(0x2F56F7F4),
                Color(0x0D0878FF),
                Color(0x00FFFFFF),
              ],
            ),
          ),
          Positioned(
            right: -160,
            bottom: -200,
            child: _AmbientOrb(
              size: 620,
              colors: <Color>[
                Color(0x260878FF),
                Color(0x081826E8),
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
  const _DesktopSidebar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 0, 18),
      child: SizedBox(
        width: 248,
        child: _GlassSurface(
          radius: 28,
          padding: const EdgeInsets.fromLTRB(18, 20, 18, 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const _BrandLockup(),
              const SizedBox(height: 32),
              const _NavItem(
                icon: Icons.grid_view_rounded,
                label: 'Overview',
                selected: true,
              ),
              const _NavItem(
                icon: Icons.auto_awesome_mosaic_outlined,
                label: 'Solutions',
              ),
              const _NavItem(
                icon: Icons.route_outlined,
                label: 'Outcomes',
              ),
              const _NavItem(
                icon: Icons.approval_outlined,
                label: 'Approvals',
              ),
              const _NavItem(
                icon: Icons.fact_check_outlined,
                label: 'Evidence',
              ),
              const _NavItem(
                icon: Icons.query_stats_outlined,
                label: 'Analytics',
              ),
              const Spacer(),
              const _NavItem(
                icon: Icons.settings_outlined,
                label: 'Settings',
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () => context.go('/login'),
                icon: const Icon(Icons.logout_rounded, size: 18),
                label: const Text('Sign out'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF52627A),
                  backgroundColor: const Color(0x86FFFFFF),
                  side: const BorderSide(color: Color(0xE6FFFFFF)),
                  minimumSize: const Size.fromHeight(46),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BrandLockup extends StatelessWidget {
  const _BrandLockup();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Image.asset(
          'assets/branding/logo/neytra_n.png',
          height: 34,
          filterQuality: FilterQuality.high,
        ),
        const SizedBox(width: 10),
        const Text(
          'NEYTRA',
          style: TextStyle(
            color: Color(0xFF0A1733),
            fontSize: 15,
            fontWeight: FontWeight.w800,
            letterSpacing: 3.2,
          ),
        ),
      ],
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    this.selected = false,
  });

  final IconData icon;
  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: selected
              ? const LinearGradient(
                  colors: <Color>[
                    Color(0x1F56F7F4),
                    Color(0x200878FF),
                  ],
                )
              : null,
          border: selected
              ? Border.all(color: const Color(0x74FFFFFF))
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                size: 20,
                color: selected
                    ? const Color(0xFF0878FF)
                    : const Color(0xFF6F7E92),
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  color: selected
                      ? const Color(0xFF0A1733)
                      : const Color(0xFF58687E),
                  fontSize: 14,
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

class _MobileTopBar extends StatelessWidget {
  const _MobileTopBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
      child: Row(
        children: <Widget>[
          const Expanded(child: _BrandLockup()),
          _RoundIconButton(
            icon: Icons.notifications_none_rounded,
            onTap: () {},
          ),
          const SizedBox(width: 8),
          _RoundIconButton(
            icon: Icons.logout_rounded,
            onTap: () => context.go('/login'),
          ),
        ],
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xA8FFFFFF),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(
            icon,
            size: 20,
            color: const Color(0xFF52627A),
          ),
        ),
      ),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  const _DashboardContent({
    required this.columns,
    required this.horizontalPadding,
  });

  final int columns;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        24,
        horizontalPadding,
        36,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1320),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const _PageHeader(),
              const SizedBox(height: 24),
              _MetricGrid(columns: columns),
              const SizedBox(height: 24),
              LayoutBuilder(
                builder: (context, constraints) {
                  final sideBySide = constraints.maxWidth >= 880;
                  if (sideBySide) {
                    return const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(flex: 6, child: _AttentionPanel()),
                        SizedBox(width: 20),
                        Expanded(flex: 5, child: _LiveActivityPanel()),
                      ],
                    );
                  }
                  return const Column(
                    children: <Widget>[
                      _AttentionPanel(),
                      SizedBox(height: 20),
                      _LiveActivityPanel(),
                    ],
                  );
                },
              ),
              const SizedBox(height: 24),
              const _SolutionsPanel(),
              const SizedBox(height: 24),
              const _PreviewBanner(),
            ],
          ),
        ),
      ),
    );
  }
}

class _PageHeader extends StatelessWidget {
  const _PageHeader();

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 700;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          compact ? 'Welcome to Neytra' : 'Good morning, Demo Organization',
          style: TextStyle(
            color: const Color(0xFF0A1733),
            fontSize: compact ? 27 : 34,
            height: 1.12,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.8,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Here is a temporary preview of your business operations workspace.',
          style: TextStyle(
            color: Color(0xFF65758B),
            fontSize: 14.5,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 18),
        const _AskNeytraBar(),
      ],
    );
  }
}

class _AskNeytraBar extends StatelessWidget {
  const _AskNeytraBar();

  @override
  Widget build(BuildContext context) {
    return _GlassSurface(
      radius: 18,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: TextField(
        readOnly: true,
        onTap: () => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ask Neytra is a placeholder in this demo homepage.'),
            behavior: SnackBarBehavior.floating,
          ),
        ),
        decoration: const InputDecoration(
          filled: false,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          prefixIcon: Icon(
            Icons.auto_awesome_rounded,
            color: Color(0xFF0878FF),
          ),
          hintText: 'Ask Neytra about your operations...',
          hintStyle: TextStyle(
            color: Color(0xFF8190A3),
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class _MetricGrid extends StatelessWidget {
  const _MetricGrid({required this.columns});

  final int columns;

  @override
  Widget build(BuildContext context) {
    const items = <_MetricData>[
      _MetricData(
        label: 'Outcomes today',
        value: '128',
        change: '+12%',
        icon: Icons.check_circle_outline_rounded,
      ),
      _MetricData(
        label: 'Verified',
        value: '97.8%',
        change: '+1.4%',
        icon: Icons.verified_outlined,
      ),
      _MetricData(
        label: 'Need attention',
        value: '7',
        change: '3 urgent',
        icon: Icons.notification_important_outlined,
      ),
      _MetricData(
        label: 'Demo spend',
        value: '₹4,280',
        change: 'This month',
        icon: Icons.payments_outlined,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final actualColumns = constraints.maxWidth < 600 ? 2 : columns;
        final spacing = 16.0;
        final width =
            (constraints.maxWidth - spacing * (actualColumns - 1)) /
            actualColumns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: items
              .map(
                (item) => SizedBox(
                  width: width,
                  child: _MetricCard(data: item),
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
    required this.change,
    required this.icon,
  });

  final String label;
  final String value;
  final String change;
  final IconData icon;
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.data});

  final _MetricData data;

  @override
  Widget build(BuildContext context) {
    return _GlassSurface(
      radius: 22,
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              _GradientIcon(icon: data.icon),
              const Spacer(),
              Text(
                data.change,
                style: const TextStyle(
                  color: Color(0xFF6C7A8E),
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            data.value,
            style: const TextStyle(
              color: Color(0xFF0A1733),
              fontSize: 27,
              fontWeight: FontWeight.w750,
              letterSpacing: -0.6,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            data.label,
            style: const TextStyle(
              color: Color(0xFF65758B),
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
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
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
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
            color: Color(0x260878FF),
            blurRadius: 16,
            offset: Offset(0, 7),
          ),
        ],
      ),
      child: Icon(icon, size: 20, color: Colors.white),
    );
  }
}

class _AttentionPanel extends StatelessWidget {
  const _AttentionPanel();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Attention required',
      subtitle: 'Items that may need a human decision',
      child: Column(
        children: const <Widget>[
          _AttentionRow(
            icon: Icons.receipt_long_outlined,
            title: '3 invoices need review',
            subtitle: 'Quantity or price mismatch detected',
            badge: 'Review',
          ),
          _PanelDivider(),
          _AttentionRow(
            icon: Icons.approval_outlined,
            title: '2 approvals are waiting',
            subtitle: 'Finance manager approval required',
            badge: 'Approve',
          ),
          _PanelDivider(),
          _AttentionRow(
            icon: Icons.link_off_rounded,
            title: '1 connector needs attention',
            subtitle: 'Demo ERP connector authorization expires soon',
            badge: 'Fix',
          ),
        ],
      ),
    );
  }
}

class _AttentionRow extends StatelessWidget {
  const _AttentionRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.badge,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String badge;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 21, color: const Color(0xFF287DDF)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF172A46),
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF718096),
                    fontSize: 11.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            badge,
            style: const TextStyle(
              color: Color(0xFF0878FF),
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _LiveActivityPanel extends StatelessWidget {
  const _LiveActivityPanel();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Live outcomes',
      subtitle: 'Dummy activity for layout preview',
      child: Column(
        children: const <Widget>[
          _OutcomeRow(
            id: 'AP-1048',
            title: 'Invoice review',
            status: 'Verifying',
            progress: 0.78,
          ),
          SizedBox(height: 15),
          _OutcomeRow(
            id: 'AP-1047',
            title: 'Invoice review',
            status: 'Completed',
            progress: 1,
          ),
          SizedBox(height: 15),
          _OutcomeRow(
            id: 'PR-0282',
            title: 'Supplier comparison',
            status: 'Approval',
            progress: 0.63,
          ),
        ],
      ),
    );
  }
}

class _OutcomeRow extends StatelessWidget {
  const _OutcomeRow({
    required this.id,
    required this.title,
    required this.status,
    required this.progress,
  });

  final String id;
  final String title;
  final String status;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              id,
              style: const TextStyle(
                color: Color(0xFF0A1733),
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF66758B),
                  fontSize: 12.5,
                ),
              ),
            ),
            Text(
              status,
              style: const TextStyle(
                color: Color(0xFF0878FF),
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 7,
            backgroundColor: const Color(0xFFE7EEF6),
            valueColor: const AlwaysStoppedAnimation<Color>(
              Color(0xFF0878FF),
            ),
          ),
        ),
      ],
    );
  }
}

class _SolutionsPanel extends StatelessWidget {
  const _SolutionsPanel();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Active solutions',
      subtitle: 'Temporary sample content',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final stack = constraints.maxWidth < 700;
          const cards = <Widget>[
            _SolutionTile(
              title: 'Accounts Payable',
              status: 'Healthy',
              metric: '342',
              metricLabel: 'items processed today',
            ),
            _SolutionTile(
              title: 'Procurement',
              status: 'Preview',
              metric: '87',
              metricLabel: 'sample outcomes',
            ),
          ];

          if (stack) {
            return const Column(
              children: <Widget>[
                cards[0],
                SizedBox(height: 14),
                cards[1],
              ],
            );
          }

          return const Row(
            children: <Widget>[
              Expanded(child: cards[0]),
              SizedBox(width: 14),
              Expanded(child: cards[1]),
            ],
          );
        },
      ),
    );
  }
}

class _SolutionTile extends StatelessWidget {
  const _SolutionTile({
    required this.title,
    required this.status,
    required this.metric,
    required this.metricLabel,
  });

  final String title;
  final String status;
  final String metric;
  final String metricLabel;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0x8FFFFFFF),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xDFFFFFFF)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF172A46),
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                _StatusChip(label: status),
              ],
            ),
            const SizedBox(height: 22),
            Text(
              metric,
              style: const TextStyle(
                color: Color(0xFF0A1733),
                fontSize: 30,
                fontWeight: FontWeight.w750,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              metricLabel,
              style: const TextStyle(
                color: Color(0xFF718096),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0x1856F7F4),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0x4A56F7F4)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(
          label,
          style: const TextStyle(
            color: Color(0xFF0878FF),
            fontSize: 10.5,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _PreviewBanner extends StatelessWidget {
  const _PreviewBanner();

  @override
  Widget build(BuildContext context) {
    return _GlassSurface(
      radius: 18,
      padding: const EdgeInsets.all(16),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.science_outlined,
            color: Color(0xFF0878FF),
            size: 20,
          ),
          SizedBox(width: 11),
          Expanded(
            child: Text(
              'This is a temporary dummy homepage. The figures, solutions, '
              'activity, and business metrics are sample data and will be '
              'replaced when the final homepage requirements are defined.',
              style: TextStyle(
                color: Color(0xFF65758B),
                fontSize: 12.5,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _GlassSurface(
      radius: 24,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF0A1733),
              fontSize: 17,
              fontWeight: FontWeight.w750,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              color: Color(0xFF7B899B),
              fontSize: 11.5,
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
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
            color: Color(0x12173A66),
            blurRadius: 30,
            offset: Offset(0, 14),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Color(0xD9FFFFFF),
                  Color(0xB8F8FBFE),
                  Color(0xA8F0F7FD),
                ],
              ),
              border: Border.all(
                color: const Color(0xE6FFFFFF),
                width: 1.2,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class _MobileBottomNav extends StatelessWidget {
  const _MobileBottomNav();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 10, 18, 14),
      decoration: const BoxDecoration(
        color: Color(0xECFFFFFF),
        border: Border(
          top: BorderSide(color: Color(0x99FFFFFF)),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _BottomNavItem(
            icon: Icons.grid_view_rounded,
            label: 'Overview',
            selected: true,
          ),
          _BottomNavItem(
            icon: Icons.route_outlined,
            label: 'Outcomes',
          ),
          _BottomNavItem(
            icon: Icons.approval_outlined,
            label: 'Approvals',
          ),
          _BottomNavItem(
            icon: Icons.more_horiz_rounded,
            label: 'More',
          ),
        ],
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    required this.icon,
    required this.label,
    this.selected = false,
  });

  final IconData icon;
  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final color = selected
        ? const Color(0xFF0878FF)
        : const Color(0xFF7B899B);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, size: 20, color: color),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 10.5,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

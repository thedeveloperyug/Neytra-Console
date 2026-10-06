/*
Copyright (c) 2026 Neytra Intelligence Platform. All rights reserved.

This software and its source code are proprietary and confidential.

No permission is granted to copy, modify, distribute, sublicense, sell, or otherwise use this software without prior written permission from the copyright holder.

Unauthorized use, reproduction, or distribution is prohibited.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.
*/

import 'package:flutter/material.dart';

import 'widgets/ai_strategy_selector.dart';
import 'widgets/approval_editor.dart';
import 'widgets/budget_editor.dart';
import 'widgets/evidence_level_selector.dart';
import 'widgets/provider_selector.dart';
import 'widgets/publish_configuration_button.dart';

class ConfigurationPage extends StatelessWidget {
  const ConfigurationPage({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: ListView(
          padding: EdgeInsets.all(24),
          children: <Widget>[
            AiStrategySelector(),
            ProviderSelector(),
            BudgetEditor(),
            ApprovalEditor(),
            EvidenceLevelSelector(),
            PublishConfigurationButton(),
          ],
        ),
      );
}

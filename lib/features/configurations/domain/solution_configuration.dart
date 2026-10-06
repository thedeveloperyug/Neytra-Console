/*
Copyright (c) 2026 Neytra Intelligence Platform. All rights reserved.

This software and its source code are proprietary and confidential.

No permission is granted to copy, modify, distribute, sublicense, sell, or otherwise use this software without prior written permission from the copyright holder.

Unauthorized use, reproduction, or distribution is prohibited.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.
*/

import 'approval_policy.dart';
import 'budget_policy.dart';
import 'evidence_policy.dart';
import 'model_policy.dart';

class SolutionConfiguration {
  const SolutionConfiguration({
    required this.solutionId,
    required this.modelPolicy,
    required this.approvalPolicy,
    required this.budgetPolicy,
    required this.evidencePolicy,
  });

  final String solutionId;
  final ModelPolicy modelPolicy;
  final ApprovalPolicy approvalPolicy;
  final BudgetPolicy budgetPolicy;
  final EvidencePolicy evidencePolicy;
}

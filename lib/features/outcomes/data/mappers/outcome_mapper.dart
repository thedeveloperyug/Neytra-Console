/*
Copyright (c) 2026 Neytra Intelligence Platform. All rights reserved.

This software and its source code are proprietary and confidential.

No permission is granted to copy, modify, distribute, sublicense, sell, or otherwise use this software without prior written permission from the copyright holder.

Unauthorized use, reproduction, or distribution is prohibited.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.
*/

import '../../domain/entities/outcome.dart';
import '../../domain/entities/outcome_status.dart';
import '../dto/outcome_dto.dart';

Outcome mapOutcome(OutcomeDto dto) => Outcome(
      id: dto.id,
      solutionId: dto.solutionId,
      status: OutcomeStatus.values.firstWhere(
        (value) => value.name == dto.status,
        orElse: () => OutcomeStatus.failed,
      ),
    );

/*
Copyright (c) 2026 Neytra Intelligence Platform. All rights reserved.

This software and its source code are proprietary and confidential.

No permission is granted to copy, modify, distribute, sublicense, sell, or otherwise use this software without prior written permission from the copyright holder.

Unauthorized use, reproduction, or distribution is prohibited.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.
*/

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repositories/outcome_repository.dart';

final outcomeRepositoryProvider = Provider<OutcomeRepository>(
  (ref) => throw UnimplementedError('Provide OutcomeRepository at bootstrap.'),
);

/*
Copyright (c) 2026 Neytra Intelligence Platform. All rights reserved.

This software and its source code are proprietary and confidential.

No permission is granted to copy, modify, distribute, sublicense, sell, or otherwise use this software without prior written permission from the copyright holder.

Unauthorized use, reproduction, or distribution is prohibited.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.
*/

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/outcome.dart';
import 'outcome_provider.dart';

final outcomeStreamProvider = StreamProvider.family<Outcome, String>(
  (ref, id) => ref.watch(outcomeRepositoryProvider).watch(id),
);

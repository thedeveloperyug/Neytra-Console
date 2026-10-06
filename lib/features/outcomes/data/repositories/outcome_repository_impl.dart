/*
Copyright (c) 2026 Neytra Intelligence Platform. All rights reserved.

This software and its source code are proprietary and confidential.

No permission is granted to copy, modify, distribute, sublicense, sell, or otherwise use this software without prior written permission from the copyright holder.

Unauthorized use, reproduction, or distribution is prohibited.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.
*/

import '../../domain/entities/outcome.dart';
import '../../domain/repositories/outcome_repository.dart';
import '../datasources/outcome_remote_datasource.dart';
import '../mappers/outcome_mapper.dart';

class OutcomeRepositoryImpl implements OutcomeRepository {
  const OutcomeRepositoryImpl(this.remote);
  final OutcomeRemoteDataSource remote;

  @override
  Future<Outcome> get(String id) async => mapOutcome(await remote.get(id));

  @override
  Future<Outcome> create(String solutionId) =>
      throw UnimplementedError('Create endpoint binding is added with the Control Plane contract.');

  @override
  Future<void> cancel(String id) =>
      throw UnimplementedError('Cancel endpoint binding is added with the Control Plane contract.');

  @override
  Stream<Outcome> watch(String id) =>
      throw UnimplementedError('Realtime binding is added with the event contract.');
}

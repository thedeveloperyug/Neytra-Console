/*
Copyright (c) 2026 Neytra Intelligence Platform. All rights reserved.

This software and its source code are proprietary and confidential.

No permission is granted to copy, modify, distribute, sublicense, sell, or otherwise use this software without prior written permission from the copyright holder.

Unauthorized use, reproduction, or distribution is prohibited.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.
*/

import '../../../../core/networking/api_client.dart';
import '../dto/outcome_dto.dart';

class OutcomeRemoteDataSource {
  const OutcomeRemoteDataSource(this.client);
  final ApiClient client;

  Future<OutcomeDto> get(String id) async {
    final json = await client.getJson('/v1/outcomes/$id');
    return OutcomeDto.fromJson(json);
  }
}

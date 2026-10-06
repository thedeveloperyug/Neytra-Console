/*
Copyright (c) 2026 Neytra Intelligence Platform. All rights reserved.

This software and its source code are proprietary and confidential.

No permission is granted to copy, modify, distribute, sublicense, sell, or otherwise use this software without prior written permission from the copyright holder.

Unauthorized use, reproduction, or distribution is prohibited.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.
*/

import 'package:dio/dio.dart';

import 'api_client.dart';

class DioApiClient implements ApiClient {
  DioApiClient(this._dio);
  final Dio _dio;

  @override
  Future<Map<String, Object?>> getJson(String path) async {
    final response = await _dio.get<Map<String, Object?>>(path);
    return response.data ?? <String, Object?>{};
  }

  @override
  Future<Map<String, Object?>> postJson(String path, Map<String, Object?> body) async {
    final response = await _dio.post<Map<String, Object?>>(path, data: body);
    return response.data ?? <String, Object?>{};
  }
}

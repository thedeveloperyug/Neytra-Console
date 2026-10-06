/*
Copyright (c) 2026 Neytra Intelligence Platform. All rights reserved.

This software and its source code are proprietary and confidential.

No permission is granted to copy, modify, distribute, sublicense, sell, or otherwise use this software without prior written permission from the copyright holder.

Unauthorized use, reproduction, or distribution is prohibited.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.
*/

import 'secure_storage.dart';

class WebSecureStorage implements SecureStorage {
  @override
  Future<void> write(String key, String value) async =>
      throw UnsupportedError('Web authentication uses server-managed secure sessions.');

  @override
  Future<String?> read(String key) async => null;

  @override
  Future<void> delete(String key) async {}
}

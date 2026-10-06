/*
Copyright (c) 2026 Neytra Intelligence Platform. All rights reserved.

This software and its source code are proprietary and confidential.

No permission is granted to copy, modify, distribute, sublicense, sell, or otherwise use this software without prior written permission from the copyright holder.

Unauthorized use, reproduction, or distribution is prohibited.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.
*/

import 'secure_storage.dart';

class NativeSecureStorage implements SecureStorage {
  @override
  Future<void> write(String key, String value) async =>
      throw UnimplementedError('Bind to an approved OS-backed secure store.');

  @override
  Future<String?> read(String key) async =>
      throw UnimplementedError('Bind to an approved OS-backed secure store.');

  @override
  Future<void> delete(String key) async =>
      throw UnimplementedError('Bind to an approved OS-backed secure store.');
}

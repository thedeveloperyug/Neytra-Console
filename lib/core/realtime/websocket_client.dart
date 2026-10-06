/*
Copyright (c) 2026 Neytra Intelligence Platform. All rights reserved.

This software and its source code are proprietary and confidential.

No permission is granted to copy, modify, distribute, sublicense, sell, or otherwise use this software without prior written permission from the copyright holder.

Unauthorized use, reproduction, or distribution is prohibited.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.
*/

import 'package:web_socket_channel/web_socket_channel.dart';

import 'realtime_client.dart';

class NeytraWebSocketClient implements RealtimeClient {
  NeytraWebSocketClient(this.uri);
  final Uri uri;
  WebSocketChannel? _channel;

  @override
  Future<void> connect() async {
    _channel = WebSocketChannel.connect(uri);
    await _channel!.ready;
  }

  @override
  Stream<String> events() => _channel?.stream.cast<String>() ?? const Stream<String>.empty();

  @override
  Future<void> close() async => _channel?.sink.close();
}

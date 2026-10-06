/*
Copyright (c) 2026 Neytra Intelligence Platform. All rights reserved.

This software and its source code are proprietary and confidential.

No permission is granted to copy, modify, distribute, sublicense, sell, or otherwise use this software without prior written permission from the copyright holder.

Unauthorized use, reproduction, or distribution is prohibited.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.
*/

import 'package:flutter/material.dart';

import '../bootstrap/app_environment.dart';
import 'router/app_router.dart';
import 'theme/dark_theme.dart';
import 'theme/light_theme.dart';

class NeytraApp extends StatelessWidget {
  const NeytraApp({required this.environment, super.key});

  final AppEnvironment environment;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Neytra Console',
      debugShowCheckedModeBanner: environment != AppEnvironment.production,
      theme: buildLightTheme(),
      darkTheme: buildDarkTheme(),
      themeMode: ThemeMode.light,
      routerConfig: appRouter,
    );
  }
}

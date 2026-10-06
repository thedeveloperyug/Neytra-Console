<!--
Copyright (c) 2026 Neytra Intelligence Platform. All rights reserved.

This software and its source code are proprietary and confidential.

No permission is granted to copy, modify, distribute, sublicense, sell, or otherwise use this software without prior written permission from the copyright holder.

Unauthorized use, reproduction, or distribution is prohibited.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.
-->

# Neytra Console

Cross-platform customer console for the Neytra Intelligence Platform (NIP).

## Targets

- Web
- Windows
- Ubuntu/Linux
- Android
- iOS

The console is a Flutter/Dart client. It communicates only with the Neytra Control Plane over versioned HTTPS APIs and realtime channels; it does not call NIP internals directly.

## Architecture principles

- One Flutter codebase across supported customer platforms.
- Feature-first modular structure.
- Business configuration is isolated from runtime implementation.
- Customer-facing concepts never expose NIP private implementation details.
- Authentication, tenant authorization, secrets, and authoritative business policy remain server-side.
- Platform folders contain bootstrap/integration only; business logic remains in Dart.

## Branch policy

Development is performed on `master`. Changes are reviewed by pull request before merging into `main`.

## Bootstrap

Run `scripts/bootstrap.sh` on macOS/Linux or `scripts/bootstrap.ps1` on Windows after installing Flutter.

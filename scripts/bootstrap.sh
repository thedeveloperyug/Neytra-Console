# Copyright (c) 2026 Neytra Intelligence Platform. All rights reserved.
# 
# This software and its source code are proprietary and confidential.
# 
# No permission is granted to copy, modify, distribute, sublicense, sell, or otherwise use this software without prior written permission from the copyright holder.
# 
# Unauthorized use, reproduction, or distribution is prohibited.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.

set -euo pipefail

command -v flutter >/dev/null 2>&1 || { echo "Flutter is required."; exit 1; }
flutter create . --project-name neytra_console --org ai.neytra --platforms=web,windows,linux,android,ios
flutter pub get
dart format lib test packages

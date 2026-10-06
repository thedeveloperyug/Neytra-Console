<!--
Copyright (c) 2026 Neytra Intelligence Platform. All rights reserved.

This software and its source code are proprietary and confidential.

No permission is granted to copy, modify, distribute, sublicense, sell, or otherwise use this software without prior written permission from the copyright holder.

Unauthorized use, reproduction, or distribution is prohibited.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.
-->

# Frontend Architecture

Neytra Console uses a feature-first Flutter architecture. Presentation depends on domain contracts; data implementations remain behind repository interfaces. The Console communicates with the Neytra Control Plane rather than NIP directly.

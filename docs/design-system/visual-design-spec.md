<!--
Copyright (c) 2026 Neytra Intelligence Platform. All rights reserved.

This software and its source code are proprietary and confidential.

No permission is granted to copy, modify, distribute, sublicense, sell, or otherwise use this software without prior written permission from the copyright holder.

Unauthorized use, reproduction, or distribution is prohibited.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.
-->

# Neytra Console Visual Design Specification

**Status:** Canonical visual direction for Neytra Console  
**Primary targets:** Web, Windows, Ubuntu/Linux, Android, iOS  
**Implementation:** Flutter + Dart  
**Design language:** **Off-white glassmorphism with glossy 3D glass components**

This document is the visual source of truth for Neytra Console. It defines the product's visual language, interaction hierarchy, responsive behavior, accessibility rules, motion principles, and Flutter implementation constraints.

---

## 1. Product Design Intent

Neytra Console is an enterprise operating surface for governed AI business operations. It must feel:

- premium without becoming decorative,
- futuristic without becoming cyberpunk,
- calm and trustworthy enough for finance, compliance, operations, and enterprise users,
- fast and responsive even while long-running NIP Outcomes execute asynchronously,
- consistent across web, desktop, tablet, and mobile,
- distinct enough to be recognizable as Neytra without sacrificing usability.

The user should feel that Neytra is an **intelligence operating system for business**, not a generic admin dashboard and not a chatbot wrapped in cards.

### Core visual statement

> **Off-white glassmorphism with glossy 3D glass components, soft frosted panels, subtle blur, glowing edges, gentle glass refraction, and cyan-to-electric-blue intelligence accents.**

### Design balance

Use the following priority:

- **70% clarity and business usability**
- **20% premium visual polish**
- **10% visual wow**

Glass effects must never reduce readability, accessibility, or perceived speed.

---

## 2. Visual Hierarchy

Neytra uses three visual surface layers.

### Layer 1 — Workspace Canvas

Purpose: calm base for all application content.

Characteristics:

- off-white background,
- extremely subtle cool gradients,
- no strong texture,
- ambient blue/cyan light only in low-opacity localized areas,
- enough contrast for glass surfaces to be visible.

Recommended base colors:

| Token | Value | Use |
|---|---|---|
| `canvas.primary` | `#F6F8FB` | Main workspace |
| `canvas.secondary` | `#F1F5F9` | Secondary regions |
| `canvas.highlight` | `#FBFCFD` | Bright local glow |
| `canvas.cool` | `#EAF2FA` | Subtle cool ambient gradient |

Avoid pure white as the full-page background.

### Layer 2 — Frosted Glass Surfaces

Purpose: normal product structure.

Used for:

- sidebar,
- top navigation,
- KPI cards,
- attention panel,
- solution cards,
- filters,
- analytics containers,
- dialogs,
- search and Ask Neytra,
- compact floating controls.

Characteristics:

- translucent off-white fill,
- soft background blur,
- subtle top/edge highlight,
- low-opacity border,
- soft shadow,
- restrained depth.

### Layer 3 — Glossy 3D Glass Accents

Purpose: emphasis only.

Used for:

- canonical Neytra logo presentation,
- primary action buttons,
- selected/active navigation,
- Ask Neytra AI affordance,
- highlighted KPI or hero metric,
- active solution state,
- important approval action,
- small premium status surfaces.

Characteristics:

- stronger cyan/blue gradients,
- glossy specular highlight,
- glass refraction,
- brighter edge glow,
- more dimensional depth.

Do not apply Layer 3 styling to every card.

---

## 3. Brand Mark

The canonical Neytra logo is:

`assets/branding/logo/neytra_n.png`

The SVG companion is:

`assets/branding/logo/neytra_n.svg`

The PNG is the canonical visual source of truth. The SVG currently embeds the canonical PNG so both representations render identically.

### Logo usage

- Desktop sidebar mark: **30–36 logical px** high.
- Compact desktop sidebar: **28–32 logical px**.
- Mobile top bar: **28–32 logical px**.
- Auth/onboarding hero: **64–96 logical px**.
- Do not distort aspect ratio.
- Do not recolor the logo.
- Do not place it over high-detail backgrounds.
- Prefer off-white or lightly frosted glass behind the mark.
- Preserve enough clear space around the mark to prevent the ribbon form from touching UI edges.

For primary desktop navigation use:

`[N logo] NEYTRA`

For very narrow layouts use the mark by itself.

---

## 4. Color System

### 4.1 Neytra intelligence gradient

Primary brand gradient:

`#56F7F4 → #11DDF4 → #0878FF → #1826E8`

Use it for:

- primary CTA,
- active state accents,
- selected navigation indicator,
- AI/Ask Neytra affordances,
- active progress,
- highlighted chart series,
- premium glass edges.

Do not use the full gradient as a page background.

### 4.2 Text colors

| Token | Value | Use |
|---|---|---|
| `text.primary` | `#0A1733` | Titles, key values |
| `text.secondary` | `#52627A` | Secondary labels |
| `text.tertiary` | `#78869A` | Metadata |
| `text.disabled` | `#A8B1BF` | Disabled controls |
| `text.inverse` | `#FFFFFF` | Text on strong blue |

Avoid low-opacity grey text on glass.

### 4.3 Surface colors

| Token | Suggested value |
|---|---|
| `glass.standard` | `rgba(255,255,255,0.62)` |
| `glass.elevated` | `rgba(255,255,255,0.74)` |
| `glass.data` | `rgba(255,255,255,0.88)` |
| `glass.border` | `rgba(255,255,255,0.78)` |
| `glass.borderCool` | `rgba(112,170,230,0.16)` |

Data-dense surfaces such as tables should use the more opaque `glass.data` treatment.

### 4.4 Semantic colors

| Meaning | Core |
|---|---|
| Success / verified | `#16A36A` |
| Warning / attention | `#D68A16` |
| Error / blocked | `#D84A5B` |
| Informational | `#287DDF` |
| Running / intelligence | Neytra blue/cyan gradient |

Semantic states must include icon + text; never rely on color alone.

---

## 5. Glass Material Specification

### Standard Frosted Glass

Use for most panels:

- fill: 55–68% white,
- backdrop blur: **14–20 logical px**,
- border: 1 px translucent white/cool blue,
- radius: 18–24 px,
- subtle top inner highlight,
- shadow: low-opacity cool/navy.

Suggested shadow:

`0 10px 32px rgba(19, 42, 77, 0.08)`

### Elevated Glass

Use for dialogs, selected cards, and floating regions:

- fill: 68–78% white,
- blur: 18–24 px,
- stronger edge highlight,
- shadow:

`0 18px 48px rgba(20, 48, 88, 0.12)`

### Glossy 3D Glass

Use sparingly:

- blue/cyan gradient underlay,
- translucent white highlight at top-left,
- subtle internal refraction,
- 1 px luminous edge,
- soft inner shadow,
- slight depth shift on hover/press.

The component must still remain readable at 100% display scaling and in reduced-transparency mode.

### Refraction

Refraction is an accent, not a global effect.

Good places:

- logo container,
- Ask Neytra affordance,
- hero metric,
- selected solution card,
- primary button hover.

Avoid refraction behind:

- dense tables,
- long paragraphs,
- audit logs,
- evidence details,
- forms with many inputs.

---

## 6. Radius and Shape Language

Neytra uses soft geometry.

| Token | Radius |
|---|---:|
| `radius.sm` | 10 px |
| `radius.md` | 14 px |
| `radius.lg` | 18 px |
| `radius.xl` | 24 px |
| `radius.2xl` | 30 px |
| `radius.pill` | 999 px |

Guidelines:

- input fields: 12–14 px,
- buttons: 12–16 px,
- dashboard cards: 20–24 px,
- major hero panels: 24–30 px,
- status chips: pill.

Avoid sharp 0–4 px corners except for technical visualizations that specifically require them.

---

## 7. Spacing System

Base unit: **4 logical px**.

Primary spacing scale:

`4, 8, 12, 16, 20, 24, 32, 40, 48, 64`

Recommended application:

- icon-to-label: 8 px,
- control internal padding: 12–16 px,
- card content padding: 20–24 px,
- section gap: 24–32 px,
- major page section gap: 32–48 px,
- desktop page gutter: 28–32 px,
- mobile page gutter: 16–20 px.

Avoid arbitrary spacing values unless needed for optical alignment.

---

## 8. Typography

Preferred UI typeface: **Inter**.

Fallback:

`Inter, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif`

Typography should be neutral and highly legible. Brand personality comes from material, spacing, color, and motion—not decorative fonts.

### Type scale

| Role | Size | Weight | Typical use |
|---|---:|---:|---|
| Display | 40–48 | 600 | Auth/onboarding hero |
| H1 | 30–34 | 600 | Page title |
| H2 | 24–28 | 600 | Major section |
| H3 | 18–20 | 600 | Card title |
| Metric XL | 30–40 | 650 | KPI values |
| Body | 14–16 | 400 | General UI |
| Body Strong | 14–16 | 600 | Important body |
| Caption | 12–13 | 500 | Metadata |
| Label | 12–14 | 600 | Controls/status |

Line height should generally be 1.35–1.55 depending on density.

Use tabular numerals for business metrics when available.

---

## 9. Iconography

Use clean outline icons with:

- 1.75–2 px visual stroke,
- rounded endpoints,
- simple geometric shapes,
- consistent 20 / 24 px base sizes.

Navigation icons should be 20–22 px. Primary action icons can be 18–20 px.

Avoid mixing icon families.

Neytra-specific intelligence actions may use a subtle sparkle/light motif, but not every AI-powered action needs a sparkle icon.

---

## 10. Primary Application Shell

### Desktop

Target shell:

- Sidebar: **248 px** expanded.
- Sidebar collapsed: **76–84 px**.
- Top bar: **68–76 px**.
- Main content: fluid.
- Max content width may be applied selectively to forms/readable detail pages, not dashboards.

Navigation order:

1. Overview
2. Solutions
3. Outcomes
4. Approvals
5. Evidence
6. Analytics
7. Connectors
8. Team
9. Settings

The canonical logo and NEYTRA wordmark live at the top of the sidebar.

### Tablet

- collapsed rail or compact drawer,
- 2-column KPI/content grids,
- preserve full business functionality,
- configuration pages may use stacked sections.

### Mobile

Do not shrink the desktop shell.

Primary mobile navigation:

- Overview
- Outcomes
- Approvals
- More

Mobile emphasizes:

- alerts,
- approvals,
- Outcome state,
- evidence,
- KPI summaries.

Complex solution configuration remains available but is optimized primarily for desktop/tablet.

---

## 11. Overview Dashboard — First Post-Login Page

The first page after sign-in is a **Business Operations Dashboard**.

It must answer within roughly five seconds:

1. What is Neytra doing?
2. What needs my attention?
3. Is it working reliably?
4. What business value is it producing?

### Required order

#### Header

- Greeting / organization context.
- Search / Ask Neytra.
- Notifications.
- Organization switcher.
- User/avatar menu.

#### KPI row

Initial recommended metrics:

- Outcomes this month,
- Verified completion rate,
- Items needing attention,
- AI/platform spend.

Use 4 cards on large desktop, 2×2 on tablet, horizontal/stacked cards on mobile.

#### Attention Required

This is one of the highest-priority surfaces.

Examples:

- invoices needing review,
- pending approvals,
- connector re-authentication,
- Outcomes blocked on missing evidence,
- budget warnings.

Do not hide critical attention behind charts.

#### Active Solutions

Cards for enabled business solutions such as:

- Accounts Payable,
- Procurement,
- Customer Support,
- Compliance.

Each card shows:

- health,
- current volume,
- exception count,
- one or two business metrics,
- Open Solution action.

#### Live Outcomes

Show customer-safe business phases:

- Reading,
- Matching,
- Reconciling,
- Verifying,
- Waiting for approval,
- Completed.

Never expose NIP internal coordinator leases, scheduler fences, database row IDs, provider adapter classes, or internal attempt machinery.

#### Business Impact

Show measurable value when supported by real data:

- outcomes completed,
- review time saved,
- transaction value reviewed,
- exceptions identified,
- evidence-complete rate,
- average completion time.

Do not fabricate ROI metrics.

---

## 12. Ask Neytra

Ask Neytra is a prominent interaction mechanism but not the entire product.

Recommended appearance:

- large frosted search-like control,
- subtle glass glow,
- Neytra gradient focus ring,
- clear placeholder:
  **“Ask Neytra about your operations…”**

Examples:

- “Why are 18 invoices waiting?”
- “Show quantity mismatches over ₹50,000.”
- “Which supplier has the most exceptions?”
- “What changed in Accounts Payable today?”

Results should link back to structured Console objects and evidence.

---

## 13. Component Design Rules

### KPI Cards

- Frosted standard glass.
- Large metric.
- Short label.
- Optional comparison/trend.
- At most one small supporting chart.
- Do not fill with decorative gradients.

### Attention Cards

- Higher contrast than ordinary cards.
- Semantic icon.
- Plain-language description.
- Direct action.
- Count/status visible at a glance.

### Solution Cards

- 20–24 px radius.
- Glass surface.
- Compact health indicator.
- Business metrics.
- Selected/hover state gets subtle 3D glossy edge.

### Data Tables

Use near-opaque surfaces.

Requirements:

- sticky header where appropriate,
- clear row hover,
- strong text contrast,
- column alignment,
- numeric right alignment,
- pagination/cursor navigation,
- sortable headers,
- no heavy refraction behind table cells.

### Buttons

**Primary**
- Neytra gradient,
- white label,
- subtle glossy highlight,
- 44–48 px minimum height.

**Secondary**
- frosted glass,
- dark text,
- subtle border.

**Tertiary**
- transparent/light,
- no excessive chrome.

**Destructive**
- semantic red,
- never use Neytra blue for destructive confirmation.

### Inputs

- 44–48 px default height.
- Soft white/glass fill.
- Clear label above or persistent label.
- Strong focus ring.
- Error text immediately below.
- Never rely on placeholder as the only label.

### Status Chips

Use restrained fills:

- Verified
- Running
- Attention
- Blocked
- Waiting approval
- Completed

Always pair color with text/icon.

---

## 14. Motion and Interaction

Motion should communicate state, not decorate the interface.

### Timing

| Interaction | Duration |
|---|---:|
| Hover / small state change | 100–140 ms |
| Press / toggle | 120–160 ms |
| Card expansion | 180–240 ms |
| Page/route transition | 220–300 ms |
| Dialog/sheet | 180–260 ms |

Prefer smooth ease-out curves.

### Glass interaction

On hover:

- +1–2% brightness,
- slightly stronger border,
- optional 1–2 px upward translation,
- small increase in shadow,
- never dramatic scaling.

On press:

- reduce elevation,
- return translation toward zero,
- fast response.

### Outcome progress

Use smooth but honest transitions. Never animate progress in a way that implies work has completed before the Control Plane confirms it.

### Reduced motion

Respect system reduced-motion settings:

- remove unnecessary translations,
- reduce crossfades,
- disable looping decorative effects.

---

## 15. Performance Rules for Glassmorphism

Glass effects can be expensive in Flutter. Performance is part of the visual design.

Target:

- **60 fps baseline** on supported hardware.
- Higher refresh rates should benefit automatically where available.
- No visible jank during navigation, scrolling, or Outcome updates.

Rules:

1. Avoid nesting multiple `BackdropFilter` layers.
2. Prefer a small number of large shared glass regions over dozens of independently blurred children.
3. Use static gradients whenever dynamic refraction is unnecessary.
4. Put expensive glass regions inside appropriate repaint boundaries.
5. Data tables should use near-opaque surfaces rather than per-row blur.
6. Do not animate blur sigma continuously.
7. Avoid full-screen live blur during scrolling on low-power mobile devices.
8. Provide a reduced-transparency rendering mode if platform capability or accessibility requires it.
9. Profile real Web, Windows, Ubuntu, Android, and iOS builds—not only debug mode.

Perceived speed is more important than decorative complexity.

---

## 16. Responsive Breakpoints

Canonical layout breakpoints:

| Mode | Width |
|---|---|
| Mobile | < 600 |
| Tablet | 600–1023 |
| Desktop | 1024–1439 |
| Large desktop | ≥ 1440 |

Do not use device type alone to choose layout; use available width and capability.

Large desktop dashboards may use 12-column grids.

Tablet normally uses 8-column or simplified 2-column layouts.

Mobile uses a 4-column conceptual grid and stacked content.

---

## 17. Accessibility

Neytra Console must target **WCAG 2.2 AA** for customer-facing UI where applicable.

Requirements:

- body text contrast ≥ 4.5:1,
- large text contrast ≥ 3:1,
- visible keyboard focus,
- full keyboard navigation on web/desktop,
- screen-reader labels for interactive controls,
- no color-only status communication,
- touch targets at least 44×44 logical px; target 48×48 when practical,
- reduced motion support,
- text scaling support,
- no essential information communicated only through blur/transparency.

If glass styling conflicts with accessibility, accessibility wins.

---

## 18. Charts and Analytics

Charts must feel like part of the Neytra system, not a generic rainbow BI dashboard.

Primary series:

- Neytra cyan,
- Neytra blue,
- deep blue.

Secondary semantic series:

- success green,
- warning amber,
- error red.

Rules:

- use no more colors than necessary,
- always provide labels/tooltips,
- use accessible line/shape differentiation,
- prefer direct labels for critical business metrics,
- keep chart backgrounds calm and near-opaque,
- avoid 3D charts.

---

## 19. Empty, Loading, Error, and Offline States

### Loading

Prefer skeleton surfaces and local progress indicators over full-page spinners.

### Empty

Explain:

- what this area is,
- why it is empty,
- what the user can do next.

### Error

Show:

- safe plain-language description,
- correlation/reference ID when useful,
- retry action when safe,
- support path where appropriate.

Never show:

- stack traces,
- provider credentials,
- internal C++ names,
- raw NIP exceptions,
- database details.

### Offline / disconnected

Keep the current screen readable where safe.

Clearly distinguish:

- stale cached information,
- confirmed live information.

Realtime disconnects should show subtle connection status and recover automatically.

---

## 20. Authentication and Onboarding Visuals

Authentication should use a quieter version of the Neytra language:

- off-white ambient canvas,
- large canonical N mark,
- one centered frosted panel,
- minimal copy,
- no dashboard chrome.

First-time organization onboarding:

1. Organization
2. Choose Solution
3. Connect Systems
4. Configure Policy
5. Test
6. Go Live

Use a calm stepper with obvious completion states.

---

## 21. Mobile Experience

Mobile is not a compressed desktop dashboard.

Priority order:

1. Attention required
2. Approvals
3. Active Outcomes
4. Evidence
5. Notifications
6. KPI summaries

Example first screen:

- Neytra header,
- “Need your attention” hero card,
- today’s Outcomes,
- verified rate,
- pending approvals,
- compact bottom navigation.

Avoid dense multi-column configuration UIs on narrow mobile layouts.

---

## 22. Desktop and Ubuntu/Windows Behavior

Desktop builds should feel native enough for daily enterprise use.

Requirements:

- hover states,
- right-click/context actions only where genuinely useful,
- keyboard shortcuts for common operations,
- sensible window resizing,
- minimum supported window width,
- clear focus management,
- platform-consistent file pickers when required,
- no mobile-only interaction assumptions.

Do not expose NIP filesystem details through desktop convenience features.

---

## 23. Dark Mode

The off-white glassmorphism theme is the **primary launch visual direction**.

Dark mode may exist architecturally but should not be considered production-complete until:

- all glass materials are redesigned for dark surfaces,
- contrast is validated,
- semantic colors are rebalanced,
- charts are reviewed,
- refraction/glow levels are tuned.

Do not simply invert the light theme.

---

## 24. Flutter Design-System Architecture

The implementation should centralize tokens in:

`packages/neytra_design_system/`

Recommended token classes:

- `NeytraColors`
- `NeytraGradients`
- `NeytraSpacing`
- `NeytraRadius`
- `NeytraTypography`
- `NeytraShadows`
- `NeytraGlass`
- `NeytraMotion`
- `NeytraBreakpoints`

Recommended reusable components:

- `NeytraGlassSurface`
- `NeytraGlassCard`
- `NeytraMetricCard`
- `NeytraAttentionCard`
- `NeytraSolutionCard`
- `NeytraButton`
- `NeytraTextField`
- `NeytraStatusBadge`
- `NeytraOutcomeTimeline`
- `NeytraEvidenceCard`
- `NeytraDialog`
- `NeytraTable`
- `NeytraAskBar`
- `NeytraSidebar`
- `NeytraTopBar`

Feature code should consume these components rather than recreate local glass styles.

---

## 25. Initial Build Scope

The first visual implementation should build the real application shell and Overview page with mocked/static data before Control Plane integration.

Required first slice:

1. canonical Neytra logo,
2. responsive sidebar/navigation,
3. top bar,
4. Ask Neytra field,
5. four KPI cards,
6. Attention Required panel,
7. Active Solutions cards,
8. Live Outcomes list/progress,
9. Business Impact section,
10. desktop + tablet + mobile adaptive layouts.

The first slice should validate:

- visual identity,
- responsive behavior,
- glass performance,
- navigation hierarchy,
- component reuse,
- accessibility baseline.

Only after the shell is stable should individual features connect to Control Plane APIs.

---

## 26. Do / Do Not

### Do

- keep the workspace bright, calm, and premium,
- use glass to create hierarchy,
- reserve glossy 3D treatment for emphasis,
- make critical business state obvious,
- use the Neytra gradient consistently,
- keep customer language business-oriented,
- make every state feel responsive,
- keep the canonical logo exact.

### Do not

- turn every card into glowing glass,
- use dark cyberpunk aesthetics for the default experience,
- show NIP implementation concepts to business users,
- overuse blur behind dense information,
- create rainbow analytics,
- use motion that implies false progress,
- prioritize decoration over evidence/readability,
- place secrets, credentials, or internal policy details in UI assets.

---

## 27. Design Review Checklist

A Neytra screen is ready for review only if:

- the user's primary business question is obvious,
- there is one clear hierarchy of attention,
- glass effects preserve text contrast,
- layout works at desktop/tablet/mobile widths,
- keyboard/focus behavior is defined,
- loading/error/empty states exist,
- animation is purposeful and reduced-motion safe,
- no NIP private implementation detail leaks into customer language,
- no secret or credential is rendered,
- data-dense regions use readable near-opaque surfaces,
- logo usage follows the canonical asset,
- the screen still makes sense with blur disabled.

---

## 28. Canonical Product Impression

Every major Neytra Console screen should communicate:

> **Governed business intelligence is operating continuously, the important information is immediately understandable, and the customer remains in control.**

The visual system should make Neytra feel advanced before the user reads documentation—but trustworthy after they begin using it.

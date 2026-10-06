/*
Copyright (c) 2026 Neytra Intelligence Platform. All rights reserved.

This software and its source code are proprietary and confidential.

No permission is granted to copy, modify, distribute, sublicense, sell, or otherwise use this software without prior written permission from the copyright holder.

Unauthorized use, reproduction, or distribution is prohibited.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.
*/

import 'dart:ui';

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _busy = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _previewSignIn() async {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _busy = true);
    await Future<void>.delayed(const Duration(milliseconds: 320));
    if (!mounted) return;

    _passwordController.clear();
    setState(() => _busy = false);
    _showPreviewMessage(
      'Authentication is not connected in this GitHub Pages preview. '
      'No credentials were transmitted.',
    );
  }

  void _previewSso() {
    _showPreviewMessage(
      'Organization SSO will be connected through the Neytra Control Plane '
      'using your enterprise identity provider.',
    );
  }

  void _previewPasswordReset() {
    _showPreviewMessage(
      'Password recovery will be provided by the configured organization '
      'identity service.',
    );
  }

  void _showPreviewMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          backgroundColor: const Color(0xFF0A1733),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isDesktop = size.width >= 1024;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          const _AmbientBackground(),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? 36 : 20,
                  vertical: 28,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1180),
                  child: isDesktop
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Expanded(
                              flex: 11,
                              child: Padding(
                                padding: EdgeInsets.only(right: 72),
                                child: _BrandStory(),
                              ),
                            ),
                            SizedBox(
                              width: 458,
                              child: _LoginGlassCard(
                                formKey: _formKey,
                                emailController: _emailController,
                                passwordController: _passwordController,
                                obscurePassword: _obscurePassword,
                                busy: _busy,
                                onTogglePassword: () => setState(
                                  () => _obscurePassword = !_obscurePassword,
                                ),
                                onSignIn: _previewSignIn,
                                onSso: _previewSso,
                                onForgotPassword: _previewPasswordReset,
                              ),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const _CompactBrand(),
                            const SizedBox(height: 28),
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 480),
                              child: _LoginGlassCard(
                                formKey: _formKey,
                                emailController: _emailController,
                                passwordController: _passwordController,
                                obscurePassword: _obscurePassword,
                                busy: _busy,
                                onTogglePassword: () => setState(
                                  () => _obscurePassword = !_obscurePassword,
                                ),
                                onSignIn: _previewSignIn,
                                onSso: _previewSso,
                                onForgotPassword: _previewPasswordReset,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AmbientBackground extends StatelessWidget {
  const _AmbientBackground();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Color(0xFFFBFCFD),
                Color(0xFFF4F7FB),
                Color(0xFFEEF4FA),
              ],
            ),
          ),
        ),
        const Positioned(
          left: -180,
          top: -140,
          child: _GlowOrb(
            size: 540,
            colors: <Color>[
              Color(0x3A56F7F4),
              Color(0x060878FF),
            ],
          ),
        ),
        const Positioned(
          right: -180,
          bottom: -210,
          child: _GlowOrb(
            size: 620,
            colors: <Color>[
              Color(0x300878FF),
              Color(0x041826E8),
            ],
          ),
        ),
      ],
    );
  }
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({required this.size, required this.colors});

  final double size;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: SizedBox(
        width: size,
        height: size,
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(colors: colors),
          ),
        ),
      ),
    );
  }
}

class _BrandStory extends StatelessWidget {
  const _BrandStory();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _BrandLockup(logoHeight: 58),
        SizedBox(height: 38),
        Text(
          'Intelligence for\ngoverned business operations.',
          style: TextStyle(
            color: Color(0xFF0A1733),
            fontSize: 44,
            height: 1.10,
            fontWeight: FontWeight.w700,
            letterSpacing: -1.35,
          ),
        ),
        SizedBox(height: 22),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 560),
          child: Text(
            'Configure solutions, monitor verified outcomes, review evidence, '
            'and keep your organization in control from one secure workspace.',
            style: TextStyle(
              color: Color(0xFF52627A),
              fontSize: 17,
              height: 1.55,
            ),
          ),
        ),
        SizedBox(height: 38),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: <Widget>[
            _TrustPill(
              icon: Icons.verified_user_outlined,
              label: 'Governed execution',
            ),
            _TrustPill(
              icon: Icons.fact_check_outlined,
              label: 'Verified outcomes',
            ),
            _TrustPill(
              icon: Icons.shield_outlined,
              label: 'Evidence by design',
            ),
          ],
        ),
      ],
    );
  }
}

class _CompactBrand extends StatelessWidget {
  const _CompactBrand();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _BrandLockup(logoHeight: 48, centered: true),
        SizedBox(height: 14),
        Text(
          'Secure intelligence for business operations',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF52627A),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _BrandLockup extends StatelessWidget {
  const _BrandLockup({
    required this.logoHeight,
    this.centered = false,
  });

  final double logoHeight;
  final bool centered;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment:
          centered ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: <Widget>[
        Image.asset(
          'assets/branding/logo/neytra_n.png',
          height: logoHeight,
          filterQuality: FilterQuality.high,
          semanticLabel: 'Neytra logo',
        ),
        const SizedBox(width: 10),
        Text(
          'NEYTRA',
          style: TextStyle(
            color: const Color(0xFF0A1733),
            fontSize: logoHeight * 0.34,
            fontWeight: FontWeight.w800,
            letterSpacing: 4.2,
          ),
        ),
      ],
    );
  }
}

class _TrustPill extends StatelessWidget {
  const _TrustPill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0x94FFFFFF),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xCFFFFFFF)),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x0D132A4D),
            blurRadius: 24,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, size: 17, color: const Color(0xFF0878FF)),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF34445E),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginGlassCard extends StatelessWidget {
  const _LoginGlassCard({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.obscurePassword,
    required this.busy,
    required this.onTogglePassword,
    required this.onSignIn,
    required this.onSso,
    required this.onForgotPassword,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final bool busy;
  final VoidCallback onTogglePassword;
  final VoidCallback onSignIn;
  final VoidCallback onSso;
  final VoidCallback onForgotPassword;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: const Color(0xC9FFFFFF),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: const Color(0xE6FFFFFF)),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x16132A4D),
                blurRadius: 48,
                offset: Offset(0, 22),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(34, 34, 34, 30),
            child: AutofillGroup(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text(
                      'Welcome back',
                      style: TextStyle(
                        color: Color(0xFF0A1733),
                        fontSize: 28,
                        height: 1.15,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Sign in to your organization workspace.',
                      style: TextStyle(
                        color: Color(0xFF66758B),
                        fontSize: 14,
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 28),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autofillHints: const <String>[AutofillHints.username],
                      decoration: const InputDecoration(
                        labelText: 'Work email',
                        hintText: 'name@company.com',
                        prefixIcon: Icon(Icons.alternate_email_rounded),
                      ),
                      validator: (value) {
                        final text = value?.trim() ?? '';
                        if (text.isEmpty) return 'Enter your work email.';
                        if (!text.contains('@') || !text.contains('.')) {
                          return 'Enter a valid email address.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: passwordController,
                      obscureText: obscurePassword,
                      textInputAction: TextInputAction.done,
                      autofillHints: const <String>[AutofillHints.password],
                      onFieldSubmitted: (_) => onSignIn(),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        suffixIcon: IconButton(
                          tooltip: obscurePassword
                              ? 'Show password'
                              : 'Hide password',
                          onPressed: onTogglePassword,
                          icon: Icon(
                            obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if ((value ?? '').isEmpty) return 'Enter your password.';
                        return null;
                      },
                    ),
                    const SizedBox(height: 4),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: onForgotPassword,
                        child: const Text('Forgot password?'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _PrimarySignInButton(
                      busy: busy,
                      onPressed: busy ? null : onSignIn,
                    ),
                    const SizedBox(height: 24),
                    const _DividerLabel(label: 'OR'),
                    const SizedBox(height: 24),
                    _OrganizationSsoButton(onPressed: onSso),
                    const SizedBox(height: 24),
                    const _PreviewNotice(),
                    const SizedBox(height: 20),
                    const Text(
                      'Need access? Contact your organization administrator.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF7A8799),
                        fontSize: 12,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PrimarySignInButton extends StatelessWidget {
  const _PrimarySignInButton({
    required this.busy,
    required this.onPressed,
  });

  final bool busy;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF20DFF2),
            Color(0xFF0878FF),
            Color(0xFF1826E8),
          ],
        ),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x2B0878FF),
            blurRadius: 24,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: Colors.transparent,
          disabledBackgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: busy
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2.3,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const Text(
                'Sign in',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
      ),
    );
  }
}

class _OrganizationSsoButton extends StatelessWidget {
  const _OrganizationSsoButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.domain_rounded, size: 21),
      label: const Text('Continue with organization SSO'),
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF172A46),
        backgroundColor: const Color(0x8AFFFFFF),
        side: const BorderSide(color: Color(0xFFDBE6F2)),
        minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _DividerLabel extends StatelessWidget {
  const _DividerLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Expanded(child: Divider(color: Color(0xFFDFE7F0))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            label,
            style: const TextStyle(
              color: Color(0xFF8B97A8),
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const Expanded(child: Divider(color: Color(0xFFDFE7F0))),
      ],
    );
  }
}

class _PreviewNotice extends StatelessWidget {
  const _PreviewNotice();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xB8F6FAFD),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE0EAF3)),
      ),
      child: const Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.lock_person_outlined,
              size: 18,
              color: Color(0xFF287DDF),
            ),
            SizedBox(width: 9),
            Expanded(
              child: Text(
                'Preview deployment: authentication is not connected. '
                'Credentials entered here are not transmitted.',
                style: TextStyle(
                  color: Color(0xFF596A80),
                  fontSize: 11.5,
                  height: 1.45,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() => _busy = true);
    await Future<void>.delayed(const Duration(milliseconds: 320));
    if (!mounted) {
      return;
    }

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
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= 1024;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          const _AmbientBackground(),
          const _GlassRibbonField(),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? 36 : 18,
                  vertical: isDesktop ? 34 : 20,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1220),
                  child: _HeroGlassSlab(
                    child: isDesktop
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const Expanded(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(12, 12, 68, 12),
                                  child: _BrandStory(),
                                ),
                              ),
                              SizedBox(
                                width: 430,
                                child: _LoginPanel(
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
                              const SizedBox(height: 26),
                              _LoginPanel(
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
                            ],
                          ),
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
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFFFFFCF7),
            Color(0xFFF8F9FB),
            Color(0xFFF0F6FB),
            Color(0xFFFAFBFD),
          ],
          stops: <double>[0, 0.34, 0.72, 1],
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned(
            left: -180,
            top: -150,
            child: _GlowOrb(
              size: 560,
              colors: <Color>[
                Color(0x3656F7F4),
                Color(0x120878FF),
                Color(0x00FFFFFF),
              ],
            ),
          ),
          Positioned(
            right: -170,
            top: 40,
            child: _GlowOrb(
              size: 500,
              colors: <Color>[
                Color(0x2455D8FF),
                Color(0x0A1826E8),
                Color(0x00FFFFFF),
              ],
            ),
          ),
          Positioned(
            right: -120,
            bottom: -210,
            child: _GlowOrb(
              size: 620,
              colors: <Color>[
                Color(0x2A8DEBFF),
                Color(0x0A0878FF),
                Color(0x00FFFFFF),
              ],
            ),
          ),
        ],
      ),
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

class _GlassRibbonField extends StatelessWidget {
  const _GlassRibbonField();

  @override
  Widget build(BuildContext context) {
    return const IgnorePointer(
      child: CustomPaint(
        painter: _GlassRibbonPainter(),
      ),
    );
  }
}

class _GlassRibbonPainter extends CustomPainter {
  const _GlassRibbonPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final bounds = Offset.zero & size;

    final glowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 54
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 22)
      ..shader = const LinearGradient(
        colors: <Color>[
          Color(0x1F56F7F4),
          Color(0x2A0878FF),
          Color(0x0DFFFFFF),
        ],
      ).createShader(bounds);

    final bodyPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 31
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0x64FFFFFF),
          Color(0x4C5FE9FF),
          Color(0x3A0878FF),
          Color(0x55FFFFFF),
        ],
        stops: <double>[0, 0.36, 0.72, 1],
      ).createShader(bounds);

    final highlightPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 6
      ..shader = const LinearGradient(
        colors: <Color>[
          Color(0xDFFFFFFF),
          Color(0x7A7CEEFF),
          Color(0xCCFFFFFF),
        ],
      ).createShader(bounds);

    final leftLoop = Path()
      ..moveTo(-40, size.height * 0.23)
      ..cubicTo(
        size.width * 0.10,
        size.height * 0.02,
        size.width * 0.19,
        size.height * 0.42,
        size.width * 0.03,
        size.height * 0.55,
      )
      ..cubicTo(
        -size.width * 0.05,
        size.height * 0.62,
        size.width * 0.05,
        size.height * 0.87,
        size.width * 0.18,
        size.height * 0.92,
      );

    final rightSweep = Path()
      ..moveTo(size.width * 0.82, -32)
      ..cubicTo(
        size.width * 1.04,
        size.height * 0.08,
        size.width * 0.83,
        size.height * 0.42,
        size.width * 0.99,
        size.height * 0.50,
      )
      ..cubicTo(
        size.width * 1.08,
        size.height * 0.55,
        size.width * 0.94,
        size.height * 0.74,
        size.width * 0.78,
        size.height * 0.79,
      );

    final lowerRibbon = Path()
      ..moveTo(-70, size.height * 0.76)
      ..cubicTo(
        size.width * 0.17,
        size.height * 0.62,
        size.width * 0.30,
        size.height * 0.96,
        size.width * 0.49,
        size.height * 0.86,
      )
      ..cubicTo(
        size.width * 0.70,
        size.height * 0.75,
        size.width * 0.74,
        size.height * 1.06,
        size.width * 1.08,
        size.height * 0.88,
      );

    for (final path in <Path>[leftLoop, rightSweep, lowerRibbon]) {
      canvas.drawPath(path, glowPaint);
      canvas.drawPath(path, bodyPaint);
      canvas.drawPath(path, highlightPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _GlassRibbonPainter oldDelegate) => false;
}

class _HeroGlassSlab extends StatelessWidget {
  const _HeroGlassSlab({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.sizeOf(context).width >= 1024;
    final radius = BorderRadius.circular(isDesktop ? 38 : 30);

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x1D173A66),
            blurRadius: 76,
            spreadRadius: 2,
            offset: Offset(0, 34),
          ),
          BoxShadow(
            color: Color(0x70FFFFFF),
            blurRadius: 20,
            offset: Offset(0, -6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 34, sigmaY: 34),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: radius,
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                        Color(0xD9FFFFFF),
                        Color(0xB9F9FCFF),
                        Color(0xA9F0F8FF),
                        Color(0xCFFFFFFF),
                      ],
                      stops: <double>[0, 0.34, 0.72, 1],
                    ),
                    border: Border.all(
                      color: const Color(0xE6FFFFFF),
                      width: 1.8,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: IgnorePointer(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: radius,
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                          Color(0x99FFFFFF),
                          Color(0x14FFFFFF),
                          Color(0x000878FF),
                          Color(0x2A4FDFFF),
                        ],
                        stops: <double>[0, 0.28, 0.67, 1],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 18,
                right: 18,
                top: 14,
                child: IgnorePointer(
                  child: Container(
                    height: 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      gradient: const LinearGradient(
                        colors: <Color>[
                          Color(0x00FFFFFF),
                          Color(0xF2FFFFFF),
                          Color(0x6E8EDBFF),
                          Color(0x00FFFFFF),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(isDesktop ? 48 : 22),
                child: child,
              ),
            ],
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const _LogoPedestal(),
        const SizedBox(height: 30),
        const Text(
          'One intelligence layer.\nInfinite business possibility.',
          style: TextStyle(
            color: Color(0xFF0A1733),
            fontSize: 42,
            height: 1.10,
            fontWeight: FontWeight.w700,
            letterSpacing: -1.25,
          ),
        ),
        const SizedBox(height: 20),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Text(
            'Securely access Neytra Console to configure solutions, monitor '
            'verified outcomes, review evidence, and manage enterprise operations.',
            style: TextStyle(
              color: Color(0xFF52627A),
              fontSize: 16.5,
              height: 1.55,
            ),
          ),
        ),
        const SizedBox(height: 30),
        const Wrap(
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
              label: 'Enterprise control',
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
        _BrandLockup(logoHeight: 46, centered: true),
        SizedBox(height: 12),
        Text(
          'One intelligence layer. Infinite business possibility.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF52627A),
            fontSize: 13.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _LogoPedestal extends StatelessWidget {
  const _LogoPedestal();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x1F0878FF),
            blurRadius: 34,
            offset: Offset(0, 14),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            width: 176,
            height: 126,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Color(0xEFFFFFFF),
                  Color(0xA6F7FCFF),
                  Color(0xD8FFFFFF),
                ],
              ),
              border: Border.all(
                color: const Color(0xF5FFFFFF),
                width: 1.4,
              ),
            ),
            child: Image.asset(
              'assets/branding/logo/neytra_n.png',
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
              semanticLabel: 'Neytra logo',
            ),
          ),
        ),
      ),
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
            letterSpacing: 4.0,
          ),
        ),
      ],
    );
  }
}

class _TrustPill extends StatelessWidget {
  const _TrustPill({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: const Color(0x8FFFFFFF),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: const Color(0xD9FFFFFF)),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x0F173A66),
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
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginPanel extends StatelessWidget {
  const _LoginPanel({
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
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x18173A66),
            blurRadius: 38,
            offset: Offset(0, 18),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                        Color(0xEFFFFFFF),
                        Color(0xD7FBFDFF),
                        Color(0xC7F3F9FF),
                      ],
                    ),
                    border: Border.all(
                      color: const Color(0xF4FFFFFF),
                      width: 1.25,
                    ),
                  ),
                ),
              ),
              const Positioned(
                left: -20,
                top: -48,
                child: _PanelRefractionGlow(),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 26),
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
                            letterSpacing: -0.45,
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
                        const SizedBox(height: 26),
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
                            if (text.isEmpty) {
                              return 'Enter your work email.';
                            }
                            if (!text.contains('@') || !text.contains('.')) {
                              return 'Enter a valid email address.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
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
                            if ((value ?? '').isEmpty) {
                              return 'Enter your password.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 2),
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
                        const SizedBox(height: 22),
                        const _DividerLabel(label: 'OR'),
                        const SizedBox(height: 22),
                        _OrganizationSsoButton(onPressed: onSso),
                        const SizedBox(height: 22),
                        const _PreviewNotice(),
                        const SizedBox(height: 18),
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
            ],
          ),
        ),
      ),
    );
  }
}

class _PanelRefractionGlow extends StatelessWidget {
  const _PanelRefractionGlow();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 26, sigmaY: 26),
        child: Container(
          width: 230,
          height: 130,
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              colors: <Color>[
                Color(0x4256F7F4),
                Color(0x240878FF),
                Color(0x00FFFFFF),
              ],
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
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF30E6F3),
            Color(0xFF0A84FF),
            Color(0xFF1A35E8),
          ],
        ),
        border: Border.all(
          color: const Color(0xBFFFFFFF),
        ),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x330878FF),
            blurRadius: 26,
            offset: Offset(0, 12),
          ),
          BoxShadow(
            color: Color(0x52FFFFFF),
            blurRadius: 2,
            offset: Offset(0, -1),
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 12,
            right: 12,
            top: 2,
            child: Container(
              height: 1.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                color: const Color(0xAFFFFFFF),
              ),
            ),
          ),
          FilledButton(
            onPressed: onPressed,
            style: FilledButton.styleFrom(
              backgroundColor: Colors.transparent,
              disabledBackgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              minimumSize: const Size.fromHeight(52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
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
        ],
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
        backgroundColor: const Color(0x9FFFFFFF),
        side: const BorderSide(color: Color(0xE6FFFFFF), width: 1.2),
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
        const Expanded(child: Divider(color: Color(0xC9DCE7F1))),
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
        const Expanded(child: Divider(color: Color(0xC9DCE7F1))),
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
        color: const Color(0xA8F8FBFE),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xD9FFFFFF)),
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
                'UI preview: authentication is not connected. '
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../ui/theme/glass_theme.dart';
import '../../../ui/atoms/glass_button.dart';
import '../../../core/providers/providers.dart';
import 'sign_in_notifier.dart';
import 'sign_in_state.dart';

/// Sign In Screen with email/password and social login
class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SignInScreenContent();
  }
}

/// Sign in screen content
class SignInScreenContent extends ConsumerStatefulWidget {
  const SignInScreenContent({super.key});

  @override
  ConsumerState<SignInScreenContent> createState() => _SignInScreenContentState();
}

class _SignInScreenContentState extends ConsumerState<SignInScreenContent> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(signInNotifierProvider);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: _buildBody(context, state),
    );
  }

  Widget _buildBody(BuildContext context, SignInState state) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.orange.shade50.withOpacity(0.3),
            Colors.white.withOpacity(0),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Mesh background
          _buildMeshBackground(),
          // Main content
          SafeArea(
            child: Column(
              children: [
                // Top bar
                _buildTopBar(context),
                // Scrollable content
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        // Logo and title
                        _buildTitleSection(),
                        const SizedBox(height: 40),
                        // Form
                        _buildForm(state),
                        const SizedBox(height: 32),
                        // Divider
                        _buildDivider(),
                        const SizedBox(height: 24),
                        // Social buttons
                        _buildSocialButtons(state),
                        const SizedBox(height: 32),
                        // Sign up link
                        _buildSignUpLink(),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMeshBackground() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topLeft,
            radius: 1.5,
            colors: [
              Colors.orange.shade100.withOpacity(0.8),
              Colors.blue.shade50.withOpacity(0.8),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              size: 20,
              color: Colors.grey.shade600,
            ),
            tooltip: 'Go back',
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildTitleSection() {
    return Column(
      children: [
        // Logo container
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.8),
                Colors.white.withOpacity(0.4),
              ],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white.withOpacity(0.6),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.orange.shade200.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              '🍊',
              style: TextStyle(fontSize: 40),
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Welcome to',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
            color: GlassTheme.textPrimary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        const Text(
          'Foodie Express',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
            color: GlassTheme.primary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Sign in to continue your tasty journey',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildForm(SignInState state) {
    return Form(
      child: Column(
        children: [
          // Email field
          _buildEmailField(state),
          const SizedBox(height: 20),
          // Password field
          _buildPasswordField(state),
          const SizedBox(height: 16),
          // Remember me and Forgot password
          _buildRememberMeAndForgotPassword(state),
          const SizedBox(height: 24),
          // Sign In button
          _buildSignInButton(state),
        ],
      ),
    );
  }

  Widget _buildEmailField(SignInState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email Address',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.5),
                Colors.white.withOpacity(0.3),
              ],
            ),
            border: Border.all(
              color: Colors.white.withOpacity(0.6),
            ),
          ),
          child: TextField(
            controller: ref.read(signInNotifierProvider.notifier).emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: 'hello@example.com',
              hintStyle: TextStyle(
                color: Colors.grey.shade400,
              ),
              prefixIcon: Icon(
                Icons.mail_outline,
                size: 20,
                color: Colors.grey.shade500,
              ),
              suffixIcon: state.emailIsValid
                  ? Icon(
                      Icons.check_circle,
                      size: 18,
                      color: Colors.green.shade500,
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
            onChanged: (value) =>
                ref.read(signInNotifierProvider.notifier).setEmail(value),
          ),
        ),
        if (state.emailError != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 4),
            child: Text(
              state.emailError!,
              style: TextStyle(
                fontSize: 12,
                color: Colors.red.shade600,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildPasswordField(SignInState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.5),
                Colors.white.withOpacity(0.3),
              ],
            ),
            border: Border.all(
              color: Colors.white.withOpacity(0.6),
            ),
          ),
          child: TextField(
            controller: ref.read(signInNotifierProvider.notifier).passwordController,
            obscureText: state.obscurePassword,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: '........',
              hintStyle: TextStyle(
                color: Colors.grey.shade400,
              ),
              prefixIcon: Icon(
                Icons.lock_outline,
                size: 20,
                color: Colors.grey.shade500,
              ),
              suffixIcon: IconButton(
                onPressed: ref
                    .read(signInNotifierProvider.notifier)
                    .togglePasswordVisibility,
                icon: Icon(
                  state.obscurePassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                  size: 20,
                  color: Colors.grey.shade500,
                ),
                tooltip: state.obscurePassword ? 'Show password' : 'Hide password',
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
            onChanged: (value) =>
                ref.read(signInNotifierProvider.notifier).setPassword(value),
          ),
        ),
        if (state.passwordError != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 4),
            child: Text(
              state.passwordError!,
              style: TextStyle(
                fontSize: 12,
                color: Colors.red.shade600,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildRememberMeAndForgotPassword(SignInState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Remember me checkbox
        Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(
                value: state.rememberMe,
                onChanged: (value) {
                  ref
                      .read(signInNotifierProvider.notifier)
                      .toggleRememberMe();
                },
                fillColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.selected)) {
                    return GlassTheme.primary;
                  }
                  return Colors.white.withOpacity(0.4);
                }),
                checkColor: Colors.white,
                side: BorderSide(
                  color: Colors.grey.shade400,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Remember me',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
        // Forgot password
        TextButton(
          onPressed: () {
            // TODO: Navigate to forgot password
          },
          child: Text(
            'Forgot Password?',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: GlassTheme.primary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignInButton(SignInState state) {
    return GlassButton(
      onPressed: state.isLoading
          ? null
          : () async {
              final success = await ref
                  .read(signInNotifierProvider.notifier)
                  .signIn();
              if (success && mounted) {
                context.go('/locationPermission');
              }
            },
      label: 'Sign In',
      icon: Icons.arrow_forward,
      height: 56,
      isLoading: state.isLoading,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.transparent,
                  Colors.grey.shade400.withOpacity(0.3),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Or continue with',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
              color: Colors.grey.shade500,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.grey.shade400.withOpacity(0.3),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButtons(SignInState state) {
    return Row(
      children: [
        // Google button
        Expanded(
          child: _buildSocialButton(
            onPressed: state.isLoading
                ? null
                : () async {
                    final success =
                        await ref.read(signInNotifierProvider.notifier).signInWithGoogle();
                    if (success && mounted) {
                      context.go('/locationPermission');
                    }
                  },
            icon: _buildGoogleIcon(),
            label: 'Google',
            isLoading: state.isLoading,
          ),
        ),
        const SizedBox(width: 16),
        // Apple button
        Expanded(
          child: _buildSocialButton(
            onPressed: state.isLoading
                ? null
                : () async {
                    final success =
                        await ref.read(signInNotifierProvider.notifier).signInWithApple();
                    if (success && mounted) {
                      context.go('/locationPermission');
                    }
                  },
            icon: _buildAppleIcon(),
            label: 'Apple',
            isLoading: state.isLoading,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required VoidCallback? onPressed,
    required Widget icon,
    required String label,
    required bool isLoading,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.4),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withOpacity(0.6),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: GlassTheme.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoogleIcon() {
    return SizedBox(
      width: 20,
      height: 20,
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      color: const Color(0xFF4285F4),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: const Color(0xFF34A853),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppleIcon() {
    return Icon(
      Icons.apple,
      size: 22,
      color: Colors.grey.shade800,
    );
  }

  Widget _buildSignUpLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade600,
          ),
        ),
        TextButton(
          onPressed: () {
            // TODO: Navigate to sign up
          },
          child: Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: GlassTheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}

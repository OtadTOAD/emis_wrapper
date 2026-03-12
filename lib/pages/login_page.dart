import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/phone_input_field.dart';
import 'components/otp_input_field.dart';
import '../components/login_button.dart';
import 'services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final AuthService _authService = AuthService();

  bool _otpSent = false;
  bool _isLoading = false;
  String _selectedCountryCode = '+1';
  String? _errorMessage;

  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  final List<Map<String, String>> _countryCodes = [
    {'code': '+1', 'flag': '🇺🇸', 'name': 'US'},
    {'code': '+44', 'flag': '🇬🇧', 'name': 'UK'},
    {'code': '+91', 'flag': '🇮🇳', 'name': 'IN'},
    {'code': '+971', 'flag': '🇦🇪', 'name': 'AE'},
    {'code': '+995', 'flag': '🇬🇪', 'name': 'GE'},
    {'code': '+49', 'flag': '🇩🇪', 'name': 'DE'},
    {'code': '+33', 'flag': '🇫🇷', 'name': 'FR'},
    {'code': '+81', 'flag': '🇯🇵', 'name': 'JP'},
  ];

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _sendOtp() async {
    final phone = '$_selectedCountryCode${_phoneController.text.trim()}';
    if (_phoneController.text.trim().length < 7) {
      setState(() => _errorMessage = 'Enter a valid phone number');
      return;
    }
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final success = await _authService.sendOtp(phone);

    setState(() {
      _isLoading = false;
    });
    if (success) {
      setState(() {
        _otpSent = true;
      });
      _animController.reset();
      _animController.forward();
    } else {
      setState(() => _errorMessage = 'Failed to send OTP. Try again.');
    }
  }

  Future<void> _verifyOtp() async {
    if (_otpController.text.trim().length < 4) {
      setState(() => _errorMessage = 'Enter the OTP sent to your phone');
      return;
    }
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final phone = '$_selectedCountryCode${_phoneController.text.trim()}';
    final success = await _authService.verifyOtp(
      phone,
      _otpController.text.trim(),
    );

    setState(() {
      _isLoading = false;
    });
    if (success) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login successful! 🎉'),
            backgroundColor: Color(0xFF22C55E),
          ),
        );
        // Navigator.pushReplacementNamed(context, '/home');
      }
    } else {
      setState(() => _errorMessage = 'Invalid OTP. Please try again.');
    }
  }

  void _goBack() {
    setState(() {
      _otpSent = false;
      _otpController.clear();
      _errorMessage = null;
    });
    _animController.reset();
    _animController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F14),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.06),

              // Logo / Brand mark
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Icon(
                  Icons.lock_rounded,
                  color: Colors.white,
                  size: 26,
                ),
              ),

              const SizedBox(height: 32),

              FadeTransition(
                opacity: _fadeAnim,
                child: SlideTransition(
                  position: _slideAnim,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _otpSent ? 'Verify your\nnumber' : 'Welcome\nback',
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          height: 1.15,
                          letterSpacing: -1,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _otpSent
                            ? 'Enter the 6-digit code sent to\n$_selectedCountryCode ${_phoneController.text}'
                            : 'Sign in with your phone number\nto continue',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white.withOpacity(0.5),
                          height: 1.6,
                        ),
                      ),

                      const SizedBox(height: 44),

                      if (!_otpSent) ...[
                        // Country code + phone input
                        PhoneInputField(
                          controller: _phoneController,
                          selectedCountryCode: _selectedCountryCode,
                          countryCodes: _countryCodes,
                          onCountryCodeChanged: (val) =>
                              setState(() => _selectedCountryCode = val),
                        ),
                      ] else ...[
                        // OTP input
                        OtpInputField(controller: _otpController),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: _sendOtp,
                          child: Text(
                            'Resend code',
                            style: TextStyle(
                              color: const Color(0xFF6366F1),
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],

                      // Error message
                      if (_errorMessage != null) ...[
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            const Icon(
                              Icons.error_outline_rounded,
                              color: Color(0xFFEF4444),
                              size: 16,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              _errorMessage!,
                              style: const TextStyle(
                                color: Color(0xFFEF4444),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],

                      const SizedBox(height: 32),

                      LoginButton(
                        label: _otpSent ? 'Verify & Sign In' : 'Send OTP',
                        isLoading: _isLoading,
                        onPressed: _otpSent ? _verifyOtp : _sendOtp,
                      ),

                      if (_otpSent) ...[
                        const SizedBox(height: 16),
                        Center(
                          child: TextButton.icon(
                            onPressed: _goBack,
                            icon: const Icon(
                              Icons.arrow_back_rounded,
                              size: 16,
                              color: Color(0xFF9CA3AF),
                            ),
                            label: const Text(
                              'Change number',
                              style: TextStyle(
                                color: Color(0xFF9CA3AF),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],

                      const SizedBox(height: 40),

                      // Terms
                      Center(
                        child: Text(
                          'By continuing, you agree to our Terms of Service\nand Privacy Policy',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.3),
                            height: 1.6,
                          ),
                        ),
                      ),
                    ],
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

/// AuthService handles phone-based OTP authentication.
/// Replace the mock logic below with your real provider
/// (Firebase, Twilio Verify, Supabase, etc.)

class AuthService {
  // Store verification ID if using Firebase
  String? _verificationId;

  /// Sends an OTP to [phoneNumber] (e.g. "+11234567890").
  /// Returns true if the request was successful.
  Future<bool> sendOtp(String phoneNumber) async {
    try {
      // ── Firebase example ──────────────────────────────────────────
      // await FirebaseAuth.instance.verifyPhoneNumber(
      //   phoneNumber: phoneNumber,
      //   verificationCompleted: (PhoneAuthCredential cred) async {
      //     await FirebaseAuth.instance.signInWithCredential(cred);
      //   },
      //   verificationFailed: (FirebaseAuthException e) {
      //     throw Exception(e.message);
      //   },
      //   codeSent: (String vId, int? resendToken) {
      //     _verificationId = vId;
      //   },
      //   codeAutoRetrievalTimeout: (String vId) {
      //     _verificationId = vId;
      //   },
      // );
      // return true;

      // ── Mock (remove in production) ───────────────────────────────
      await Future.delayed(const Duration(seconds: 1));
      _verificationId = 'mock_verification_id';
      print('[AuthService] OTP sent to $phoneNumber');
      return true;
    } catch (e) {
      print('[AuthService] sendOtp error: $e');
      return false;
    }
  }

  /// Verifies the [otp] entered by the user for [phoneNumber].
  /// Returns true if verification succeeds.
  Future<bool> verifyOtp(String phoneNumber, String otp) async {
    try {
      if (_verificationId == null) return false;

      // ── Firebase example ──────────────────────────────────────────
      // final credential = PhoneAuthProvider.credential(
      //   verificationId: _verificationId!,
      //   smsCode: otp,
      // );
      // await FirebaseAuth.instance.signInWithCredential(credential);
      // return true;

      // ── Mock: accepts "123456" as the valid OTP ───────────────────
      await Future.delayed(const Duration(seconds: 1));
      final isValid = otp == '123456';
      print('[AuthService] OTP verified: $isValid');
      return isValid;
    } catch (e) {
      print('[AuthService] verifyOtp error: $e');
      return false;
    }
  }

  /// Signs the current user out.
  Future<void> signOut() async {
    // await FirebaseAuth.instance.signOut();
    _verificationId = null;
  }
}

class AuthService {
  // Simulate user authentication
  static Future<AuthResult> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));

    // Simulate authentication logic
    if (email == "test@example.com" && password == "Test123") {
      return AuthResult(success: true, message: "Login successful");
    } else {
      return AuthResult(success: false, message: "Invalid email or password");
    }
  }

  // Simulate user registration
  static Future<AuthResult> register(String email, String password) async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));

    // Simulate checking for existing user
    if (email == "test@example.com") {
      return AuthResult(
        success: false,
        message: "An account with this email already exists",
      );
    }

    // Simulate successful registration
    if (email.isNotEmpty && password.isNotEmpty) {
      return AuthResult(
        success: true,
        message: "Registration successful! Please verify your email.",
      );
    } else {
      return AuthResult(
        success: false,
        message: "Registration failed. Please check your information.",
      );
    }
  }

  // Password reset
  static Future<AuthResult> resetPassword(String email) async {
    await Future.delayed(Duration(seconds: 1));

    if (email.isNotEmpty) {
      return AuthResult(success: true, message: "Password reset email sent");
    } else {
      return AuthResult(success: false, message: "Invalid email address");
    }
  }
}

class AuthResult {
  final bool success;
  final String message;
  final String? token;

  AuthResult({required this.success, required this.message, this.token});
}

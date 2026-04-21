class EndPoints {
  EndPoints._();

  static const String baseUrl =
      "https://exam.elevateegy.com/api/v1"; // Corrected base URL

  static const String forgetPassword = "$baseUrl/auth/forgotPassword";
  static const String verifyResetCode = "$baseUrl/auth/verifyResetCode";
  static const String resetPassword = "$baseUrl/auth/resetPassword";
}

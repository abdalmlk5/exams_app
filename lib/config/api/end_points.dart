class EndPoints {
  EndPoints._();

  static const String baseUrl =
      "https://exam.elevateegy.com/api/v1"; // Corrected base URL

  static const String forgetPassword = "/auth/forgotPassword";
  static const String verifyResetCode = "/auth/verifyResetCode";
  static const String resetPassword = "/auth/resetPassword";
}

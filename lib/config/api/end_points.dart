class EndPoints {
  EndPoints._();

  // Base URL:
  static const String baseUrl = "https://exam.elevateegy.com/api/v1";

  // API EndPoints:
  static const String signin = "$baseUrl/auth/signin";

  static const String register = "$baseUrl/auth/signup";

  static const String logout = "$baseUrl/auth/logout";

  static const String profileData = "$baseUrl/auth/profileData";
}

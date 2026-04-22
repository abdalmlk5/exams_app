sealed class ForgetPasswordIntent {
  const ForgetPasswordIntent();
}

class ForgetPasswordSendEmailIntent extends ForgetPasswordIntent {
  final String email;
  const ForgetPasswordSendEmailIntent(this.email);
}

class ForgetPasswordVerifyCodeIntent extends ForgetPasswordIntent {
  final String code;
  const ForgetPasswordVerifyCodeIntent(this.code);
}

class ForgetPasswordResetPasswordIntent extends ForgetPasswordIntent {
  final String password;
  const ForgetPasswordResetPasswordIntent(this.password);
}

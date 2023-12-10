class ChangePasswordModel {
  final String email;
  final String password;
  final String newPassword;
  final String confirmationNewPassword;

  ChangePasswordModel({
    required this.email,
    required this.password,
    required this.newPassword,
    required this.confirmationNewPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'newPassword': newPassword,
      'confirmationNewPassword': confirmationNewPassword,
    };
  }
}

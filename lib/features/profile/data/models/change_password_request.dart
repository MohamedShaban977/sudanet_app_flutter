class ChangePasswordRequest {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  ChangePasswordRequest({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() => {
        "CurrentPassword": currentPassword,
        "NewPassword": newPassword,
        "ConfirmPassword": confirmPassword,
      };
}

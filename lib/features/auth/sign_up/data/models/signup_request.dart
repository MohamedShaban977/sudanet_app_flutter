class SignUpRequest {
  String username;
  String email;
  String password;
  String parentPhone;
  String phoneNumber;

  SignUpRequest({
    required this.username,
    required this.password,
    required this.email,
    required this.parentPhone,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() => {
        "name": username,
        "email": email,
        "password": password,
        "parentPhone": parentPhone,
        "phoneNumber": phoneNumber,
      };
}

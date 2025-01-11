class LoginRequest {
  LoginRequest({
    required this.email,
    required this.password,
    required this.macAddress,
  });

  String email;
  String password;
  String? macAddress;

  Map<String, dynamic> toJson() => {
        "Email": email,
        "Password": password,
        "MacAddress": macAddress,
      };
}

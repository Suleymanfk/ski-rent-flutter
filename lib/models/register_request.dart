class RegisterRequest {
  final String username;
  final String surname;
  final String email;
  final String password;

  RegisterRequest({
    required this.username,
    required this.surname,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'username': username,
    'surname': surname,
    'email': email,
    'password': password,
  };
}

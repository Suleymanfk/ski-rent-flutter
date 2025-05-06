class User {
  final int id;
  final String username;
  final String surname;
  final String email;

  User({
    required this.id,
    required this.username,
    required this.surname,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['userId'] ?? 0,
      username: json['username'] ?? '',
      surname: json['surname'] ?? '',
      email: json['email'] ?? '',
    );
  }
}

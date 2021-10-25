class User {
  User({
    required this.email,
    required this.username,
    required this.name,
    required this.password,
    required this.passwordConfirmation,
    required this.role,
  });

  final String email;
  final String username;
  final String name;
  final String password;
  final String passwordConfirmation;
  final String role;

  factory User.fromMap(Map<String, dynamic> json) => User(
      email: json["email"],
      username: json["username"],
      name: json["name"],
      password: json["password"],
      passwordConfirmation: json["passwordConfirmation"],
      role: json["role"]);

  Map<String, dynamic> toMap() => {
        "email": email,
        "username": username,
        "name": name,
        "password": password,
        "passwordConfirmation": passwordConfirmation,
        "role": role,
      };
}

class UserAccount {
  final int? id;
  final String email;
  final String username;
  final String password;

  UserAccount({this.id, required this.email, required this.username, required this.password});

  factory UserAccount.fromJson(Map<String, dynamic> json) {
    return UserAccount(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'password': password,
    };
  }
}

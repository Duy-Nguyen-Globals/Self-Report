class User {
  String email;
  String password;
  String id;
  String username;
  String role;
  String token;

  User({this.email, this.username});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      username: json['username']
    );
  }
}
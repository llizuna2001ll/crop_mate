class User {
  final String username;
  final String email;
  final String address;
  final String contactNumber;

  User({
    required this.username,
    required this.email,
    required this.address,
    required this.contactNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'] as String,
      email: json['email'] as String,
      address: json['address'] as String,
      contactNumber: json['contactNumber'] as String,
    );
  }
}

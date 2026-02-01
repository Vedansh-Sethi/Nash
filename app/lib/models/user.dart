class User {
  final String id;
  final String username;
  final String email;
  final String? refferalCode;
  int? balance;

  User({
    required this.id,
    required this.username,
    required this.email,
    this.balance,
    this.refferalCode,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    username: json['username'],
    email: json['email'],
    balance: json['wallet_balance'] != null
        ? int.parse(json['wallet_balance'])
        : null,
  );

  User copyWith({String? username, String? email, int? balance}) {
    return User(
      id: id,
      username: username ?? this.username,
      email: email ?? this.email,
      balance: balance ?? this.balance,
    );
  }
}

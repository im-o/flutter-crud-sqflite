class User {
  final int? id;
  final String name;

  User({this.id, required this.name});

  factory User.fromMap(Map<String, dynamic> json) => new User(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}

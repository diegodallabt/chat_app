class UserDto {
  UserDto({this.createdAt, this.name, this.email, this.password});

  final DateTime? createdAt;
  final String? name;
  final String? email;
  final String? password;

  factory UserDto.fromMap(Map<String, dynamic> map) => UserDto(
        createdAt: map['createdAt'],
        name: map['name'],
        email: map['email'],
        password: map['password'],
      );

  Map<String, dynamic> toMap() => {
        "createdAt": createdAt,
        "name": name,
        "email": email,
        "password": password,
      };
}

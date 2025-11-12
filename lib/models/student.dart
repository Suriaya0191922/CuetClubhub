class Student {
  final int? id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String password;
  final String address;
  final String year;

  Student({
    this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.password,
    required this.address,
    required this.year,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'phone': phone,
      'password': password,
      'address': address,
      'year': year,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'],
      username: map['username'],
      email: map['email'],
      phone: map['phone'],
      password: map['password'],
      address: map['address'],
      year: map['year'],
    );
  }
}

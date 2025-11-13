class Student {
  int? studentId;
  String name;
  String email;
  String password; // ✅ add this
  String? year;
  String? deptName;
  String? fieldOfInterest;
  String? clubsJoined;
  String? contactInfo;

  Student({
    this.studentId,
    required this.name,
    required this.email,
    required this.password, // ✅ add this
    this.year,
    this.deptName,
    this.fieldOfInterest,
    this.clubsJoined,
    this.contactInfo,
  });

  Map<String, dynamic> toMap() {
    return {
      'student_id': studentId,
      'name': name,
      'email': email,
      'password': password, // ✅ add this
      'year': year,
      'dept_name': deptName,
      'field_of_interest': fieldOfInterest,
      'clubs_joined': clubsJoined,
      'contact_info': contactInfo,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      studentId: map['student_id'],
      name: map['name'],
      email: map['email'],
      password: map['password'], // ✅ add this
      year: map['year'],
      deptName: map['dept_name'],
      fieldOfInterest: map['field_of_interest'],
      clubsJoined: map['clubs_joined'],
      contactInfo: map['contact_info'],
    );
  }
}

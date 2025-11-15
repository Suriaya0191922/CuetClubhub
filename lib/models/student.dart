import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  String? studentId; // Changed to String for Firebase UID
  String name;
  String email;
  String password; // Note: Don't store passwords in Firestore in production
  String? year;
  String? deptName;
  String? fieldOfInterest;
  String? clubsJoined;
  String? contactInfo;

  Student({
    this.studentId,
    required this.name,
    required this.email,
    required this.password,
    this.year,
    this.deptName,
    this.fieldOfInterest,
    this.clubsJoined,
    this.contactInfo,
  });

  // Convert Student to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'year': year,
      'dept_name': deptName,
      'field_of_interest': fieldOfInterest,
      'clubs_joined': clubsJoined,
      'contact_info': contactInfo,
      'created_at': FieldValue.serverTimestamp(),
    };
  }

  // Create Student from Firestore document
  factory Student.fromMap(Map<String, dynamic> map, String id) {
    return Student(
      studentId: id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: '', // Don't retrieve password from Firestore
      year: map['year'],
      deptName: map['dept_name'],
      fieldOfInterest: map['field_of_interest'],
      clubsJoined: map['clubs_joined'],
      contactInfo: map['contact_info'],
    );
  }

  // Create Student from Firestore DocumentSnapshot
  factory Student.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Student.fromMap(data, doc.id);
  }
}
class EventModel {
  final String id;
  final String title;
  final String club;
  final String posterUrl;
  final String shortDescription;
  final String description;
  final DateTime dateTime;
  final String location;
  bool isRegistered;
  bool isAttended;
  double rating;
  String feedback;

  EventModel({
    required this.id,
    required this.title,
    required this.club,
    required this.posterUrl,
    required this.shortDescription,
    required this.description,
    required this.dateTime,
    required this.location,
    this.isRegistered = false,
    this.isAttended = false,
    this.rating = 0.0,
    this.feedback = '',
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
    id: json['id'],
    title: json['title'],
    club: json['club'],
    posterUrl: json['posterUrl'],
    shortDescription: json['shortDescription'],
    description: json['description'],
    dateTime: DateTime.parse('${json['date']}T${json['time']}'),
    location: json['location'],
    isRegistered: json['isRegistered'] ?? false,
    isAttended: json['isAttended'] ?? false,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'club': club,
    'posterUrl': posterUrl,
    'shortDescription': shortDescription,
    'description': description,
    'dateTime': dateTime.toIso8601String(),
    'location': location,
    'isRegistered': isRegistered,
    'isAttended': isAttended,
    'rating': rating,
    'feedback': feedback,
  };
}

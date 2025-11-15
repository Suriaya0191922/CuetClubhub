import 'package:clubhub/models/event_model.dart';

final List<Map<String, dynamic>> _sample = [
  {
    "id": "e1",
    "title": "Hackathon",
    "club": "Computer  Club",
    "posterUrl": "assets/posters/hackathon1.jpg",
    "shortDescription": /*"24-hour coding challenge with prizes."*/"A fast-paced coding challenge where innovators collaborate to build creative tech solutions.",
    "description": /*"Full description, rules, prizes, schedule, contact."*/"Join teams of developers, designers, and thinkers for an intense sprint of creativity and problem-solving. Build, test, and showcase your project in just 24 hours.",
    "date": "2026-02-15",
    "time": "09:00:00",
    "location": "CSE Building",
    "isRegistered": false,
    "isAttended": false
  },
  {
    "id": "e2",
    "title": "Photography Walk",
    "club": "Cuet Photography Society",
    "posterUrl": "assets/posters/photography.jpg",
    "shortDescription": "A guided walk inviting participants to explore and capture stunning scenes through their lenses.",
    "description": "Discover hidden visual stories as you stroll through scenic spots with fellow photography enthusiasts. Learn tips, share ideas, and capture moments that inspire.",
    "date": "2025-12-01",
    "time": "15:00:00",
    "location": "Campus East",
    "isRegistered": true,
    "isAttended": false
  },
  {
    "id": "e3",
    "title": "Space Night",
    "club": "ASSRO",
    "posterUrl": "assets/posters/assro.jpg",
    "shortDescription": "A thrilling competition focused on space-themed problem-solving and innovation",
    "description": "Dive into the wonders of space by designing creative solutions to real-world cosmic challenges. Perfect for budding scientists, engineers, and explorers.",
    "date": "2025-11-01",
    "time": "18:00:00",
    "location": "EEE Building",
    "isRegistered": true,
    "isAttended": true
  },
  {
    "id": "e4",
    "title": "Freshar's League 2025",
    "club": "Cuet Debating Society",
    "posterUrl": "assets/posters/ds.jpg",
    "shortDescription": "An engaging session where participants exchange ideas and sharpen their speaking skills.",
    "description": "Join fellow students in lively discussions on current topics while building confidence and critical thinking. Whether you're new or experienced, every voice matters.",
    "date": "2025-10-10",
    "time": "17:00:00",
    "location": "West Gallery",
    "isRegistered": false,
    "isAttended": true
  },
  {
    "id": "e5",
    "title": "Entrepreneurship Talk",
    "club": "Cuet Career Club",
    "posterUrl": "assets/posters/ent.jpg",
    "shortDescription": "A hands-on workshop to help aspiring entrepreneurs turn ideas into impactful startups.",
    "description": "Learn from experts about ideation, pitching, and building a sustainable business model. Get practical guidance to kickstart your entrepreneurial journey.",
    "date": "2026-03-01",
    "time": "10:00:00",
    "location": "Cuet Incubator",
    "isRegistered": false,
    "isAttended": false
  },
  {
    "id": "e6",
    "title": "Heem Utshob",
    "club": "Joyoddhoney,Cuet",
    "posterUrl": "assets/posters/jd1.jpg",
    "shortDescription": "A festive celebration filled with lights, music, and seasonal joy for everyone.",
    "description": "Enjoy a cozy evening of winter-themed activities, treats, and entertainment. Bring friends and family to celebrate the magic of the season together.",
    "date": "2025-09-05",
    "time": "19:30:00",
    "location": "Basketball Ground",
    "isRegistered": true,
    "isAttended": true
  }
];

class MockRepository {
  Future<List<EventModel>> fetchEvents() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return _sample.map((e) => EventModel.fromJson(e)).toList();
  }
}

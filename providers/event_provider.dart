import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clubhub/models/event_model.dart';
import 'package:clubhub/services/mock_repository.dart';

final repositoryProvider = Provider((ref) => MockRepository());

final eventsProvider = StateNotifierProvider<EventsNotifier, List<EventModel>>(
      (ref) => EventsNotifier(ref.read(repositoryProvider)),
);

class EventsNotifier extends StateNotifier<List<EventModel>> {
  void updateEvent(EventModel updatedEvent) {
    state = [
      for (final e in state)
        if (e.id == updatedEvent.id) updatedEvent else e,
    ];
  }

  final MockRepository repo;
  EventsNotifier(this.repo) : super([]) {
    load();
  }

  Future<void> load() async {
    final events = await repo.fetchEvents();
    state = events;
  }

  void register(String id) {
    state = state.map((e) {
      if (e.id == id) e.isRegistered = true;
      return e;
    }).toList();
  }

  void submitFeedback(String id, double rating, String feedback) {
    state = state.map((e) {
      if (e.id == id) {
        e.rating = rating;
        e.feedback = feedback;
        e.isAttended = true;
      }
      return e;
    }).toList();
  }
}

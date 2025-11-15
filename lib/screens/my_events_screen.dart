/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clubhub/providers/event_provider.dart';
import 'package:clubhub/widgets/event_card.dart';
import 'package:clubhub/models/event_model.dart';
import 'package:clubhub/constants/colors.dart';
import 'package:clubhub/widgets/background_container.dart';
import 'package:clubhub/widgets/gradient_app_bar.dart';
import 'package:clubhub/widgets/custom_bottom_navbar.dart';


class MyEventsScreen extends ConsumerStatefulWidget {
  const MyEventsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MyEventsScreen> createState() => _MyEventsScreenState();
}

class _MyEventsScreenState extends ConsumerState<MyEventsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final events = ref.watch(eventsProvider);
    final upcoming = events
        .where((e) => e.isRegistered && e.dateTime.isAfter(DateTime.now()))
        .toList();
    final completed = events
        .where((e) =>
    e.isAttended || (e.isRegistered && e.dateTime.isBefore(DateTime.now())))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Events'),
        flexibleSpace: const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF14213D), Color(0xFF1E3A8A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: BackgroundContainer(
        child: Column(
          children: [
            Material(
              color: Colors.transparent,
              child: TabBar(
                controller: _tabController,
                labelColor: AppColors.secondary,
                unselectedLabelColor: Colors.black87,
                tabs: const [
                  Tab(icon: Icon(Icons.calendar_today), text: 'Upcoming'),
                  Tab(icon: Icon(Icons.check_circle), text: 'Completed'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildList(context, upcoming, 'No upcoming registrations'),
                  _buildList(context, completed, 'No completed events'),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
    );
*/
/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clubhub/providers/event_provider.dart';
import 'package:clubhub/models/event_model.dart';
import 'package:clubhub/constants/colors.dart';
import 'package:clubhub/widgets/background_container.dart';
import 'package:clubhub/widgets/custom_bottom_navbar.dart';

class MyEventsScreen extends ConsumerStatefulWidget {
  const MyEventsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MyEventsScreen> createState() => _MyEventsScreenState();
}

class _MyEventsScreenState extends ConsumerState<MyEventsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final events = ref.watch(eventsProvider);
    final upcoming = events
        .where((e) => e.isRegistered && e.dateTime.isAfter(DateTime.now()))
        .toList();
    final completed = events
        .where((e) =>
    e.isAttended ||
        (e.isRegistered && e.dateTime.isBefore(DateTime.now())))
        .toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Events'),
        flexibleSpace: const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF14213D), Color(0xFF1E3A8A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: BackgroundContainer(
        child: Column(
          children: [
            Material(
              color: Colors.transparent,
              child: TabBar(
                controller: _tabController,
                indicatorColor: AppColors.secondary,
                labelColor: AppColors.primary,
                unselectedLabelColor: Colors.black54,
                tabs: const [
                  Tab(icon: Icon(Icons.calendar_today), text: 'Upcoming'),
                  Tab(icon: Icon(Icons.check_circle), text: 'Completed'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildList(context, upcoming, 'No upcoming registrations'),
                  _buildList(context, completed, 'No completed events'),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
    );
  }

  // 🔹 Helper to build event lists for both tabs
  Widget _buildList(
      BuildContext context, List<EventModel> list, String emptyMsg) {
    if (list.isEmpty) {
      return Center(child: Text(emptyMsg, style: GoogleFonts.poppins()));
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 80),
      itemCount: list.length,
      itemBuilder: (context, i) {
        final event = list[i];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
          child: InkWell(
            onTap: () => Navigator.pushNamed(
              context,
              '/event/${completed[i].id}',
              arguments: {'event': completed[i], 'fromCompletedTab': true},
            );

              borderRadius: BorderRadius.circular(16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Poster (smaller to make content visible)
                  Hero(
                    tag: 'poster_${event.id}',
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                      ),
                      child: Image.asset(
                        event.posterUrl,
                        width: 90,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Text details
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.title,
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            event.club,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.black87,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${event.dateTime.day}/${event.dateTime.month}/${event.dateTime.year}',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.primary.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clubhub/providers/event_provider.dart';
import 'package:clubhub/widgets/event_card.dart';
import 'package:clubhub/models/event_model.dart';
import 'package:clubhub/constants/colors.dart';
import 'package:clubhub/widgets/background_container.dart';
import 'package:clubhub/widgets/custom_bottom_navbar.dart';

class MyEventsScreen extends ConsumerStatefulWidget {
  const MyEventsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MyEventsScreen> createState() => _MyEventsScreenState();
}

class _MyEventsScreenState extends ConsumerState<MyEventsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final events = ref.watch(eventsProvider);

    final upcoming = events
        .where((e) => e.isRegistered && e.dateTime.isAfter(DateTime.now()))
        .toList();

    final completed = events
        .where((e) =>
    e.isAttended || (e.isRegistered && e.dateTime.isBefore(DateTime.now())))
        .toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Events'),
        flexibleSpace: const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF14213D), Color(0xFF1E3A8A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      backgroundColor: AppColors.backgroundGray,
      body: BackgroundContainer(
        child: Column(
          children: [
        Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.accentGreen,               // background color behind both tabs
            borderRadius: BorderRadius.circular(10),
          ),
          child: TabBar(
            controller: _tabController,
            indicator: const BoxDecoration(),           // removes underline indicator
            indicatorColor: Colors.transparent,
            labelColor: Colors.white,                   // selected tab text/icon
            unselectedLabelColor: Colors.white70,       // unselected tab text/icon
            labelStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            tabs: const [
              Tab(icon: Icon(Icons.calendar_today), text: 'Upcoming'),
              Tab(icon: Icon(Icons.check_circle), text: 'Completed'),
            ],
          ),
        ),
      ),



            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // 🔵 UPCOMING EVENTS TAB
                  _buildList(
                    context,
                    upcoming,
                    'No upcoming registrations',
                    false,
                  ),

                  // 🟢 COMPLETED EVENTS TAB
                  _buildList(
                    context,
                    completed,
                    'No completed events',
                    true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
    );
  }

  /// 🧱 Reusable list builder for upcoming/completed tabs
  Widget _buildList(
      BuildContext context, List<EventModel> list, String emptyMsg, bool fromCompletedTab) {
    if (list.isEmpty) {
      return Center(
        child: Text(
          emptyMsg,
          style: GoogleFonts.poppins(fontSize: 15),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 70),
      itemCount: list.length,
      itemBuilder: (context, i) {
        final event = list[i];
        return EventCard(
          event: event,
          onTap: () => Navigator.pushNamed(
            context,
            '/event/${event.id}',
            arguments: {'event': event, 'fromCompletedTab': fromCompletedTab},
          ),
        );
      },
    );
  }
}

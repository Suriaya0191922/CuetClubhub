/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clubhub/providers/event_provider.dart';
import 'package:clubhub/widgets/event_card.dart';
import 'package:clubhub/constants/colors.dart';
import 'package:clubhub/models/event_model.dart';
import 'package:clubhub/widgets/background_container.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final events = ref.watch(eventsProvider);
    final filtered = events.where((e) {
      final q = query.toLowerCase();
      return e.title.toLowerCase().contains(q) ||
          e.club.toLowerCase().contains(q) ||
          e.location.toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.backgroundGray,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome to ClubHub',
                      style: GoogleFonts.poppins(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary)),
                  const SizedBox(height: 6),
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.poppins(
                          fontSize: 14, color: Colors.black87),
                      children: [
                        const TextSpan(text: 'your gateway to '),
                        TextSpan(
                            text: 'all campus events',
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColors.secondary)),
                        const TextSpan(text: ' — discover, join, and participate.'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Search bar
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: TextField(
                      onChanged: (v) => setState(() => query = v),
                      decoration: const InputDecoration(
                        icon: Icon(Icons.search),
                        hintText: 'Search events, clubs, locations...',
                        border: InputBorder.none,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: filtered.isEmpty
                  ? Center(
                  child: Text('No events found',
                      style: GoogleFonts.poppins(fontSize: 14)))
                  : ListView.builder(
                padding: const EdgeInsets.only(bottom: 80),
                itemCount: filtered.length,
                itemBuilder: (context, i) {
                  final ev = filtered[i];
                  return EventCard(
                    event: ev,
                    onTap: () => Navigator.pushNamed(
                        context, '/event/${ev.id}',
                        arguments: ev),
                  );
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.black54,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'My Events'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (i) {
          switch (i) {
            case 1:
              Navigator.pushNamed(context, '/myevents');
              break;
            case 2:
              Navigator.pushNamed(context, '/notifications');
              break;
            case 3:
              Navigator.pushNamed(context, '/profile');
              break;
          }
        },
      ),
    );
  }
}
*/
/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clubhub/providers/event_provider.dart';
import 'package:clubhub/widgets/event_card.dart';
import 'package:clubhub/constants/colors.dart';
import 'package:clubhub/models/event_model.dart';
import 'package:clubhub/widgets/background_container.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final events = ref.watch(eventsProvider);
    final filtered = events.where((e) {
      final q = query.toLowerCase();
      return e.title.toLowerCase().contains(q) ||
          e.club.toLowerCase().contains(q) ||
          e.location.toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.backgroundGray,
      appBar: AppBar(
        backgroundColor: const Color(0xFF14213D),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'ClubHub',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome to ClubHub',
                      style: GoogleFonts.poppins(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary)),
                  const SizedBox(height: 6),
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.poppins(
                          fontSize: 14, color: Colors.black87),
                      children: [
                        const TextSpan(text: 'your gateway to '),
                        TextSpan(
                            text: 'all campus events',
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColors.secondary)),
                        const TextSpan(
                            text:
                            ' — discover, join, and participate.'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  // Search bar
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextField(
                      onChanged: (v) => setState(() => query = v),
                      decoration: const InputDecoration(
                        icon: Icon(Icons.search, color: Colors.grey),
                        hintText: 'Search events, clubs, locations...',
                        border: InputBorder.none,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: filtered.isEmpty
                  ? Center(
                  child: Text('No events found',
                      style: GoogleFonts.poppins(fontSize: 14)))
                  : ListView.builder(
                padding: const EdgeInsets.only(bottom: 80),
                itemCount: filtered.length,
                itemBuilder: (context, i) {
                  final ev = filtered[i];
                  return EventCard(
                    event: ev,
                    onTap: () => Navigator.pushNamed(
                        context, '/event/${ev.id}',
                        arguments: ev),
                  );
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.black54,
        type: BottomNavigationBarType.fixed, // 👈 ensures all labels show
        selectedLabelStyle:
        GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12),
        unselectedLabelStyle:
        GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 12),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (i) {
          switch (i) {
            case 1:
              Navigator.pushNamed(context, '/myevents');
              break;
            case 2:
              Navigator.pushNamed(context, '/notifications');
              break;
            case 3:
              Navigator.pushNamed(context, '/profile');
              break;
          }
        },
      ),
    );
  }
}

 */
/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clubhub/providers/event_provider.dart';
import 'package:clubhub/widgets/event_card.dart';
import 'package:clubhub/constants/colors.dart';
import 'package:clubhub/models/event_model.dart';
import 'package:clubhub/widgets/background_container.dart';
import 'package:clubhub/widgets/custom_bottom_navbar.dart';
import 'package:clubhub/widgets/gradient_app_bar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final events = ref.watch(eventsProvider);
    final filtered = events.where((e) {
      final q = query.toLowerCase();
      return e.title.toLowerCase().contains(q) ||
          e.club.toLowerCase().contains(q) ||
          e.location.toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF14213D),
        title: const Text('ClubHub', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: BackgroundContainer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Welcome to ClubHub',
                        style: GoogleFonts.poppins(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary)),
                    const SizedBox(height: 6),
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(
                            fontSize: 14, color: Colors.black87),
                        children: [
                          const TextSpan(text: 'your gateway to '),
                          TextSpan(
                              text: 'all campus events',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.secondary)),
                          const TextSpan(
                              text:
                              ' — discover, join, and participate.'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Search bar
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: TextField(
                        onChanged: (v) => setState(() => query = v),
                        decoration: const InputDecoration(
                          icon: Icon(Icons.search),
                          hintText: 'Search events, clubs, locations...',
                          border: InputBorder.none,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: filtered.isEmpty
                    ? Center(
                    child: Text('No events found',
                        style: GoogleFonts.poppins(fontSize: 14)))
                    : ListView.builder(
                  padding: const EdgeInsets.only(bottom: 80),
                  itemCount: filtered.length,
                  itemBuilder: (context, i) {
                    final ev = filtered[i];
                    return EventCard(
                      event: ev,
                      onTap: () => Navigator.pushNamed(
                        context,
                        '/event/${ev.id}',
                        arguments: ev,
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.black54,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'My Events'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (i) {
          switch (i) {
            case 1:
              Navigator.pushNamed(context, '/myevents');
              break;
            case 2:
              Navigator.pushNamed(context, '/notifications');
              break;
            case 3:
              Navigator.pushNamed(context, '/profile');
              break;
          }
        },
      ),

    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clubhub/providers/event_provider.dart';
import 'package:clubhub/widgets/event_card.dart';
import 'package:clubhub/constants/colors.dart';
import 'package:clubhub/widgets/background_container.dart';
import 'package:clubhub/widgets/custom_bottom_navbar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final events = ref.watch(eventsProvider);
    final filtered = events.where((e) {
      final q = query.toLowerCase();
      return e.title.toLowerCase().contains(q) ||
          e.club.toLowerCase().contains(q) ||
          e.location.toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF14213D),
        //title: const Text('ClubHub', style: TextStyle(color: Colors.white)),
        //centerTitle: true,
      ),
      body: BackgroundContainer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to ClubHub',
                      style: GoogleFonts.poppins(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(
                            fontSize: 14, color: Colors.white),
                        children: const [
                          TextSpan(text: 'Your gateway to '),
                          TextSpan(
                            text: 'all campus events',
                            /*style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,*/
                            ),

                          TextSpan(text: ' — discover, join, and participate.'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // 🔍 Search Bar
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: TextField(
                        onChanged: (v) => setState(() => query = v),
                        decoration: const InputDecoration(
                          icon: Icon(Icons.search),
                          hintText: 'Search events, clubs, locations...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              // 🗓 Event List
              Expanded(
                child: filtered.isEmpty
                    ? Center(
                  child: Text(
                    'No events found',
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                )
                    : ListView.builder(
                  padding: const EdgeInsets.only(bottom: 80),
                  itemCount: filtered.length,
                  itemBuilder: (context, i) {
                    final ev = filtered[i];
                    return EventCard(
                      event: ev,
                      onTap: () =>Navigator.pushNamed(
                        context,
                        '/event/${ev.id}',
                        arguments: {'event': ev, 'fromCompletedTab': false},
                      )

                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      // ✅ Use same consistent bottom nav bar
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }
}

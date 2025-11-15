/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clubhub/models/event_model.dart';
import 'package:clubhub/providers/event_provider.dart';
import 'package:clubhub/constants/colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class EventDetailScreen extends ConsumerWidget {
  final EventModel event;
  const EventDetailScreen({required this.event, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsNotifier = ref.read(eventsProvider.notifier);
    final isRegistered = event.isRegistered;

    return Scaffold(
      backgroundColor: AppColors.backgroundGray,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.primary),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'poster_${event.id}',
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: event.posterUrl.startsWith('http')
                    ? CachedNetworkImage(
                    imageUrl: event.posterUrl, fit: BoxFit.cover)
                    : Image.asset(event.posterUrl, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event.title,
                      style: GoogleFonts.poppins(
                          fontSize: 20, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 6),
                  Text('${event.club} • ${event.location}',
                      style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 12),
                  Text('${event.dateTime.toLocal()}'.split('.').first,
                      style: GoogleFonts.poppins()),
                  const SizedBox(height: 12),
                  Text(event.description, style: GoogleFonts.poppins()),
                  const SizedBox(height: 20),
                  if (!isRegistered)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          eventsNotifier.register(event.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Registered')));
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text('Register Now',
                            style: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                      ),
                    )
                  else
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.accentGreen,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text('Registered',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600)),
                    ),
                  const SizedBox(height: 20),
                  if (event.isAttended) ...[
                    Text('Your Rating',
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    RatingBarIndicator(
                        rating: event.rating,
                        itemBuilder: (c, _) =>
                        const Icon(Icons.star, color: Colors.amber),
                        itemCount: 5,
                        itemSize: 28.0),
                    if (event.feedback.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text('Your feedback:',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 6),
                      Text(event.feedback, style: GoogleFonts.poppins()),
                    ]
                  ]
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
*/
/*import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/event_model.dart';
import '../providers/event_provider.dart';
import '../constants/colors.dart';
import '../widgets/custom_bottom_navbar.dart'; // ✅ correct file name
 // ✅ your bottom navbar file

class EventDetailScreen extends ConsumerStatefulWidget {
  final EventModel event;
  const EventDetailScreen({Key? key, required this.event}) : super(key: key);

  @override
  ConsumerState<EventDetailScreen> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends ConsumerState<EventDetailScreen> {
  double _rating = 0;
  final TextEditingController _feedbackController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _rating = widget.event.rating;
    _feedbackController.text = widget.event.feedback;
  }

  @override
  Widget build(BuildContext context) {
    final event = widget.event;
    final bool isCompleted =
        event.isAttended || event.dateTime.isBefore(DateTime.now());

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          event.title,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF14213D), Color(0xFF1E3A8A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1), // ✅
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🎞 Poster
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Hero(
                tag: 'poster_${event.id}',
                child: event.posterUrl.startsWith('http')
                    ? Image.network(
                  event.posterUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 220,
                )
                    : Image.asset(
                  event.posterUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 220,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 📝 Title & Club
            Text(
              event.title,
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              event.club,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),

            // 📅 Date & Location
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  '${event.dateTime.day}/${event.dateTime.month}/${event.dateTime.year}',
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.location_on, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Text(event.location, style: GoogleFonts.poppins(fontSize: 14)),
              ],
            ),
            const SizedBox(height: 20),

            // 📖 Description
            Text(
              event.description,
              style: GoogleFonts.poppins(fontSize: 15, height: 1.5),
            ),

            const SizedBox(height: 30),

            // ⭐ Feedback section (only for completed events)
            if (isCompleted) _buildFeedbackSection(context, event),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedbackSection(BuildContext context, EventModel event) {
    return Card(
      color: Colors.grey[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 1.5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rate this Event',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),

            // ⭐ Star Rating
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(5, (i) {
                return IconButton(
                  onPressed: () {
                    setState(() {
                      _rating = i + 1.0;
                    });
                  },
                  icon: Icon(
                    Icons.star_rounded,
                    color: i < _rating ? Colors.amber : Colors.grey[400],
                    size: 32,
                  ),
                );
              }),
            ),

            const SizedBox(height: 10),

            // 💬 Feedback text field
            TextField(
              controller: _feedbackController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Share your feedback...',
                hintStyle: GoogleFonts.poppins(color: Colors.grey[600]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),

            const SizedBox(height: 12),

            // 🚀 Submit Button
            ElevatedButton(
              onPressed: () {
                final updatedEvent = event
                  ..rating = _rating
                  ..feedback = _feedbackController.text;

                ref.read(eventsProvider.notifier).updateEvent(updatedEvent);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('✅ Feedback submitted successfully!'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size(double.infinity, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Submit Feedback',
                style: GoogleFonts.poppins(
                    color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/

/*import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/event_model.dart';
import '../providers/event_provider.dart';
import '../constants/colors.dart';
import '../widgets/custom_bottom_navbar.dart';

class EventDetailScreen extends ConsumerStatefulWidget {
  final EventModel event;
  const EventDetailScreen({Key? key, required this.event}) : super(key: key);

  @override
  ConsumerState<EventDetailScreen> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends ConsumerState<EventDetailScreen> {
  double _rating = 0;
  final TextEditingController _feedbackController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _rating = widget.event.rating;
    _feedbackController.text = widget.event.feedback;
  }

  @override
  Widget build(BuildContext context) {
    final event = widget.event;
    final events = ref.watch(eventsProvider);
    final current =
    events.firstWhere((e) => e.id == event.id, orElse: () => event);

    final bool isCompleted =
        current.isAttended || current.dateTime.isBefore(DateTime.now());
    final bool isRegistered = current.isRegistered;

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          current.title,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF14213D), Color(0xFF1E3A8A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🎞 Poster with gradient background
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF14213D), // dark navy tone
                      Color(0xFF1E3A8A), // royal blue
                      Color(0xFFFCA311), // soft amber glow
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Hero(
                    tag: 'poster_${current.id}',
                    child: AspectRatio(
                      aspectRatio: 16 / 9, // ✅ keeps perfect fit across devices
                      child: current.posterUrl.startsWith('http')
                          ? Image.network(
                        current.posterUrl,
                        fit: BoxFit.contain, // ✅ shows full poster
                        width: double.infinity,
                      )
                          : Image.asset(
                        current.posterUrl,
                        fit: BoxFit.contain,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),



            // 📝 Title & Club
            Text(
              current.title,
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              current.club,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),

            // 📅 Date & Location
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  '${current.dateTime.day}/${current.dateTime.month}/${current.dateTime.year}',
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.location_on, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Text(current.location,
                    style: GoogleFonts.poppins(fontSize: 14)),
              ],
            ),
            const SizedBox(height: 20),

            // 📖 Description
            Text(
              current.description,
              style: GoogleFonts.poppins(fontSize: 15, height: 1.5),
            ),
            const SizedBox(height: 30),

            // 🟢 Register button (if event not yet registered)
            if (!isCompleted)
              Center(
                child: ElevatedButton(
                  onPressed: isRegistered
                      ? null
                      : () {
                    ref
                        .read(eventsProvider.notifier)
                        .register(current.id);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '✅ Registered for ${current.title}!',
                          style: GoogleFonts.poppins(),
                        ),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isRegistered
                        ? Colors.grey[400]
                        : AppColors.primary,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    isRegistered ? 'Registered' : 'Register Now',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 30),

            // ⭐ Feedback section (only for completed events)
            if (isCompleted) _buildFeedbackSection(context, current),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedbackSection(BuildContext context, EventModel event) {
    return Card(
      color: Colors.grey[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 1.5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rate this Event',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),

            // ⭐ Star Rating
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(5, (i) {
                return IconButton(
                  onPressed: () {
                    setState(() {
                      _rating = i + 1.0;
                    });
                  },
                  icon: Icon(
                    Icons.star_rounded,
                    color: i < _rating ? Colors.amber : Colors.grey[400],
                    size: 32,
                  ),
                );
              }),
            ),

            const SizedBox(height: 10),

            // 💬 Feedback text field
            TextField(
              controller: _feedbackController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Share your feedback...',
                hintStyle: GoogleFonts.poppins(color: Colors.grey[600]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),

            const SizedBox(height: 12),

            // 🚀 Submit Button
            ElevatedButton(
              onPressed: () {
                final updatedEvent = event
                  ..rating = _rating
                  ..feedback = _feedbackController.text;

                ref.read(eventsProvider.notifier).updateEvent(updatedEvent);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('✅ Feedback submitted successfully!'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size(double.infinity, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Submit Feedback',
                style: GoogleFonts.poppins(
                    color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
/*import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:palette_generator/palette_generator.dart';
import '../models/event_model.dart';
import '../providers/event_provider.dart';
import '../constants/colors.dart';
import '../widgets/custom_bottom_navbar.dart';
import 'dart:ui';

class EventDetailScreen extends ConsumerStatefulWidget {
  final EventModel event;
  final bool fromCompletedTab;

  const EventDetailScreen({
    Key? key,
    required this.event,
    this.fromCompletedTab = false,
  }) : super(key: key);

  @override
  ConsumerState<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends ConsumerState<EventDetailScreen> {
  double _rating = 0;
  final TextEditingController _feedbackController = TextEditingController();
  PaletteGenerator? _palette;

  @override
  void initState() {
    super.initState();
    _rating = widget.event.rating;
    _feedbackController.text = widget.event.feedback;
    _generatePalette();
  }

  Future<void> _generatePalette() async {
    final generator = await PaletteGenerator.fromImageProvider(
      widget.event.posterUrl.startsWith('http')
          ? NetworkImage(widget.event.posterUrl)
          : AssetImage(widget.event.posterUrl) as ImageProvider,
      size: const Size(200, 150),
    );
    setState(() => _palette = generator);
  }

  @override
  Widget build(BuildContext context) {
    final events = ref.watch(eventsProvider);
    final current = events.firstWhere(
          (e) => e.id == widget.event.id,
      orElse: () => widget.event,
    );

    final bool isCompleted =
        current.isAttended || current.dateTime.isBefore(DateTime.now());
    final bool isRegistered = current.isRegistered;

    final Color startColor =
        _palette?.dominantColor?.color ?? const Color(0xFF14213D);
    final Color endColor =
        _palette?.vibrantColor?.color ?? const Color(0xFFFCA311);

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          current.title,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [startColor, endColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🎨 Poster with matching gradient
           /* Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [startColor, endColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Hero(
                    tag: 'poster_${current.id}',
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: current.posterUrl.startsWith('http')
                          ? Image.network(
                        current.posterUrl,
                        fit: BoxFit.contain,
                        width: double.infinity,
                      )
                          : Image.asset(
                        current.posterUrl,
                        fit: BoxFit.contain,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),*/
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Background poster (full width, height adjusts automatically)
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Opacity(
                        opacity: 0.3, // dim background
                        child: widget.event.posterUrl.startsWith('http')
                            ? Image.network(
                          widget.event.posterUrl,
                          fit: BoxFit.cover, // fills container without distortion
                        )
                            : Image.asset(
                          widget.event.posterUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  // Foreground sharp poster (16:9)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Hero(
                      tag: 'poster_${widget.event.id}',
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: widget.event.posterUrl.startsWith('http')
                            ? Image.network(
                          widget.event.posterUrl,
                          fit: BoxFit.contain,
                        )
                            : Image.asset(
                          widget.event.posterUrl,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 📝 Title & Club
            Text(
              current.title,
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              current.club,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),

            // 📅 Date & Location
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  '${current.dateTime.day}/${current.dateTime.month}/${current.dateTime.year}',
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.location_on, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Text(current.location,
                    style: GoogleFonts.poppins(fontSize: 14)),
              ],
            ),
            const SizedBox(height: 20),

            // 📖 Description
            Text(
              current.description,
              style: GoogleFonts.poppins(fontSize: 15, height: 1.5),
            ),
            const SizedBox(height: 30),

            // 🟡 Register button (only if not completed)
            if (!isCompleted)
              Center(
                child: ElevatedButton(
                  onPressed: isRegistered
                      ? null
                      : () {
                    ref
                        .read(eventsProvider.notifier)
                        .register(current.id);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '✅ Registered for ${current.title}!',
                          style: GoogleFonts.poppins(),
                        ),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isRegistered
                        ? Colors.grey[400]
                        : AppColors.primary,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    isRegistered ? 'Registered' : 'Register Now',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 30),

            // ⭐ Feedback section (only for completed tab)
            if (isCompleted && widget.fromCompletedTab)
              _buildFeedbackSection(context, current),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedbackSection(BuildContext context, EventModel event) {
    return Card(
      color: Colors.grey[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 1.5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rate this Event',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),

            // ⭐ Star Rating
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(5, (i) {
                return IconButton(
                  onPressed: () {
                    setState(() => _rating = i + 1.0);
                  },
                  icon: Icon(
                    Icons.star_rounded,
                    color: i < _rating ? Colors.amber : Colors.grey[400],
                    size: 32,
                  ),
                );
              }),
            ),

            const SizedBox(height: 10),

            // 💬 Feedback text field
            TextField(
              controller: _feedbackController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Share your feedback...',
                hintStyle: GoogleFonts.poppins(color: Colors.grey[600]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),

            const SizedBox(height: 12),

            // 🚀 Submit Button
            ElevatedButton(
              onPressed: () {
                final updatedEvent = event
                  ..rating = _rating
                  ..feedback = _feedbackController.text;

                ref.read(eventsProvider.notifier).updateEvent(updatedEvent);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('✅ Feedback submitted successfully!'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size(double.infinity, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Submit Feedback',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
/*import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:palette_generator/palette_generator.dart';
import '../models/event_model.dart';
import '../providers/event_provider.dart';
import '../constants/colors.dart';
import '../widgets/custom_bottom_navbar.dart';

class EventDetailScreen extends ConsumerStatefulWidget {
  final EventModel event;
  final bool fromCompletedTab;

  const EventDetailScreen({
    Key? key,
    required this.event,
    this.fromCompletedTab = false,
  }) : super(key: key);

  @override
  ConsumerState<EventDetailScreen> createState() =>
      _EventDetailScreenState();
}

class _EventDetailScreenState extends ConsumerState<EventDetailScreen> {
  double _rating = 0;
  final TextEditingController _feedbackController = TextEditingController();
  PaletteGenerator? _palette;

  @override
  void initState() {
    super.initState();
    _rating = widget.event.rating;
    _feedbackController.text = widget.event.feedback;
    _generatePalette();
  }

  Future<void> _generatePalette() async {
    final generator = await PaletteGenerator.fromImageProvider(
      widget.event.posterUrl.startsWith('http')
          ? NetworkImage(widget.event.posterUrl)
          : AssetImage(widget.event.posterUrl) as ImageProvider,
      size: const Size(200, 150),
    );
    setState(() => _palette = generator);
  }

  @override
  Widget build(BuildContext context) {
    final events = ref.watch(eventsProvider);
    final current = events.firstWhere(
          (e) => e.id == widget.event.id,
      orElse: () => widget.event,
    );

    final bool isCompleted =
        current.isAttended || current.dateTime.isBefore(DateTime.now());
    final bool isRegistered = current.isRegistered;

    final Color startColor =
        _palette?.dominantColor?.color ?? const Color(0xFF14213D);
    final Color endColor =
        _palette?.vibrantColor?.color ?? const Color(0xFFFCA311);

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          current.title,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [startColor, endColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ------------------ Poster ------------------
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Opacity(
                        opacity: 0.30,
                        child: widget.event.posterUrl.startsWith('http')
                            ? Image.network(widget.event.posterUrl,
                            fit: BoxFit.cover)
                            : Image.asset(widget.event.posterUrl,
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Hero(
                      tag: 'poster_${widget.event.id}',
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: widget.event.posterUrl.startsWith('http')
                            ? Image.network(widget.event.posterUrl,
                            fit: BoxFit.contain)
                            : Image.asset(widget.event.posterUrl,
                            fit: BoxFit.contain),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ------------------ Title ------------------
            Text(
              current.title,
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              current.club,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),

            const SizedBox(height: 12),

            // ------------------ Date & Location ------------------
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  '${current.dateTime.day}/${current.dateTime.month}/${current.dateTime.year}',
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.location_on, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Text(current.location,
                    style: GoogleFonts.poppins(fontSize: 14)),
              ],
            ),

            const SizedBox(height: 20),

            // ------------------ Description ------------------
            Text(
              current.description,
              style: GoogleFonts.poppins(
                fontSize: 15,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 30),

            // ------------------ Register Button ------------------
            if (!isCompleted)
              ElevatedButton(
                onPressed: isRegistered
                    ? null
                    : () {
                  ref
                      .read(eventsProvider.notifier)
                      .register(current.id);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '✅ Registered for ${current.title}',
                        style: GoogleFonts.poppins(),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isRegistered
                      ? Colors.grey[400]
                      : AppColors.primary,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  isRegistered ? 'Registered' : 'Register Now',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),

            const SizedBox(height: 30),

            // ------------------ Feedback Section ------------------
            if (isCompleted && widget.fromCompletedTab)
              _buildFeedbackSection(current),

            const SizedBox(height: 80), // FIX CUT-OFF ISSUE
          ],
        ),
      ),
    );
  }

  // FEEDBACK SECTION -------------------------------
  Widget _buildFeedbackSection(EventModel event) {
    return Card(
      color: AppColors.accentGreen.withOpacity(0.12), // light green background
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 1.5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rate this Event',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.accentGreen,
              ),
            ),

            const SizedBox(height: 10),

            // ⭐ Rating (Accent Green)
            Row(
              children: List.generate(
                5,
                    (i) => IconButton(
                  onPressed: () => setState(() => _rating = i + 1.0),
                  icon: Icon(
                    Icons.star_rounded,
                    size: 32,
                    color: i < _rating
                        ? AppColors.accentGreen
                        : Colors.grey[400],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: _feedbackController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Share your feedback...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // SUBMIT BUTTON (original color)
            ElevatedButton(
              onPressed: () {
                final updatedEvent = event
                  ..rating = _rating
                  ..feedback = _feedbackController.text;

                ref.read(eventsProvider.notifier).updateEvent(updatedEvent);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Feedback submitted!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary, // KEEP ORIGINAL COLOR
                minimumSize: const Size(double.infinity, 45),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                'Submit Feedback',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:palette_generator/palette_generator.dart';
import '../models/event_model.dart';
import '../providers/event_provider.dart';
import '../constants/colors.dart';
import '../widgets/custom_bottom_navbar.dart';

class EventDetailScreen extends ConsumerStatefulWidget {
  final EventModel event;
  final bool fromCompletedTab;

  const EventDetailScreen({
    Key? key,
    required this.event,
    this.fromCompletedTab = false,
  }) : super(key: key);

  @override
  ConsumerState<EventDetailScreen> createState() =>
      _EventDetailScreenState();
}

class _EventDetailScreenState extends ConsumerState<EventDetailScreen> {
  double _rating = 0;
  final TextEditingController _feedbackController = TextEditingController();
  PaletteGenerator? _palette;

  @override
  void initState() {
    super.initState();
    _rating = widget.event.rating;
    _feedbackController.text = widget.event.feedback;
    _generatePalette();
  }

  Future<void> _generatePalette() async {
    final generator = await PaletteGenerator.fromImageProvider(
      widget.event.posterUrl.startsWith('http')
          ? NetworkImage(widget.event.posterUrl)
          : AssetImage(widget.event.posterUrl) as ImageProvider,
      size: const Size(200, 150),
    );
    setState(() => _palette = generator);
  }

  @override
  Widget build(BuildContext context) {
    final events = ref.watch(eventsProvider);
    final current = events.firstWhere(
          (e) => e.id == widget.event.id,
      orElse: () => widget.event,
    );

    final bool isCompleted =
        current.isAttended || current.dateTime.isBefore(DateTime.now());
    final bool isRegistered = current.isRegistered;

    final Color startColor =
        _palette?.dominantColor?.color ?? const Color(0xFF14213D);
    final Color endColor =
        _palette?.vibrantColor?.color ?? const Color(0xFFFCA311);

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        title: Text(
          current.title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [startColor, endColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------- Poster ----------
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Opacity(
                        opacity: 0.30,
                        child: widget.event.posterUrl.startsWith('http')
                            ? Image.network(widget.event.posterUrl,
                            fit: BoxFit.cover)
                            : Image.asset(widget.event.posterUrl,
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Hero(
                      tag: 'poster_${widget.event.id}',
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: widget.event.posterUrl.startsWith('http')
                            ? Image.network(widget.event.posterUrl,
                            fit: BoxFit.contain)
                            : Image.asset(widget.event.posterUrl,
                            fit: BoxFit.contain),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ---------- Title ----------
            Row(
              children: [
                Expanded(
                  child: Text(
                    current.title,
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              height: 3,
              width: 60,
              decoration: BoxDecoration(
                color: AppColors.accentGreen,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            Text(
              current.club,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 16),

            // ---------- Date & Location ----------
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  '${current.dateTime.day}/${current.dateTime.month}/${current.dateTime.year}',
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.location_on, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Text(current.location,
                    style: GoogleFonts.poppins(fontSize: 14)),
              ],
            ),

            const SizedBox(height: 20),

            // ---------- Description ----------
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Text(
                current.description,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  height: 1.5,
                  color: Colors.black87,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // ---------- Register Button ----------
            if (!isCompleted)
              ElevatedButton(
                onPressed: isRegistered
                    ? null
                    : () {
                  ref
                      .read(eventsProvider.notifier)
                      .register(current.id);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '✅ Registered for ${current.title}',
                        style: GoogleFonts.poppins(),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isRegistered
                      ? Colors.grey[400]
                      : AppColors.primary,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 4,
                ),
                child: Text(
                  isRegistered ? 'Registered' : 'Register Now',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),

            const SizedBox(height: 40),

            // ---------- Feedback Section ----------
            if (isCompleted && widget.fromCompletedTab)
              _buildFeedbackSection(current),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  // 🌿 FEEDBACK SECTION (Enhanced UI)
  Widget _buildFeedbackSection(EventModel event) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: AppColors.accentGreen.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.accentGreen.withOpacity(0.25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rate this Event',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.accentGreen,
            ),
          ),
          const SizedBox(height: 12),

          // ⭐ Rating stars
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(5, (i) {
              return IconButton(
                onPressed: () => setState(() => _rating = i + 1.0),
                icon: Icon(
                  Icons.star_rounded,
                  color:
                  i < _rating ? AppColors.accentGreen : Colors.grey[400],
                  size: 34,
                ),
              );
            }),
          ),

          const SizedBox(height: 10),

          // 💬 Feedback Input
          TextField(
            controller: _feedbackController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Share your feedback...',
              filled: true,
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: AppColors.accentGreen, width: 1.5),
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: AppColors.accentGreen.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // 🚀 Submit Button (same color, lifted)
          ElevatedButton(
            onPressed: () {
              final updatedEvent = event
                ..rating = _rating
                ..feedback = _feedbackController.text;

              ref.read(eventsProvider.notifier).updateEvent(updatedEvent);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('✅ Feedback submitted successfully!')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              minimumSize: const Size(double.infinity, 48),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Text(
              'Submit Feedback',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

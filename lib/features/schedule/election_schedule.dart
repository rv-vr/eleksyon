import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eleksyon/components/constants.dart';
import 'package:intl/intl.dart';
import '../sample_data/schedule.dart';

class ElectionSchedulePage extends StatefulWidget {
  const ElectionSchedulePage({super.key});

  @override
  State<ElectionSchedulePage> createState() => _ElectionSchedulePageState();
}

class _ElectionSchedulePageState extends State<ElectionSchedulePage> {
  final _schedule = electionSchedule;

  String _formatEventDate(DateTime start, DateTime? end) {
    final DateFormat dayFormatter = DateFormat('MMM d, yyyy');
    final DateFormat timeFormatter = DateFormat('h:mm a');
    String formattedStartDay = dayFormatter.format(start);
    String formattedStartTime = (start.hour == 0 && start.minute == 0) ? "" : " at ${timeFormatter.format(start)}";

    if (end == null) return '$formattedStartDay$formattedStartTime';

    String formattedEndDay = dayFormatter.format(end);
    String formattedEndTime = (end.hour == 0 && end.minute == 0) ? "" : " at ${timeFormatter.format(end)}";

    if (formattedStartDay == formattedEndDay) {
      return '$formattedStartDay (from ${timeFormatter.format(start)} to ${timeFormatter.format(end)})'.replaceAll(" at 12:00 AM", ""); // Cleaner for full day events
    }
    return '$formattedStartDay$formattedStartTime - $formattedEndDay$formattedEndTime';
  }

  @override
  Widget build(BuildContext context) {
    _schedule.sort((a, b) => a.startDate.compareTo(b.startDate)); // Ensure chronological order

    return Scaffold(
      appBar: AppBar(
        title: Text('Election Schedule', style: GoogleFonts.inter(fontWeight: FontWeight.w900, color: Constants.secondaryColor)),
        backgroundColor: Constants.primaryColor,
        elevation: 1.0,
        iconTheme: const IconThemeData(color: Constants.secondaryColor),
      ),
      body: _schedule.isEmpty
          ? Center(child: Text('Election schedule is not yet available.', style: GoogleFonts.inter(fontSize: 16, color: Colors.grey)))
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _schedule.length,
              itemBuilder: (context, index) {
                final event = _schedule[index];
                bool isPast = event.endDate?.isBefore(DateTime.now()) ?? event.startDate.isBefore(DateTime.now());
                return Opacity(
                  opacity: isPast ? 0.65 : 1.0,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Constants.primaryColor.withAlpha(isPast ? 10 : 25),
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: Constants.primaryColor.withAlpha(isPast ? 40 : 60)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(event.icon, color: Constants.primaryColor, size: 32),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                event.title,
                                style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w800, color: Constants.primaryColor),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                _formatEventDate(event.startDate, event.endDate),
                                style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                event.description,
                                style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[700]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}